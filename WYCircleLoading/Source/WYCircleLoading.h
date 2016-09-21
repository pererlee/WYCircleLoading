//
//  WYCircleLoading.h
//  WYCircleLoading
//
//  Created by lixiao on 16/9/20.
//  Copyright © 2016年 lixiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WYCircleLoadingDelegate;
@interface WYCircleLoading : UIView
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign, readonly) BOOL isAnimating;
@property (nonatomic, weak) id<WYCircleLoadingDelegate>delegate;
@property (nonatomic, strong) NSString *des;
- (void)startAnimation;
@end

@protocol WYCircleLoadingDelegate <NSObject>
@optional
- (void)circleLoadingSkipClicked;
- (void)circleLoadingFinished;
@end
