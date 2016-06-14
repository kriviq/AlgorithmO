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

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            self.navigationItem.title = detail.description
        }
        
        //TESTING VIEWS!!!!
        
        var testArray = [1, 2, 4, 5, 6, 234, 62];
        
//        let arrayView = ArrayView.init(arrayToVisualise: testArray)
//        arrayView.frame = CGRectMake(50, 100, self.view.frame.width - 100, 40)
//        arrayView.update()
        self.arrayView = ArrayView.init(frame: CGRectMake(50, 100, self.view.frame.width - 100, 40))
    
        self.arrayView!.array = [1,5 ,6, 7]
        
        self.view.addSubview(self.arrayView!)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "testArrays", userInfo: nil, repeats: false)
//        UIView.animateWithDuration(5, delay: 100, options: .CurveEaseInOut, animations: {
//            arrayView.array = testArray
//            }) { (YES) in }
        
    }
    
    func testArrays() {
        self.arrayView!.array = [1, 2, 4, 5, 6, 234, 62]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

