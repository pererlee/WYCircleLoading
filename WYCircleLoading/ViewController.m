//
//  ViewController.m
//  WYCircleLoading
//
//  Created by lixiao on 16/9/20.
//  Copyright © 2016年 lixiao. All rights reserved.
//

#import "ViewController.h"
#import "WYCircleLoading.h"

@interface ViewController ()<WYCircleLoadingDelegate>
@property(nonatomic,strong)WYCircleLoading *circle;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.circle = [[WYCircleLoading alloc] initWithFrame:CGRectMake(60, 20, 32, 32)];
    self.circle.delegate = self;
    [self.view addSubview:self.circle];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 60, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClicked{
    [self.circle startAnimation];
}

- (void)circleLoadingSkipClicked{
    NSLog(@"%s",__FUNCTION__);
}

- (void)circleLoadingFinished{
    NSLog(@"%s",__FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
