//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by studentuser on 5/11/16.
//  Copyright © 2016 Vincent Wu. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {

    var correct : Int = 0
    var total : Int = 0
    
    @IBOutlet weak var resultText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultText.text = "Nice!\nYou answered \(correct) out of \(total) questions correctly."
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
