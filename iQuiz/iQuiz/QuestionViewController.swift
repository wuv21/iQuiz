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
        nextQuestion.enabled = true
        submitBtn.enabled = false
        
        print(index)
        
        if Int(answerSelection.titleForSegmentAtIndex(answerSelection.selectedSegmentIndex)!) == questions[index].correctAnswer {
            responseLabel.text = "Correct! Press next to continue."
            score.correct = score.correct + 1
        } else {
            responseLabel.text = "Incorrect! Correct answer was \(questions[index].correctAnswer)."
        }
    }
    
    @IBAction func nextPress(sender: UIButton) {
        index = index + 1
        submitBtn.enabled = true
        nextQuestion.enabled = false
        
        if index >= questions.count {
            index = 0;
            
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let destination = storyboard.instantiateViewControllerWithIdentifier("FinishedScene") as! FinishedViewController
            
            destination.correct = score.correct
            destination.total = score.total
            
            self.presentViewController(destination, animated: true, completion: nil)
            
            
        } else {
            nextQuestion.enabled = false
            question.text = questions[index].text
            
            
            var answerString = "1) " + questions[index].possibleAnswers[0]
            
            for answer in 1...questions[0].possibleAnswers.count - 1 {
                answerString = answerString + "\n" + String(answer + 1) + ") " + questions[index].possibleAnswers[answer];
            }
            
            responseLabel.text = ""
            answers.text = answerString
            
        }
    }
    
    @IBOutlet weak var answers: UITextView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var nextQuestion: UIButton!
    @IBOutlet weak var answerSelection: UISegmentedControl!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    
    var subject : String = ""
    var questionNum : Int = 0
    var index : Int = 0;
    
    var parsedAnswers : [[String]] = []
    var parsedAnswerIndices : [Int] = []
    var questions : [Question] = []
    var score : Score = Score()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navBar.topItem!.title = subject
        question.text = questions[0].text
        index = 0
        
        score.correct = 0
        score.total = questions.count

        var answerString = "1) " + questions[0].possibleAnswers[0]
        
        for answer in 1...questions[0].possibleAnswers.count - 1 {
            answerString = answerString + "\n" + String(answer + 1) + ") " + questions[0].possibleAnswers[answer];
        }
        
        responseLabel.text = ""
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
