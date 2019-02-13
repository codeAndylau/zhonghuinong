//
//  CollectionViewCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
        updateUI()
    }
    
    
    func makeUI() {
        self.layer.masksToBounds = true
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
}
