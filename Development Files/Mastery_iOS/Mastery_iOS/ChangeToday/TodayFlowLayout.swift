//
//  TodayFlowLayout.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-27.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TodayFlowLayout: UICollectionViewFlowLayout {

    var insertingIndexPaths = [IndexPath]()
    var deletingIndexPaths = [IndexPath]()

    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        insertingIndexPaths.removeAll()
        deletingIndexPaths.removeAll()
        
        for update in updateItems {
            if let indexPath = update.indexPathAfterUpdate,
                update.updateAction == .insert {
                insertingIndexPaths.append(indexPath)
            }
            if let indexPath = update.indexPathBeforeUpdate, update.updateAction == .delete {
                deletingIndexPaths.append(indexPath)
            }
        }
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        
        insertingIndexPaths.removeAll()
        deletingIndexPaths.removeAll()
    }
    
    override func initialLayoutAttributesForAppearingItem(
        at itemIndexPath: IndexPath
        ) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        
        if insertingIndexPaths.contains(itemIndexPath) {
            attributes?.alpha = 0.0
            attributes?.transform = CGAffineTransform(
                translationX: 0,
                y: 500.0
            )
        }
        
        return attributes
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)

        if deletingIndexPaths.contains(itemIndexPath) {
            attributes?.alpha = 1.0
            attributes?.transform = CGAffineTransform(
                translationX: 0,
                y: 500.0
            )
        }

        return attributes
    }
}
