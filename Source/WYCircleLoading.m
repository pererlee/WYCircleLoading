//
//  WYCircleLoading.m
//  WYCircleLoading
//
//  Created by lixiao on 16/9/20.
//  Copyright © 2016年 lixiao. All rights reserved.
//

#import "WYCircleLoading.h"
@interface WYCircleLoading ()
@property (nonatomic, assign) CGFloat anglePer;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation WYCircleLoading

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setAnglePer:(CGFloat)anglePer{
    _anglePer = anglePer;
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)startAnimation{
    if (self.isAnimating) {
        [self stopAnimation];
        [self.layer removeAllAnimations];
    }
    _isAnimating = YES;
    self.anglePer = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.04f
                                                  target:self
                                                selector:@selector(drawPathAnimation:)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopAnimation{
    _isAnimating = NO;
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)drawPathAnimation:(NSTimer *)timer{
    self.anglePer += 0.04f;
    if (self.anglePer >= 1) {
        self.anglePer = 1;
        [timer invalidate];
        self.timer = nil;
        if ([self.delegate respondsToSelector:@selector(circleLoadingFinished)]) {
            [self.delegate circleLoadingFinished];
        }
    }
}

- (void)drawRect:(CGRect)rect {
    if (self.anglePer <= 0) {
        _anglePer = 0;
    }
    CGFloat lineWidth = 1.f;
    UIColor *lineColor = [UIColor redColor];
    NSString *text = @"跳过";
    if (self.lineWidth) {
        lineWidth = self.lineWidth;
    }
    if (self.lineColor) {
        lineColor = self.lineColor;
    }
    if (self.des) {
        text = self.des;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置灰色背景
    CGContextSetRGBFillColor(context, 0.5, 0.5, 0.5, 0.7);
    CGContextFillEllipseInRect(context, CGRectMake(lineWidth, lineWidth, CGRectGetWidth(self.bounds)-lineWidth*2, CGRectGetHeight(self.bounds)-lineWidth*2));
    
    //设置文字
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary*attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                               NSForegroundColorAttributeName:[UIColor whiteColor],
                               NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.bounds), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    [text drawWithRect:CGRectMake(CGRectGetMidX(self.bounds)-size.width/2.0, CGRectGetMidY(self.bounds)-size.height/2.0,size.width, size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    //画外围的红色进度
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextAddArc(context,
                    CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds),
                    CGRectGetWidth(self.bounds)/2-lineWidth,
                    0, 2*M_PI*self.anglePer,
                    0);
    CGContextStrokePath(context);
}

- (void)tap{
    [self stopAnimation];
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.anglePer = 0;
        self.alpha = 1;
        if ([self.delegate respondsToSelector:@selector(circleLoadingSkipClicked)]) {
            [self.delegate circleLoadingSkipClicked];
        }
    }];
}

@end
