//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by blankens on 11/8/15.
//  Copyright © 2015 Adobe. All rights reserved.
//
import UIKit
import Foundation

class AnswerViewController: UIViewController {
    
    lazy var quiz: Quiz = Quiz()
    
    var questionIndex = 0
    var score = 0
    var isCorrect = false
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var checkAnswer: UILabel!
    @IBOutlet weak var solution: UILabel!
    
    @IBAction func didSelectNext(sender: AnyObject) {
        if questionIndex == quiz.questions.count - 1 {
            print("Segue to Final Page")
            performSegueWithIdentifier("FinalPageSegue", sender: self)
        } else {
            print("Segue to Next Question")
            self.questionIndex++
            performSegueWithIdentifier("NextQuestionSegue", sender: self)
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NextQuestionSegue" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            controller.quiz = self.quiz
            controller.score = self.score
            controller.questionIndex = self.questionIndex
        } else {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! FinalScreenViewController
            controller.score = self.score
            controller.total = self.quiz.questions.count
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.backBarButtonItem = nil
        
        self.solution.text = "Solution: \(self.quiz.questions[questionIndex].answer)"
        self.question.text = self.quiz.questions[questionIndex].question
        if !isCorrect {
            checkAnswer.text! = "Incorrect"
            checkAnswer.textColor = UIColor.redColor()
        } else {
            score++
        }
    }
}