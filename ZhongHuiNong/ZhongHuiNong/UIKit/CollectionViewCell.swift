//
//  CollectionViewCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    func makeUI() {
        self.layer.masksToBounds = true
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
}
