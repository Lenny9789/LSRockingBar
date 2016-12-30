//
//  LSRockingBar.swift
//  LSRockingBar
//
//  Created by 刘爽 on 16/12/27.
//  Copyright © 2016年 MZJ. All rights reserved.
//

import UIKit

@objc protocol LSRockingBarViewProtocol : class,NSObjectProtocol  {

    @objc func LSRockingBarViewSliderOffset(X: CGFloat, Y: CGFloat) -> Void
}

protocol LSSliderImageViewProtocol : class,NSObjectProtocol {

    func LSSliderImageViewOffset(offsetX :CGFloat, offsetY :CGFloat) ->Void
}

enum LSRockingBarMoveDirection {
    case LSRockingBarMoveDirectionHorizontal
    case LSRockingBarMoveDirectionVertical
    case LSRockingBarMoveDirectionAll
    
}

class LSRockingBarView: UIView, LSSliderImageViewProtocol{
    ///delegate/
    public weak var delegate :LSRockingBarViewProtocol?
    
    ///背景色
    public var sliderBackGroundColor :UIColor = UIColor.red
    ///图片
    public let sliderBGImage :UIImage = UIImage()
    private var minimumDismeter : CGFloat = 0
    private var centerPoint : CGPoint  = CGPoint()
    
    
    
    init(frame:CGRect, direction:LSRockingBarMoveDirection) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        let width : CGFloat = frame.size.width
        let height : CGFloat = frame.size.height
        
        minimumDismeter = width > height ? height : width
        self.layer.cornerRadius = minimumDismeter / 2
        self.clipsToBounds = true
        
        let imageView = LSSliderImageView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.addSubview(imageView)
        imageView.deleagte = self
        imageView.backgroundColor = sliderBackGroundColor
        imageView.image = sliderBGImage
        imageView.moveDirection = direction
        imageView.superFrame = frame
        imageView.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func LSSliderImageViewOffset(offsetX: CGFloat, offsetY: CGFloat) {
        NSLog("offsetX:%f offsetY:%f", offsetX,offsetY)
        if (delegate?.responds(to: #selector(self.delegate?.LSRockingBarViewSliderOffset(X:Y:))))! {
            delegate?.LSRockingBarViewSliderOffset(X: offsetX, Y: offsetY)
        }
    }
    
    

}

class LSSliderImageView: UIImageView{
    
    
    ///父视图范围
    fileprivate var superFrame :CGRect = CGRect()
    ///滑动方向/move direction
    fileprivate var moveDirection :LSRockingBarMoveDirection = .LSRockingBarMoveDirectionAll
    
    private var beginPoint : CGPoint = CGPoint()
    
    fileprivate weak var deleagte :LSSliderImageViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let diameter : CGFloat = frame.size.width >= frame.size.height ? frame.size.height : frame.size.width
        self.layer.cornerRadius = diameter / 2
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch :UITouch = touches.first!
        beginPoint = touch .location(in: self)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let currentPoint : CGPoint = (touch?.location(in: self))!
        var frame : CGRect = self.frame
        let centerStatic :CGPoint = CGPoint(x: self.superFrame.size.width / 2, y: self.superFrame.size.height / 2)
        let center :CGPoint = self.center
        var offsetX :CGFloat = 0, offsetY :CGFloat = 0
        var dist:CGFloat
        
        if moveDirection == .LSRockingBarMoveDirectionHorizontal {
            
            frame.origin.x += currentPoint.x - beginPoint.x
            dist = (self.superFrame.size.width - self.frame.size.width) / 2
            offsetX = (center.x - centerStatic.x) / dist
        }
        if moveDirection == .LSRockingBarMoveDirectionVertical {
            
            frame.origin.y += currentPoint.y - beginPoint.y
            dist = (self.superFrame.size.height - self.frame.size.height) / 2
            offsetY = (center.y - centerStatic.y) / dist
        }
        if moveDirection == .LSRockingBarMoveDirectionAll {
            
            frame.origin.x += currentPoint.x - beginPoint.x
            frame.origin.y += currentPoint.y - beginPoint.y
            dist = (self.superFrame.size.width - self.frame.size.width) / 2
            offsetX = (center.x - centerStatic.x) / dist
            dist = (self.superFrame.size.height - self.frame.size.height) / 2
            offsetY = (center.y - centerStatic.y) / dist
        }
        
        self.frame = frame
        offsetX =  offsetX >= 1.0 ? 1.0 : offsetX;
        offsetX = offsetX <= -1.0 ? -1.0 : offsetX;
        offsetY = offsetY >= 1.0 ? 1.0 : offsetY;
        offsetY = offsetY <= -1.0 ? -1.0 : offsetY;
        
        deleagte?.LSSliderImageViewOffset(offsetX: offsetX, offsetY: offsetY)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.1, animations: {
            self.center = CGPoint(x: self.superFrame.size.width / 2, y: self.superFrame.size.height / 2)
        })
    }
}


