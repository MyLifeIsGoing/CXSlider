//
//  CXSlider.h
//  CXSlider
//
//  Created by 柴炫炫 on 16/5/3.
//  Copyright © 2016年 柴炫炫. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - Block

typedef void(^ValueBlock)(float value);


#pragma mark - Delegate

@class CXSlider;

@protocol CXSliderDelegate <NSObject>

-(void)cxSliderValueChanged:(CGFloat)value;

@end


@interface CXSlider : UIView

// 回调
@property (nonatomic) ValueBlock valueBlock;
@property (nonatomic) id <CXSliderDelegate> delegate;

/**
 *  设置滑块实际轨迹颜色
 *
 *  @param color 滑块实际轨迹颜色
 */

-(void)setMinimumTrackColorWithColor:(UIColor *)color;

/**
 *  设置滑块实际轨迹颜色
 *
 *  @param hexString 滑块实际轨迹颜色代码
 */

-(void)setMinimumTrackColorWithHexString:(NSString *)hexString;

/**
 *  设置滑块最大轨迹颜色
 *
 *  @param color 滑块最大轨迹颜色
 */

-(void)setMaximumTrackColorWithColor:(UIColor *)color;

/**
 *  设置滑块最大轨迹颜色
 *
 *  @param hexString 滑块最大轨迹颜色代码
 */

-(void)setMaximumTrackColorWithHexString:(NSString *)hexString;

/**
 *  设置滑块图片
 *
 *  @param thumbimage 滑块图片
 */

-(void)setThumbWithThumbImage:(UIImage *)thumbimage;

/**
 *  设置滑块颜色及滑块边框颜色
 *
 *  @param thumbColor  滑块颜色
 *  @param borderColor 滑块边框颜色
 */

-(void)setThumbWithThumbColor:(UIColor *)thumbColor borderColor:(UIColor *)borderColor;

/**
 *  设置滑块颜色及滑块边框颜色
 *
 *  @param thumbColor  滑块颜色代码
 *  @param borderColor 滑块边框颜色代码
 */

-(void)setThumbWithThumbHexString:(NSString *)thumbHexString borderHexString:(NSString *)borderHexString;

// 滑块值
-(void)setValueWithValue:(CGFloat)value;

/**
 *  设置滑块边框宽度
 *
 *  @param borderWidth 滑块边框宽度
 */

-(void)setBorderWidthWithWidth:(CGFloat)borderWidth;

/**
 *  设置滑块轨迹高度
 *
 *  @param trackHeight 滑块轨迹高度
 */

-(void)setTrackHeightWithHeight:(CGFloat)trackHeight;

/**
 *  设置最大值,最小值
 *
 *  @param minimumValue 最小值
 *  @param maximumValue 最大值
 */

-(void)setMinimumValue:(CGFloat)minimumValue maximumValue:(CGFloat)maximumValue;

@end

