//
//  PointView.m
//  ChainStyleLogin
//
//  Created by 姜饼不甜 on 2017/8/25.
//  Copyright © 2017年 姜饼不甜. All rights reserved.
//

#import "PointView.h"


@interface PointView()
@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;
@property(nonatomic) CGFloat duration;
@property(nonatomic) NSTimer *timer;
@property(nonatomic) CGFloat widthAndHeight;
@end

@implementation PointView {
    CGSize screenSize;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addDispatchSourceTimer];
}

- (void)config {
    screenSize = [UIScreen mainScreen].bounds.size;
    self.widthAndHeight = [self randomSize];
    self.x = [self randomIncrement];
    self.y = [self randomIncrement];
    self.layer.cornerRadius = self.widthAndHeight / 2;
    self.backgroundColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1];
    self.layer.borderColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1].CGColor;
    self.layer.borderWidth = 1;
    self.frame = CGRectMake([self randomPoint].x, [self randomPoint].y, self.widthAndHeight, self.widthAndHeight);
    
}

- (void)addDispatchSourceTimer {
    
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 60 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self changePoint];
        }];
    }
    
}
//改变当前View的坐标
- (void)changePoint {
    CGPoint currentPoint = self.frame.origin;
    if (currentPoint.x > screenSize.width - self.widthAndHeight || currentPoint.x < 0) {
        self.x = - self.x;
    }
    if (currentPoint.y > screenSize.height - self.widthAndHeight || currentPoint.y <0) {
        self.y = - self.y;
    }
    currentPoint.x += self.x;
    currentPoint.y += self.y;
    self.frame = CGRectMake(currentPoint.x, currentPoint.y, self.widthAndHeight, self.widthAndHeight);
    
    if (self.updateViewsBlock) {
        self.updateViewsBlock(self.tag);
    }
}


//设置回调更新
- (void)setUpDateBlock:(UpdateViewBlock) updateBLock {
    self.updateViewsBlock = updateBLock;
}
//随机生成大小
- (CGFloat)randomSize {
    return 5 + arc4random_uniform(15);
}

//随机生成x或者y的增量
- (CGFloat)randomIncrement {
    if (arc4random() % 2 == 0) {
        return 0.7;
    } else {
        return -0.7;
    }
}

//随机生成点坐标
- (CGPoint)randomPoint {
    return CGPointMake(arc4random_uniform(screenSize.width - self.widthAndHeight), arc4random_uniform(screenSize.height - self.widthAndHeight));
}


- (void)dealloc {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
