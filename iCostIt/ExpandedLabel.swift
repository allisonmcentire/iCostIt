//
//  ExpandedLabel.swift
//  draggie
//
//  Created by Allison Mcentire on 1/25/17.
//  Copyright © 2017 com.millionacrenest. All rights reserved.
//

import UIKit

class ExpandedLabel: UILabel {
    
    
    
    override var intrinsicContentSize: CGSize {
        
        let size = super.intrinsicContentSize
        
        // you can change 'addedHeight' into any value you want.
        let addedHeight = font.pointSize * 0.3
        
        return CGSize(width: size.width, height: size.height + addedHeight)
    }
    
}
