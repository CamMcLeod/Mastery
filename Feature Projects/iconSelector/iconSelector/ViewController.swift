//
//  ViewController.swift
//  iconSelector
//
//  Created by Cameron Mcleod on 2019-07-23.
//  Copyright © 2019 Cameron Mcleod. All rights reserved.
//

import UIKit

protocol IconSaveDelegate {
    func setNewImage (image: UIImage)
}

class ViewController: UIViewController, IconSaveDelegate {

    

    @IBOutlet weak var setImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "presentIcons":
            let nextVC = segue.destination as! IconSelectorPopoverViewController
            nextVC.incomingIcon = setImage.image
            nextVC.iconDelegate = self
        default:
            fatalError()
        }
    }
    
    func setNewImage(image: UIImage) {
        setImage.image = image
    }

}

