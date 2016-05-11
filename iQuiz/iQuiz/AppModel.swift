//
//  AppModel.swift
//  iQuiz
//
//  Created by iGuest on 5/9/16.
//  Copyright © 2016 Vincent Wu. All rights reserved.
//

import Foundation

class QuizContent {
    var content : Array<Dictionary<String, AnyObject>> = [];
    
    var subjects : [String] = []
    var subjectsDescriptions : [String] = []
    
    func getData() {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://tednewardsandbox.site44.com/questions.json")!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    
                    guard let category = json as? [[String:AnyObject]] else {return}
                    
                    for c in category {
                        guard let subject = c["title"] as? String,
                            let desc = c["desc"] as? String,
                            let questions = c["questions"] else {return}
                        
                        
                        self.subjects.append(subject)
                        self.subjectsDescriptions.append(desc)
                        
//                        self.content.append(c)
                    }
                    
                } catch {
                    print("Error with Json: \(error)")
                }
//                print(self.subjects)

            }
            
            
        }
        
        task.resume()
    }
    
}
