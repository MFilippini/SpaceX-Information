//
//  DetailView.swift
//  SpaceX Information
//
//  Created by Michael Filippini on 7/11/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit

class DetailView: UIViewController {

    @IBOutlet weak var detailTextBox: UITextView!
    
    var details : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTextBox.text = details
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
