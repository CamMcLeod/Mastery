//
//  SelectIconPopoverViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

protocol IconSaveDelegate {
    func setNewImage (image: UIImage)
}

class SelectIconPopoverViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectedTaskIcon: TaskIcon!
    @IBOutlet weak var stackView: UIStackView!
    
    var iconDelegate: IconSaveDelegate?
    var incomingIcon: UIImage?
    
    var allIcons: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.layer.borderWidth = 5
        collectionView.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1)
        collectionView.layer.cornerRadius = 15.0
        
        // Do any additional setup after loading the view.
        
        guard let bundleURL = Bundle.main.url(forResource: "TaskIcons", withExtension: "bundle") else { return }
        guard let bundle = Bundle(url: bundleURL) else { return }
        guard let imageURLs = bundle.urls(forResourcesWithExtension: ".png", subdirectory: nil) else { return }
        
        for imageURL in imageURLs {
            guard let image = UIImage(contentsOfFile: imageURL.path) else { continue }
            allIcons.append(image)
            print(image)
        }
        
        selectedTaskIcon.iconSetup(icon: incomingIcon, iconColor: #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1))
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allIcons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let iconCell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectIconCell", for: indexPath) as! SelectIconCell
        
        iconCell.configure(with: allIcons[indexPath.row])
        
        return iconCell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! SelectIconCell
        selectedTaskIcon.iconSetup(icon: selectedCell.taskIcon!.iconImage.image, iconColor: #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let sideSpacing = layout.minimumInteritemSpacing * 2 + layout.sectionInset.left + layout.sectionInset.right
        let size = (self.view.frame.width - sideSpacing - 40) / 3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func cancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        if let newImage = selectedTaskIcon.iconImage.image {
            
            self.iconDelegate?.setNewImage(image: newImage)
            self.dismiss(animated: true, completion: nil)
        }
        
    }

}
