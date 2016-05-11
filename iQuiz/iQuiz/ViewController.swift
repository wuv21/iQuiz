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

    
    var model = QuizContent()
    var subjects : [String] = []
    var subjectsDescriptions : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        subjectsTable.dataSource = self
        subjectsTable.delegate = self
        
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
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        for c in category {
                            guard let subject = c["title"] as? String,
                                let desc = c["desc"] as? String,
                                let questions = c["questions"] else {return}
                            
                            
                            self.subjects.append(subject)
                            self.subjectsDescriptions.append(desc)
    
                        }
                        
                        print(self.subjects)
                        self.subjectsTable.reloadData()
                    }
                    
                } catch {
                    print("Error with Json: \(error)")
                }
                //                print(self.subjects)
                
            }
        }
        
        print(self.subjects)
        
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

