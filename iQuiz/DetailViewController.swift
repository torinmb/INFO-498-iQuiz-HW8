//
//  DetailViewController.swift
//  iQuiz
//
//  Created by blankens on 10/29/15.
//  Copyright © 2015 Adobe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var next: UIBarButtonItem!

    var selectedIndex = 0
    var questionIndex = 0
    var score = 0

    lazy var quiz: Quiz = Quiz()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        self.detailDescriptionLabel.text = self.quiz.descr
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellIdentifier = "HeaderCell"
        var headerCell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell?
        if headerCell == nil {
            headerCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier) as UITableViewCell
        }
        let label = headerCell!.textLabel!
        label.text = quiz.questions[questionIndex].question
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(18.0)
        return headerCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        if cell!.accessoryType == UITableViewCellAccessoryType.None {
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            selectedIndex = indexPath.row
            next.enabled = true
        } else {
            cell!.accessoryType = UITableViewCellAccessoryType.None
            next.enabled = false
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryType = UITableViewCellAccessoryType.None
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quiz.questions[questionIndex].answers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell?
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier) as UITableViewCell
        }
        let answer = quiz.questions[questionIndex].answers[indexPath.row]
        cell!.textLabel!.text = answer as! String

        return cell!
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! != "homeSegue" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! AnswerViewController
            let question = self.quiz.questions[questionIndex]
            controller.isCorrect = (selectedIndex == Int(question.answer)! - 1)
            controller.score = self.score
            controller.questionIndex = self.questionIndex
            controller.quiz = self.quiz

        }
    }

}