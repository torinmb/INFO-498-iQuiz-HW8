//
//  MasterViewController.swift
//  iQuiz
//
//  Created by blankens on 10/29/15.
//  Copyright © 2015 Adobe. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct defaultsKeys {
    static let localStorageKey = "LocalStorageKey"
}

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var quizzes : [Quiz] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        let settings = UIBarButtonItem(image: UIImage(named: "Settings"), style: .Plain, target: self, action: "selectedSettings:")
        self.navigationItem.rightBarButtonItem = settings
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()

        if let stringOne = defaults.stringForKey(defaultsKeys.localStorageKey) {
            parseData(stringOne)
            print("LOADING FROM LOCAL STORAGE")
        } else {
            print("FETCHING DATA")
            self.fetchData("http://tednewardsandbox.site44.com/questions.json")
        }
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)

    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        self.quizzes = []
        self.fetchData("http://tednewardsandbox.site44.com/questions.json")
        refreshControl.endRefreshing()
    }
    
    @IBAction func unwindtoVC(segue: UIStoryboardSegue){
        
    }
    
    func fetchData(url: String) {
        Alamofire.request(.GET, url).responseString() { response in
            switch response.result {
            case .Success:
                
                if let value = response.result.value {
                    
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setValue(String(value), forKey: defaultsKeys.localStorageKey)
                    defaults.synchronize()
                    self.parseData(value)
                    print("SAVING DATA TO LOCAL STORAGE")
                }
                
                
            case .Failure(let error):
                print(error)
            }
            self.tableView.reloadData()
        }
    }
    
    func parseData(data: AnyObject) {
        if let dataFromString = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            let data = json.array
            
            for quizData in data! {
                let quiz = Quiz()
                quiz.title = quizData["title"].stringValue
                quiz.descr = quizData["desc"].stringValue
                
                for questionData in quizData["questions"].array! {
                    let question = Question(question: questionData["text"].stringValue, answer: questionData["answer"].stringValue, answers: questionData["answers"].array!.map { $0.stringValue})
                    quiz.questions.append(question)
                }
                self.quizzes.append(quiz)
            }
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func selectedSettings(sender: AnyObject) {
        self.performSegueWithIdentifier("SettingsSegue", sender: self)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let quiz = quizzes[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.quiz = quiz
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.navigationItem.title = quiz.title
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell?
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier) as UITableViewCell
        }
        let quiz = quizzes[indexPath.row]
        cell!.textLabel!.text = quiz.title
        cell!.detailTextLabel!.text = quiz.descr
        return cell!
    }
}

