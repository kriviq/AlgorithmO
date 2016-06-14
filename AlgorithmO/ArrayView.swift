//
//  ArrayView.swift
//  AlgorithmO
//
//  Created by Ivan Yanakiev on 6/13/16.
//  Copyright © 2016 Kriviq. All rights reserved.
//

import UIKit

class ArrayView: UIView {
    
    var array:Array<NSInteger>? {
        didSet {
            // Update the view.
            self.update()
        }
        
        
    }

    
//    dynamic var myDate = NSDate()
    
//    func updateDate() {
//        self.update()
//    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    required convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    init(arrayToVisualise array:Array<NSInteger>) {
        self.array = array
        super.init(frame:CGRect.zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func update() {
        self.removeSubviews()
        
        let elementWidth = self.frame.width / CGFloat(self.array!.count)
        let elementHeight = self.frame.height
        var currentElementX:CGFloat = 0.0
        for arrayElement in self.array! {
            let frame = CGRectMake(currentElementX, 0, elementWidth, elementHeight)
            let newElement = self.arrayElementView(number: arrayElement, frame: frame)
            self.addSubview(newElement)
            
            currentElementX += elementWidth
        }
    }
    
    func arrayElementView(number number:NSInteger, frame:CGRect) -> UIView {
        let elementNumber = UILabel.init(frame: frame)
        elementNumber.textColor = UIColor.redColor()
        elementNumber.textAlignment = .Center
        elementNumber.text = String.localizedStringWithFormat("%d", number)
        elementNumber.layer.borderColor = UIColor.blackColor().CGColor
        elementNumber.layer.borderWidth = 1
        
        return elementNumber;
    }
    
}
