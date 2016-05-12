//
//  AppModel.swift
//  iQuiz
//
//  Created by iGuest on 5/9/16.
//  Copyright © 2016 Vincent Wu. All rights reserved.
//

import Foundation

class Question {
    var correctAnswer : Int
    var text : String
    var possibleAnswers : [String]
    
    init(ans: Int, txt: String, posAns: [String]) {
        self.correctAnswer = ans
        self.text = txt
        self.possibleAnswers = posAns
    }
}

class QuizContent {
    var content : Array<Dictionary<String, AnyObject>> = [];
    
    var subjects : [String] = []
    var subjectsDescriptions : [String] = []
    var questions : [[Question]] = []
    
    var url : String = "http://tednewardsandbox.site44.com/questions.json"
    
    func getData(completionHandler: () -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            let httpResponse = response as? NSHTTPURLResponse
            let statusCode = httpResponse?.statusCode
            
            if (statusCode == 200) {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    
                    guard let category = json as? [[String:AnyObject]] else {return}
                    
                    for c in category {
                        guard let subject = c["title"] as? String,
                            let desc = c["desc"] as? String,
                            let questions = c["questions"] as? [AnyObject] else {return}
                        
                        var x : [Question] = []
                        
                        for question in questions {
                            guard let correctAnswerIndex = question["answer"] as? String,
                                let answers = question["answers"] as? [String],
                                let question = question["text"] as? String else {return}
                        
                            let q = Question(ans: Int(correctAnswerIndex)!, txt: question, posAns: answers)
                            x.append(q)
                        }
                        
                        
                        self.subjects.append(subject)
                        self.subjectsDescriptions.append(desc)
                        self.questions.append(x)
                    }
                    
                    completionHandler()
                    
                } catch {
                    print("Error with Json: \(error)")
                }

            }
        }

        task.resume()
    }
}

class Score {
    var correct : Int = 0
    var total : Int = 0
}