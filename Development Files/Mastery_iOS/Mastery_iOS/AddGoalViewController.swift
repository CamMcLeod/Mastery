////
////  AddGoalViewController.swift
////  Mastery_iOS
////
////  Created by Ekam Singh Dhaliwal on 2019-07-23.
////  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
////
//
//import UIKit
//
//class AddGoalViewController: UIViewController {
//
//    @IBOutlet var goalName: UITextField!
//    @IBOutlet var purpose: UITextView!
//    @IBOutlet var purposeTwo: UITextView!
//    @IBOutlet var purposeThree: UITextView!
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//
//        
//    }
//    
//
// 
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goalDetails" {
//            if let dc = segue.destination as? AddGoalDetailsViewController {
//                dc.goalName = goalName.text
//                dc.purpose = purpose.text
//                dc.purposeTwo = purposeTwo.text
//                dc.purposeThree = purposeThree.text
//            }
//        }
//        
//    }
// 
//
//}
