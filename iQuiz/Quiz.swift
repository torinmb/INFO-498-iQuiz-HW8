//
//  Question.swift
//  iQuiz
//
//  Created by Weschler, Sabrina on 11/6/15.
//  Copyright (c) 2015 Adobe. All rights reserved.
//

import Foundation
import RealmSwift


class Quiz {
    var title: String = ""
    var descr: String = ""
    var questions : [Question]
    
    convenience required init() {
        self.init(title: "", descr: "", questions : [])
    }
    
    init(title: String, descr: String, questions :  [Question]) {
        self.title = title
        self.descr = descr
        self.questions = questions
    }
    
}