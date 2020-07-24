//
//  StudyViewController.swift
//  BJ Trainer
//
//  Created by Daniel Davies on 4/27/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class StudyViewController: UIViewController {

    @IBAction func returnButton(_ sender: Any) {
        performSegue(withIdentifier: "studyToMainSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
