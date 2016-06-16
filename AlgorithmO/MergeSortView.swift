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
    
    
    var initialArray:Array<NSInteger>? {
        didSet {
            self.update()
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
    
    func update() {
        self.subviews.forEach({ $0.removeFromSuperview() })
        self.visualizeMergeSort(self.initialArray!, row: 0, column: 0)
    }
    
    func visualizeMergeSort(array: Array<NSInteger>, row: NSInteger, column: NSInteger) {
        let numberOfColumns = Int(pow(Double(2),Double(row)))
        let numberOfRows = Int(log2(Double(self.initialArray!.count))) + 1
        let columnWidth = (self.frame.width / CGFloat(numberOfColumns));
        
        let Xcoordinate = columnWidth * CGFloat(column)
        let columnCenter = Xcoordinate + (columnWidth / 2)
        let Ycoordinate = /*(self.frame.height / CGFloat(numberOfRows))*/ 80 * CGFloat(row) + 80
        
        let arrayViewFrame = CGRectMake(Xcoordinate + 5, Ycoordinate, /*columnWidth - 10*/ CGFloat(array.count * 40) , 40)
        let arrayView = ArrayView.init(frame: arrayViewFrame)
        
        if (row > 0) {
            let parentCenter = self.parentCenter(row, column: column)
            arrayView.center = parentCenter
        }
        
        arrayView.layer.borderWidth = 3
        arrayView.layer.borderColor = UIColor.redColor().CGColor
        self.addSubview(arrayView)
        arrayView.array = array

        UIView.animateWithDuration(1) { () -> Void in
            arrayView.center = CGPointMake(columnCenter, Ycoordinate + 20)
        }
        
        UIView.animateWithDuration(1, delay: 1, options: .CurveEaseInOut, animations: { () -> Void in
            arrayView.center = CGPointMake(columnCenter, Ycoordinate + 20)
            }) { (finished) -> Void in
                if (finished) {
                    if (array.count == 1 && row < numberOfRows ) {
                        self.visualizeMergeSort(array, row: row + 1, column: column * 2)
                        return
                    }
                    else if (array.count == 1 ) {
                        return
                    }
                    
                    let middleIndex = array.count / 2
                    let leftSubArray = Array<NSInteger>(array[0...(middleIndex - 1)])
                    let rightSubArray = Array<NSInteger>(array[middleIndex...(array.count - 1)])
                    self.visualizeMergeSort(leftSubArray, row: row + 1, column: column * 2)
                    self.visualizeMergeSort(rightSubArray, row: row + 1, column: column * 2 + 1)
                }

        }
//        UIView.animateWithDuration(1, animations: { () -> Void in
//            arrayView.center = CGPointMake(columnCenter, Ycoordinate + 20)
//            }) { (YES) -> Void in
//                if (array.count == 1 && row < numberOfRows ) {
//                    self.visualizeMergeSort(array, row: row + 1, column: column * 2)
//                    return
//                }
//                else if (array.count == 1 ) {
//                    return
//                }
//                
//                let middleIndex = array.count / 2
//                let leftSubArray = Array<NSInteger>(array[0...(middleIndex - 1)])
//                let rightSubArray = Array<NSInteger>(array[middleIndex...(array.count - 1)])
//                self.visualizeMergeSort(leftSubArray, row: row + 1, column: column * 2)
//                self.visualizeMergeSort(rightSubArray, row: row + 1, column: column * 2 + 1)
//        }
    }
    
    func centerAndSizeForArray(row row: NSInteger, column:NSInteger) -> (CGPoint, CGSize) {
        return (CGPoint.zero, CGSize.zero)
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
