//
//  BackView.m
//  ChainStyleLogin
//
//  Created by 姜饼不甜 on 2017/8/25.
//  Copyright © 2017年 姜饼不甜. All rights reserved.
//

#import "BackView.h"
#import "PointView.h"

@interface BackView()

@property(nonatomic) NSInteger codeCount;
@property(nonatomic) CGFloat range;
@property(nonatomic) NSMutableArray<PointView *> *codeViews;
@property(nonatomic) NSMutableArray<UIBezierPath *> *beziers;

@end


@implementation BackView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:246/255.0 green:249/255.0 blue:252/255.0 alpha:1];
        [self commonInit];
        [self addSubViews];
    }
    return self;
}

- (void)commonInit {
    self.codeCount = 15;
    self.range = 60;
    self.codeViews = [NSMutableArray array];
    self.beziers = [NSMutableArray array];
}
- (void)addSubViews {
    for (int i = 0 ; i < self.codeCount; i++) {
        [self addCodeView:i center:CGPointZero];
    }
}

- (void)addCodeView:(NSInteger) tag center:(CGPoint) center {
    [self.beziers addObject:[UIBezierPath  new]];
    PointView *codeView = [[PointView alloc] initWithFrame:CGRectZero];
    codeView.tag = tag;
    codeView.updateViewsBlock = ^(NSInteger index) {
        [self drawLine:index];
    };
    [self addSubview:codeView];
    [self.codeViews addObject:codeView];
    
}


//画线
- (void)drawLine:(NSInteger) index {
    NSArray <NSValue *> *points = [self areaPoints:index];
    
    NSMutableArray <NSMutableArray <NSNumber *> *> *graph = [NSMutableArray array];
    
    UIBezierPath *bezier = self.beziers[index];
    [bezier removeAllPoints];
    
    for (int i = 0 ; i < points.count ; i++) {
        NSMutableArray <NSNumber *> *tmp = [NSMutableArray array];
        
        for(int j = 0 ; j < points.count ; j++) {
            [tmp addObject:@(NO)];
        }
        [graph addObject:tmp];
    }
    
    for (int i = 0 ; i < points.count ; i++) {
        for(int j = 0 ; j < points.count ; j++) {
            if (i != j && ![graph[i][j] boolValue]) {
                [bezier moveToPoint:[points[i] CGPointValue]];
                [bezier addLineToPoint:[points[j] CGPointValue]];
                graph[i][j] = @(YES);
                graph[j][i] = @(YES);
            }
        }
    }
    
    [self setNeedsDisplay];
}

//计算在某个点周边可以连线的点
- (NSArray <NSValue *>*)areaPoints:(NSInteger)index {
    NSMutableArray *points = [NSMutableArray array];
    for (PointView *item in self.codeViews) {
        CGFloat distance = [self countDistance:self.codeViews[index].center :item.center];
        if (distance < self.range) {
            [points addObject:[NSValue valueWithCGPoint:item.center]];
        }
    }
    return points;
}

- (void)drawRect:(CGRect)rect {
    for (int i = 0 ; i < self.beziers.count ; i++) {
        [[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1] setStroke];
        self.beziers[i].lineWidth = 0.3;
        [self.beziers[i] stroke];
    }
}
//计算两点之间的距离
- (CGFloat)countDistance:(CGPoint)point1 :(CGPoint)point2 {
    CGFloat x = pow(point1.x - point2.x, 2);
    CGFloat y = pow(point1.x  - point2.x , 2);
    return sqrt(x + y);
}

@end
