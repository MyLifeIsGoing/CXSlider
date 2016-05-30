//
//  ViewController.m
//  CXSlider
//
//  Created by 柴炫炫 on 16/5/30.
//  Copyright © 2016年 柴炫炫. All rights reserved.
//

#import "ViewController.h"
#import "CXSlider.h"


@interface ViewController () <CXSliderDelegate> {
    UILabel * slider_value;
}

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat x = 15;
    CGFloat y = 100;
    CGFloat w = 60;
    CGFloat h = 20;
    
    // 创建 Label
    slider_value = [[UILabel alloc] initWithFrame:CGRectMake(width - w - x, y, w, h)];
    slider_value.text = @"20";
    slider_value.textColor = [UIColor grayColor];
    slider_value.font = [UIFont boldSystemFontOfSize:15];
    slider_value.textAlignment = NSTextAlignmentCenter;
    slider_value.numberOfLines = 0;
    slider_value.lineBreakMode = NSLineBreakByCharWrapping;
    
    CGSize slider_value_size = [slider_value sizeThatFits:CGSizeMake(9999, h)];
    CGRect slider_value_frame = slider_value.frame;
    
    w = slider_value_size.width + 5;
    slider_value_frame.origin.x = width - w - x;
    slider_value_frame.size.width = w;
    
    slider_value.frame = slider_value_frame;
    [self.view addSubview:slider_value];
    
    // 创建 CXSlider
    
    CXSlider *slider = [[CXSlider alloc] initWithFrame:CGRectMake(x, y, width - x*2 - (w+x), h)];
    
    [slider setMinimumValue:10 maximumValue:20];
    //    [slider setMinimumTrackColorWithColor:[UIColor blueColor]];
    //    [slider setMaximumTrackColorWithColor:[UIColor redColor]];
    //    [slider setThumbWithThumbColor:[UIColor greenColor] borderColor:[UIColor yellowColor]];
    //    [slider setThumbWithImage:[UIImage imageNamed:@"slider_thumg"]];
    //    [slider setValueWithValue:.35];
    //    [slider setBorderWidthWithWidth:5];
    //    [slider setTrackHeightWithHeight:10];
    
    //    // Block
    //    slider.valueBlock = ^(float value){
    //        NSLog(@"cxSliderValueChanged:%f",value);
    //    };
    
    // Delegate
    slider.delegate = self;
    
    [self.view addSubview:slider];
}


#pragma mark - CXSliderDelegate

-(void)cxSliderValueChanged:(CGFloat)value
{
    slider_value.text = [NSString stringWithFormat:@"%.f",value];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

