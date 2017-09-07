//
//  ViewController.m
//  ChainStyleBackGroundView
//
//  Created by 姜饼不甜 on 2017/9/7.
//  Copyright © 2017年 姜饼不甜. All rights reserved.
//

#import "ViewController.h"
#import "BackView.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)loadView {
    self.view =  [[BackView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
