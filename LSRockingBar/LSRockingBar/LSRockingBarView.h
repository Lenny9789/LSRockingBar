//
//  LSRockingBarView.h
//  LSRockingBar
//
//  Created by 刘爽 on 16/12/26.
//  Copyright © 2016年 MZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@protocol LSRockingBarViewDelegate

- (void)LSRockingBarViewOffsetX:(CGFloat)x offsetY:(CGFloat)y;
@end

@protocol LSSliderImageViewDelegate

- (void)sliderImageViewOffsetX:(CGFloat)x offsetY:(CGFloat)y;
@end
/// 可以移动的方向/ The direction of mobile
typedef enum : NSUInteger {
    LSRockingBarMoveDirectionHorizontal = 0,
    LSRockingBarMoveDirectionVertical,
    LSRockingBarMoveDirectionAll,
} LSRockingBarMoveDirection;


@interface LSRockingBarView : UIView <LSSliderImageViewDelegate>

///滑块的大小尺寸--直径
@property (nonatomic, assign) NSInteger sliderDiameter;

///滑块的image/
@property (nonatomic, strong) UIImage *sliderImage;

///滑块的背景色
@property (nonatomic, strong) UIColor *sliderbackgroundColor;

/// 初始化方法，/ init method
- (instancetype)initWithFrame:(CGRect)frame AndDirection:(LSRockingBarMoveDirection)direction;

@property (nonatomic, weak) id <LSRockingBarViewDelegate> delegate;
@end





@interface LSSliderImageView : UIImageView <UIGestureRecognizerDelegate>

@property (nonatomic, assign) UIBezierPath *superBezierPath;

@property (nonatomic, assign) CGRect superFrame;

///视图滑动方向
@property (nonatomic, assign) LSRockingBarMoveDirection moveDirection;

@property (nonatomic, weak) id <LSSliderImageViewDelegate> delegate;
@end

