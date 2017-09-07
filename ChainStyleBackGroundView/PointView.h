//
//  PointView.h
//  ChainStyleLogin
//
//  Created by 姜饼不甜 on 2017/8/25.
//  Copyright © 2017年 姜饼不甜. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^UpdateViewBlock)(NSInteger);

@interface PointView : UIView

@property(nonatomic,copy) UpdateViewBlock updateViewsBlock;
@end
