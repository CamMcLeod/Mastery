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
    @IBOutlet var name: UIView!
//    var numberOfTasks: Int!

    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
        let numberOfCellsPerRow: CGFloat = 4
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (collectionView.frame.width - max(0, numberOfCellsPerRow - 1)*horizontalSpacing)/numberOfCellsPerRow
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
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
