//
//  MergeSortView.swift
//  AlgorithmO
//
//  Created by Ivan Yanakiev on 6/13/16.
//  Copyright © 2016 Kriviq. All rights reserved.
//

import UIKit

class MergeSortView: UIView {
    
    var mergeSortData:Array<Array<NSInteger>>?

    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    required convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    init(dataToVisualize data:Array<Array<NSInteger>>) {
        self.mergeSortData = data
        super.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
