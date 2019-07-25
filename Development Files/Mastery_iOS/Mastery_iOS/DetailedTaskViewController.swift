//
//  DetailedTaskViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-25.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class DetailedTaskViewController: UIViewController {
    
    var task: Task?

    @IBOutlet var testNameView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let name = task?.name else {
            print("No name found, mate")
            return
        }
        testNameView.text = name

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addNewTask(_ sender: UIButton) {
    }
    



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        
    }
   

}
