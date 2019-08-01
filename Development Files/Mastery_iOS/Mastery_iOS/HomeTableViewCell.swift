//
//  HomeTableViewCell.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-24.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var name: UILabel!
    @IBOutlet var details: UIButton!
//    var numberOfTasks: Int!

    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
        collectionView.layoutIfNeeded()
        
//        print("What the hell is going on")
        
       
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}


//extension HomeTableViewCell {
//    func setCollectionViewDataSourceDelegate <D:UICollectionViewDelegate & UICollectionViewDataSource>
//        (_ dataSourceDelegate: D, forRow row:Int) {
//        
//        collectionView.delegate = dataSourceDelegate
//        collectionView.dataSource = dataSourceDelegate
//        collectionView.tag =
//        collectionView.reloadData()
//    }
//}
