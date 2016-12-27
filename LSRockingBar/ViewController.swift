//
//  ViewController.swift
//  LSRockingBar
//
//  Created by 刘爽 on 16/12/27.
//  Copyright © 2016年 MZJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,LSRockingBarViewProtocol{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = UIColor.blue
        let rockview1 = LSRockingBarView(frame:CGRect(x: 100, y: 100, width: 320, height: 50), direction: .LSRockingBarMoveDirectionHorizontal)
        self.view.addSubview(rockview1)
        rockview1.sliderBackGroundColor = UIColor.cyan
        rockview1.delegate = self
        let rockview2 = LSRockingBarView(frame: CGRect(x: 50, y: 200, width: 50, height: 300), direction: .LSRockingBarMoveDirectionVertical)
        self.view.addSubview(rockview2)
        rockview2.sliderBackGroundColor = UIColor.brown
        rockview2.delegate = self
        let rockview3 = LSRockingBarView(frame: CGRect(x: 100, y: 200, width: 300, height: 300), direction: .LSRockingBarMoveDirectionAll)
        self.view.addSubview(rockview3)
        rockview3.sliderBackGroundColor = UIColor.red
        rockview3.delegate = self
        // Do any additional setup after loading the view.
    }

    func LSRockingBarViewSliderOffset(X: CGFloat, Y: CGFloat) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
