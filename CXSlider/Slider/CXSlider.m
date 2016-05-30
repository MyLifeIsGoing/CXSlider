//
//  CXSlider.m
//  CXSlider
//
//  Created by 柴炫炫 on 16/5/3.
//  Copyright © 2016年 柴炫炫. All rights reserved.
//

#import "CXSlider.h"
#import "UIColor+Hex.h"


#define kThumbImageWidth    self.bounds.size.height
#define kMaximumImageHeight 5


@interface CXSlider () {
    CGFloat _minimum_value;
    CGFloat _maximum_value;
}

@property (nonatomic, strong) UIImageView *maximumImage;
@property (nonatomic, strong) UIImageView *minimumImage;
@property (nonatomic, strong) UIImageView *thumbImage;

@end


@implementation CXSlider


#pragma mark - Life Cycle

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) [self loadSubViews];
    return self;
}


#pragma mark - Loading UI

-(void)loadSubViews
{
    // 默认设置
    self.backgroundColor = [UIColor clearColor];
    
    _minimum_value = 0.0;
    _maximum_value = 1.0;
    
    // 添加滑块最大轨迹
    _maximumImage = [[UIImageView alloc] initWithFrame:CGRectMake(kThumbImageWidth/2, (self.bounds.size.height - kMaximumImageHeight)/2, self.bounds.size.width - kThumbImageWidth/2*2, kMaximumImageHeight)];
    _maximumImage.backgroundColor = [UIColor lightGrayColor];
    _maximumImage.layer.cornerRadius = kMaximumImageHeight/2;
    _maximumImage.layer.masksToBounds = YES;
    [self addSubview:_maximumImage];
    
    // 添加滑块实际轨迹
    _minimumImage = [[UIImageView alloc] initWithFrame:CGRectMake(kThumbImageWidth/2, (self.bounds.size.height-kMaximumImageHeight)/2, self.bounds.size.width-kThumbImageWidth/2*2, kMaximumImageHeight)];
    _minimumImage.backgroundColor = [UIColor colorWithHexString:@"#D9B3B3"];
    _minimumImage.layer.cornerRadius = kMaximumImageHeight/2;
    _minimumImage.layer.masksToBounds = YES;
    [self addSubview:_minimumImage];
    
    // 添加滑块
    _thumbImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - kThumbImageWidth, 0, kThumbImageWidth, kThumbImageWidth)];
    _thumbImage.backgroundColor = [UIColor whiteColor];
    _thumbImage.layer.cornerRadius = kThumbImageWidth/2;
    _thumbImage.layer.masksToBounds = YES;
    _thumbImage.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.35].CGColor;
    _thumbImage.layer.borderWidth = (kThumbImageWidth/2)/2;
    _thumbImage.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_thumbImage addGestureRecognizer:pan];
    [self addSubview:_thumbImage];
}


#pragma mark - Custom Methods

-(void)pan:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        [self resetTouchImageWithPoint:[recognizer locationInView:self]];
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        [self resetTouchImageWithPoint:[recognizer locationInView:self]];
    }
}

/**
 *  内部设置 Value 值
 *
 *  @param point 当前位置
 */

-(void)resetTouchImageWithPoint:(CGPoint)point;
{
    CGRect touchImageFrame  = _thumbImage.frame;
    CGRect minmumImageFrame = _minimumImage.frame;
    
    if (point.x <= kThumbImageWidth/2)
    {
        touchImageFrame.origin.x = 0.0;
        minmumImageFrame.size.width = 0.0;
        [self updateValueWithValue:_minimum_value];
    }
    else if (point.x > kThumbImageWidth/2 && point.x < self.bounds.size.width - kThumbImageWidth/2)
    {
        touchImageFrame.origin.x = point.x - kThumbImageWidth/2;
        minmumImageFrame.size.width = point.x - kThumbImageWidth/2;
        [self updateValueWithValue:(_minimum_value+((point.x-kThumbImageWidth/2)/(self.bounds.size.width-kThumbImageWidth)) * (_maximum_value-_minimum_value))];
    }
    else
    {
        touchImageFrame.origin.x = self.bounds.size.width - kThumbImageWidth;
        minmumImageFrame.size.width = self.bounds.size.width - kThumbImageWidth;
        [self updateValueWithValue:_maximum_value];
    }
    
    _thumbImage.frame = touchImageFrame;
    _minimumImage.frame = minmumImageFrame;
    
    [self setNeedsDisplay];
}


#pragma mark - CXSliderDelegate Response

/**
 *  回调 | 代理
 *
 *  @param value 回调数据
 */

-(void)updateValueWithValue:(CGFloat)value
{
    // 设置 Block
    if (_valueBlock)
    {
        _valueBlock(value);
    }
    
    // 设置 Delegate
    if ([self.delegate respondsToSelector:@selector(cxSliderValueChanged:)])
    {
        [self.delegate cxSliderValueChanged:value];
    }
}


