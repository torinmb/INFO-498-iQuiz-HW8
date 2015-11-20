//
//  FinalScreenViewController.swift
//  iQuiz
//
//  Created by blankens on 11/9/15.
//  Copyright © 2015 Adobe. All rights reserved.

import UIKit
import Foundation

class FinalScreenViewController: UIViewController {
    var score = 0
    var total = 0
    
    @IBOutlet weak var blurb: UILabel!
    @IBOutlet weak var finalScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let total =  1.0 * Double(self.score) / Double(self.total)
        if total == 1.0 {
            self.blurb.text = "Perfect!"
        } else if total > 0.5{
            self.blurb.text = "Almost"
        } else if total == 0 {
            self.blurb.text = "Try Again Next Time"
        } else {
            self.blurb.text = "Good Try"
        }
        self.finalScore.text = "\(self.score) / \(self.total) Correct"
        
    }
}
