//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by blankens on 11/17/15.
//  Copyright © 2015 Adobe. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var urlField: UITextField!
    
    @IBAction func didSelectUpdate(sender: AnyObject) {
        self.resignFirstResponder()
        let view = MasterViewController()
        view.fetchData(self.urlField.text!)
    }
}