#pragma mark - Set Methods

/**
 *  设置当前值
 *
 *  @param value 当前值
 */

-(void)setValueWithValue:(CGFloat)value;
{
    CGRect touchImageFrame = _thumbImage.frame;
    CGRect minmumImageFrame = _minimumImage.frame;
    
    touchImageFrame.origin.x = (self.bounds.size.width - kThumbImageWidth/2)*value;
    minmumImageFrame.size.width = (self.bounds.size.width - kThumbImageWidth/2)*value;
    
    _thumbImage.frame = touchImageFrame;
    _minimumImage.frame = minmumImageFrame;
    
    [self setNeedsDisplay];
}

/**
 *  设置滑块实际轨迹颜色
 *
 *  @param color 滑块实际轨迹颜色
 */

-(void)setMinimumTrackColorWithColor:(UIColor *)color;
{
    _minimumImage.backgroundColor = color;
}

/**
 *  设置滑块实际轨迹颜色
 *
 *  @param hexString 滑块实际轨迹颜色代码
 */

-(void)setMinimumTrackColorWithHexString:(NSString *)hexString;
{
    _minimumImage.backgroundColor = [UIColor colorWithHexString:hexString];
}

/**
 *  设置滑块最大轨迹颜色
 *
 *  @param color 滑块最大轨迹颜色
 */

-(void)setMaximumTrackColorWithColor:(UIColor *)color;
{
    _maximumImage.backgroundColor = color;
}

/**
 *  设置滑块最大轨迹颜色
 *
 *  @param hexString 滑块最大轨迹颜色代码
 */

-(void)setMaximumTrackColorWithHexString:(NSString *)hexString;
{
    _maximumImage.backgroundColor = [UIColor colorWithHexString:hexString];
}

/**
 *  设置滑块图片
 *
 *  @param thumbimage 滑块图片
 */

-(void)setThumbWithThumbImage:(UIImage *)thumbimage;
{
    // 重置 Thumb
    _thumbImage.backgroundColor = [UIColor clearColor];
    _thumbImage.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.35].CGColor;
    _thumbImage.layer.borderWidth = 0;
    
    _thumbImage.image = thumbimage;
}

/**
 *  设置滑块颜色及边框颜色
 *
 *  @param thumbColor  滑块颜色
 *  @param borderColor 滑块边框颜色
 */

-(void)setThumbWithThumbColor:(UIColor *)thumbColor borderColor:(UIColor *)borderColor;
{
    _thumbImage.backgroundColor = thumbColor;
    _thumbImage.layer.borderWidth = (kThumbImageWidth/2)/2;
    _thumbImage.layer.borderColor = borderColor.CGColor;
}

/**
 *  设置滑块颜色及滑块边框颜色
 *
 *  @param thumbColor  滑块颜色代码
 *  @param borderColor 滑块边框颜色代码
 */

-(void)setThumbWithThumbHexString:(NSString *)thumbHexString borderHexString:(NSString *)borderHexString;
{
    _thumbImage.backgroundColor = [UIColor colorWithHexString:thumbHexString];
    _thumbImage.layer.borderWidth = (kThumbImageWidth/2)/2;
    _thumbImage.layer.borderColor = [UIColor colorWithHexString:borderHexString].CGColor;
}

/**
 *  设置滑块边框宽度
 *
 *  @param borderWidth 滑块边框宽度
 */

-(void)setBorderWidthWithWidth:(CGFloat)borderWidth;
{
    _thumbImage.layer.borderWidth = borderWidth;
}

/**
 *  设置滑块轨迹高度
 *
 *  @param trackHeight 滑块轨迹高度
 */

-(void)setTrackHeightWithHeight:(CGFloat)trackHeight;
{
    CGRect minimumImageFrame = _minimumImage.frame;
    CGRect maximumImageFrame = _maximumImage.frame;
    
    CGFloat track_h = trackHeight >= self.frame.size.height ? self.frame.size.height : trackHeight;
    CGFloat track_y = (self.frame.size.height - track_h) / 2;
    
    minimumImageFrame.origin.y = track_y;
    minimumImageFrame.size.height = track_h;
    maximumImageFrame.origin.y = track_y;
    maximumImageFrame.size.height = track_h;
    
    _minimumImage.frame = minimumImageFrame;
    _maximumImage.frame = maximumImageFrame;
    
    _minimumImage.layer.cornerRadius = track_h/2;
    _maximumImage.layer.cornerRadius = track_h/2;
    
    [self setNeedsDisplay];
}

/**
 *  设置最大值,最小值
 *
 *  @param minimumValue 最小值
 *  @param maximumValue 最大值
 */

-(void)setMinimumValue:(CGFloat)minimumValue maximumValue:(CGFloat)maximumValue;
{
    _minimum_value = minimumValue;
    _maximum_value = maximumValue;
}

@end

