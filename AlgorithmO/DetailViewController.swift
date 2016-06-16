//
//  DetailViewController.swift
//  AlgorithmO
//
//  Created by Ivan Yanakiev on 6/6/16.
//  Copyright © 2016 Kriviq. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    var arrayView:ArrayView?
    
    var mergeSortView:MergeSortView?

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            self.navigationItem.title = detail.description
        }
        
        //TESTING VIEWS!!!!

//        if (self.arrayView == nil) {
//            NSLog("self is %p, called by %@", self, NSThread.callStackSymbols())
//            self.arrayView = ArrayView.init(frame: CGRectMake(50, 100, self.view.frame.width - 100, 40))
//            self.arrayView!.array = [1,5 ,6, 7]
//            
//            self.view.addSubview(self.arrayView!)
//            
//            _ = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "testArrays", userInfo: nil, repeats: false)
//        }
        
        if (self.mergeSortView == nil) {
//            NSLog("self is %p, called by %@", self, NSThread.callStackSymbols())
            self.mergeSortView = MergeSortView.init(frame: self.view.frame)
            self.view.addSubview(self.mergeSortView!)
            self.mergeSortView!.initialArray = [1, 2, 4, 5, 6, 234, 62]
            
            
        }
        
    }
    
    func testArrays() {
        UIView.animateWithDuration(4) { () -> Void in
             self.arrayView!.array = [1, 2, 4, 5, 6, 234, 62]
        }
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

