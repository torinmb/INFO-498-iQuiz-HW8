//
//  Question.swift
//  iQuiz
//
//  Created by Weschler, Sabrina on 11/6/15.
//  Copyright (c) 2015 Adobe. All rights reserved.
//

import Foundation


class Question {
    var question : String = ""
    var answer : String = ""
    
    var answers : [String]

    var answeredQuestion = false
    
    init(question: String, answer : String, answers: [String]){
        self.question = question
        self.answer = answer
        self.answers = answers
    }

    required init() {
        answers = []
    }
}