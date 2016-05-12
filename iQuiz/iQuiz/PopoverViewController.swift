//
//  PopoverViewController.swift
//  iQuiz
//
//  Created by studentuser on 5/11/16.
//  Copyright © 2016 Vincent Wu. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    var url: String = ""
    
    @IBOutlet weak var urlField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlField.text = url
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func checkAction(sender: UIButton) {
        url = urlField.text!
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let destination = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        destination.quizContent.url = url
        
        self.presentViewController(destination, animated: true, completion: nil)
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
