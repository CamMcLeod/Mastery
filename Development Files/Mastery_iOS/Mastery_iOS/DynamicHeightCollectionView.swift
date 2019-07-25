//
//  DynamicHeightCollectionView.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-24.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class DynamicHeightCollectionView: UICollectionView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }

}
