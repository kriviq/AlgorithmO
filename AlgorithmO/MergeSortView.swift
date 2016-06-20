//
//  MergeSortView.swift
//  AlgorithmO
//
//  Created by Ivan Yanakiev on 6/13/16.
//  Copyright © 2016 Kriviq. All rights reserved.
//

import UIKit

class MergeSortView: UIView {
    
    var mergeSortData: Array<Array<NSInteger>>?
    let timerInterval: NSTimeInterval = 1
    let topOffset: CGFloat = 100
    let lineOffset: CGFloat = 80
    let lineHeight: CGFloat = 40
    let elementWidth: CGFloat = 40
    
    var initialArray:Array<NSInteger>? {
        didSet {
            self.subviews.forEach({ $0.removeFromSuperview() })
            self.visualizeMergeSort(self.initialArray!, row: 0, column: 0)
        }
    }

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
    
    func timeSplit(timer: NSTimer) {
        let userInfo = timer.userInfo as! SortViewArguments
        self.visualizeMergeSort(userInfo.array!, row: userInfo.row!, column: userInfo.column!)
    }
    
    func visualizeMergeSort(array: Array<NSInteger>, row: NSInteger, column: NSInteger) {
        let numberOfRows = Int(log2(Double(self.initialArray!.count))) + 1
        let arrayViewFrame = CGRect.zero
        
        let arrayView = ArrayView.init(frame: arrayViewFrame)
        let (center, size) = self.centerAndSizeForArray(array, row: row, column: column);
        arrayView.frame.size = size
        arrayView.center = center
        
        
        arrayView.layer.borderWidth = 3
        arrayView.layer.borderColor = UIColor.redColor().CGColor
        arrayView.alpha = 0
        self.addSubview(arrayView)
        arrayView.array = array
        
        if (row > 0) {
        var (parentCenter, _) = self.centerAndSizeForArray(array, row: row - 1, column: NSInteger(column / 2))
            parentCenter.x += (column % 2 == 1) ? size.width / 2 : -size.width / 2
            arrayView.center = parentCenter;
        }

        UIView.animateWithDuration(1, delay: 1, options: .CurveEaseInOut, animations: { () -> Void in
            arrayView.center = center
            arrayView.alpha = 1
            }) { (finished) -> Void in
                if (finished) {
                    if (array.count == 1 && row < numberOfRows ) {
                        let arguments = SortViewArguments.init()
                        arguments.array = array
                        arguments.row = row + 1
                        arguments.column = column * 2
                        _ = NSTimer.scheduledTimerWithTimeInterval(self.timerInterval, target: self, selector: "timeSplit:", userInfo: arguments, repeats: false);
                        return
                    }
                    else if (array.count == 1 ) {
                        return
                    }
                    
                    let middleIndex = array.count / 2
                    let leftSubArray = Array<NSInteger>(array[0...(middleIndex - 1)])
                    let rightSubArray = Array<NSInteger>(array[middleIndex...(array.count - 1)])
                    
                    let leftArrayArguments = SortViewArguments.init()
                    leftArrayArguments.array = leftSubArray
                    leftArrayArguments.row = row + 1
                    leftArrayArguments.column = column * 2
                    _ = NSTimer.scheduledTimerWithTimeInterval(self.timerInterval, target: self, selector: Selector("timeSplit:"), userInfo: leftArrayArguments, repeats: false);
                    
                    let rightArrayArguments = SortViewArguments.init()
                    rightArrayArguments.array = rightSubArray
                    rightArrayArguments.row = row + 1
                    rightArrayArguments.column = column * 2 + 1
                    _ = NSTimer.scheduledTimerWithTimeInterval(self.timerInterval, target: self, selector: Selector("timeSplit:"), userInfo: rightArrayArguments, repeats: false);
                }

        }
    }
    
    func centerAndSizeForArray(array: Array<NSInteger>, row: NSInteger, column:NSInteger) -> (CGPoint, CGSize) {
        let numberOfColumns = Int(pow(Double(2),Double(row)))
        let columnWidth = (self.frame.width / CGFloat(numberOfColumns));
        
        let yCenter = self.lineOffset * CGFloat(row) + self.topOffset
        let xCenter = columnWidth * CGFloat(column) + (columnWidth / 2)
        let centrPoint = CGPointMake(xCenter, yCenter)
        let size = CGSizeMake(CGFloat(array.count) * self.elementWidth , self.lineHeight)
        
        return (centrPoint, size)
    }
    
    func parentCenter(row: NSInteger, column: NSInteger)  -> CGPoint {
        let numberOfColumns = Int(pow(Double(2),Double(row - 1)))
        let columnWidth = (self.frame.width / CGFloat(numberOfColumns));
        let XOffset: CGFloat = (column % 2 == 1) ? 20 * CGFloat(numberOfColumns) : -20 * CGFloat(numberOfColumns);
        
        let YCenter = 80 * CGFloat(row - 1) + 100
        let XCenter = columnWidth * CGFloat(column / 2) + (columnWidth / 2) + XOffset
        return CGPointMake(XCenter, YCenter)
    }
    
}

class SortViewArguments {
    var array:Array<Int>?
    var row:NSInteger?
    var column:NSInteger?
}
