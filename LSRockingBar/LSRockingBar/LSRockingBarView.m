//
//  LSRockingBarView.m
//  LSRockingBar
//
//  Created by 刘爽 on 16/12/26.
//  Copyright © 2016年 MZJ. All rights reserved.
//

#import "LSRockingBarView.h"

@interface LSRockingBarView()
{
    
}

@end

@implementation LSRockingBarView
{
    NSInteger minimumDiameter;
    CGPoint centerPoint;
    
}

- (instancetype)initWithFrame:(CGRect)frame AndDirection:(LSRockingBarMoveDirection)direction{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        minimumDiameter  = width <= height ? width : height;
//        if (self.sliderDiameter > minimumDiameter / 2) self.sliderDiameter = minimumDiameter / 3;
        self.layer.cornerRadius = minimumDiameter / 2;
        self.clipsToBounds = YES;

        LSSliderImageView *imageView = [[LSSliderImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [self addSubview:imageView];
        imageView.delegate = self;
        imageView.backgroundColor = self.sliderbackgroundColor;
        imageView.image = self.sliderImage;
        imageView.moveDirection = direction;
        imageView.superFrame = frame;
        imageView.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        imageView.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)sliderImageViewOffsetX:(CGFloat)x offsetY:(CGFloat)y{
//    if ([self.delegate respondsToSelector:@selector(LSRockingBarViewOffsetX:offsetY:)]) {
        [self.delegate LSRockingBarViewOffsetX:x offsetY:y];
//    }
}

@end

@implementation LSSliderImageView
{
    CGPoint beginPoint;
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat diameter = frame.size.width >= frame.size.height ? frame.size.height : frame.size.width;
        self.layer.cornerRadius = diameter / 2;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    beginPoint = [touch locationInView:self];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGRect frame = self.frame;
    CGPoint centerStatic = CGPointMake(self.superFrame.size.width / 2, self.superFrame.size.height / 2);
    CGPoint center = self.center;
    CGFloat offsetX = 0, offsetY = 0;
    CGFloat dist;
    if (self.moveDirection == LSRockingBarMoveDirectionHorizontal){
        frame.origin.x += currentPoint.x - beginPoint.x;
        dist = (self.superFrame.size.width - self.frame.size.width) / 2;
        offsetX = (center.x - centerStatic.x) / dist;
    }
    if (self.moveDirection == LSRockingBarMoveDirectionVertical) {
        frame.origin.y += currentPoint.y - beginPoint.y;
        dist = (self.superFrame.size.height - self.frame.size.height) / 2;
        offsetY = (center.y - centerStatic.y) / dist;
    }
    if (self.moveDirection == LSRockingBarMoveDirectionAll) {
        frame.origin.x += currentPoint.x - beginPoint.x;
        frame.origin.y += currentPoint.y - beginPoint.y;
        dist = (self.superFrame.size.width - self.frame.size.width) / 2;
        offsetX = (center.x - centerStatic.x) / dist;
        dist = (self.superFrame.size.height - self.frame.size.height) / 2;
        offsetY = (center.y - centerStatic.y) / dist;
    }
    
    self.frame = frame;
    offsetX =  offsetX >= 1.0 ? 1.0 : offsetX;
    offsetX = offsetX <= -1.0 ? -1.0 : offsetX;
    offsetY = offsetY >= 1.0 ? 1.0 : offsetY;
    offsetY = offsetY <= -1.0 ? -1.0 : offsetY;
    [self.delegate sliderImageViewOffsetX:offsetX offsetY:offsetY];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.1 animations:^{
        self.center = CGPointMake(self.superFrame.size.width / 2, self.superFrame.size.height / 2);
    }];
}


@end
