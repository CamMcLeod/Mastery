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
    @IBOutlet weak var selectIconLabel: UILabel!
    
    var iconDelegate: IconSaveDelegate?
    var incomingIcon: UIImage?
    var goalColor = UIColor()
    
    var allIcons: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.layer.borderWidth = 5
        collectionView.layer.borderColor = goalColor.cgColor
        collectionView.layer.cornerRadius = 15.0
        
        selectIconLabel.layer.borderWidth = 5
        selectIconLabel.layer.borderColor = goalColor.cgColor
        selectIconLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        selectIconLabel.layer.cornerRadius = 15.0
        
        // Do any additional setup after loading the view.
        selectedTaskIcon.isUserInteractionEnabled = false
        
        guard let bundleURL = Bundle.main.url(forResource: "TaskIcons", withExtension: "bundle") else { return }
        guard let bundle = Bundle(url: bundleURL) else { return }
        guard let imageURLs = bundle.urls(forResourcesWithExtension: ".png", subdirectory: nil) else { return }
        
        for imageURL in imageURLs {
            guard let image = UIImage(contentsOfFile: imageURL.path) else { continue }
            allIcons.append(image)
        }
        selectIconLabel.textColor = goalColor
        selectedTaskIcon.iconSetup(icon: incomingIcon, iconColor: goalColor)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissToTaskEdit))
        selectedTaskIcon.addGestureRecognizer(tapGesture)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allIcons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let iconCell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectIconCell", for: indexPath) as! SelectIconCell
        
        iconCell.configure(with: allIcons[indexPath.row], color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        iconCell.layer.borderColor = goalColor.cgColor
        return iconCell
    }
    
    @objc func dismissToTaskEdit() {
        
        dismiss(animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! SelectIconCell
        selectedTaskIcon.iconSetup(icon: selectedCell.taskIcon!.iconImage.image, iconColor: goalColor)
        selectedTaskIcon.animate()
        
        if let newImage = selectedTaskIcon.iconImage.image {
            
            self.iconDelegate?.setNewImage(image: newImage)
        }
        
        selectedTaskIcon.isUserInteractionEnabled = true
        
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
    

}
