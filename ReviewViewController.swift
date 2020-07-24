//
//  ReviewViewController.swift
//  BJ Trainer
//
//  Created by Daniel Davies on 4/27/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    // array of hand combos for review, passed from the main View Controller
    var review_hand_combos:[HandCombo] = []
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var handsTextView: UITextView!
    
    @IBAction func returnButton(_ sender: Any) {
        performSegue(withIdentifier: "reviewToMainSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("hand combos for review")
        for hand_combo in review_hand_combos {
            print(hand_combo.description())
        }
        
        // build the text to show in the handsTextView
        var hand_descriptions:[String] = Array()
        
        // get all hand descriptions and find out which one is the longest
        var longest_description_length = 0
        for cur_hand_combo in review_hand_combos {
            let description = cur_hand_combo.description()
            hand_descriptions.append(description)
            if (description.count > longest_description_length) {longest_description_length = description.count}
        }
        
        // put dots after all hand descriptions so they have the same length
        for i in 0..<hand_descriptions.count {
            var description = hand_descriptions[i]
            while (description.count < longest_description_length) {
                description += "_"
            }
            description += "__"
            hand_descriptions[i] = description
        }
        
        // add the correct action
        for i in 0..<hand_descriptions.count {
            
            let description = hand_descriptions[i] + review_hand_combos[i].best_action

            hand_descriptions[i] = description
        }
        
        var hands_text = String()
        for description in hand_descriptions {
            hands_text += description + "\n"
        }
        handsTextView.text = hands_text
        
    }
    
}
