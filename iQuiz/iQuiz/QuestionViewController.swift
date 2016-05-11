//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by iGuest on 5/9/16.
//  Copyright © 2016 Vincent Wu. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBAction func returnToQuizzes(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let destination = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        
        self.presentViewController(destination, animated: true, completion: nil)
    }
    
    @IBAction func submitButton(sender: UIButton) {
        
    }
    
    
    @IBOutlet weak var answers: UITextView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var nextQuestion: UIButton!
    @IBOutlet weak var answerSelection: UISegmentedControl!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var subject : String = ""
    var questionNum : Int = 0
    var index : Int = 0;
    var questionObjects : [AnyObject] = []
    
    var parsedAnswers : [[String]] = []
    var parsedAnswerIndices : [Int] = []
    var questions : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let rawQuestions = questionObjects as [AnyObject]? else {return}
        
        for rawQuestion in rawQuestions {
            
            guard let correctAnswerIndex = rawQuestion["answer"] as? String,
                let answers = rawQuestion["answers"] as? [String],
                let question = rawQuestion["text"] as? String else {return}
            
            parsedAnswers.append(answers);
            parsedAnswerIndices.append(Int(correctAnswerIndex)!)
            questions.append(question)
        }
        
        navBar.topItem!.title = subject
        question.text = questions[0]
        

        var answerString = "1) " + parsedAnswers[0][0]
        
        for answer in 1...parsedAnswers[0].count - 1 {
            answerString = answerString + "\n" + String(answer + 1) + ") " + parsedAnswers[0][answer];
        }
        
        answers.text = answerString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
