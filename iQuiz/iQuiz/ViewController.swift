//
//  ViewController.swift
//  iQuiz
//
//  Created by studentuser on 5/4/16.
//  Copyright © 2016 Vincent Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var subjectsTable: UITableView!

    
//    var model = QuizContent()
    var subjects : [String] = ["Data Loading"]
    var subjectsDescriptions : [String] = ["Please wait while data is being loaded"]
    let quizContent = QuizContent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        subjectsTable.dataSource = self
        subjectsTable.delegate = self
        
        self.quizContent.getData {
            self.subjects.removeAll()
            self.subjectsDescriptions.removeAll()
            
            self.subjects = self.quizContent.subjects
            self.subjectsDescriptions = self.quizContent.subjectsDescriptions
            
            self.subjectsTable.reloadData()
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = "subjectCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as UITableViewCell?
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        cell!.textLabel?.text = subjects[indexPath.row]
        cell!.detailTextLabel?.text = subjectsDescriptions[indexPath.row]
        cell!.imageView?.image = UIImage(named: "subject_pic.png")
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let destination = storyboard.instantiateViewControllerWithIdentifier("QuestionViewController") as! QuestionViewController
        
        destination.index = row
        destination.subject = subjects[row]
        destination.questionObjects = self.quizContent.questions[row] as! [AnyObject]
        
        self.presentViewController(destination, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func settingsClick(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here.", preferredStyle:UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

