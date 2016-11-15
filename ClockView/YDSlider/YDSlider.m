//
//  YDSlider.m
//  YDSliderView
//
//  Created by liuyadi on 2016/11/14.
//  Copyright © 2016年 Geek Zoo Studio. All rights reserved.
//

#import "YDSlider.h"

@interface YDSlider ()

@property (nonatomic, strong) UILabel  *indexLabel;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, assign) SLIDER_INDEX_TYPE type;

@end

@implementation YDSlider

- (instancetype)initWithFrame:(CGRect)frame indexLabelType:(SLIDER_INDEX_TYPE)type {
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self addSubview:self.slider];
        [self addSubview:self.indexLabel];
    }
    return self;
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] initWithFrame:self.bounds];
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (UILabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.textColor = [UIColor blackColor];
        _indexLabel.font = [UIFont systemFontOfSize:10];
        _indexLabel.backgroundColor = [UIColor clearColor];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        
        [self setIndexLabelFrame];
    }
    return _indexLabel;
}

- (void)sliderValueChanged:(UISlider *)slider {
    [self setIndexLabelFrame];
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderValueChanged:)]) {
        [self.delegate sliderValueChanged:self];
    }
}

- (void)setIndexLabelFrame {
    CGRect trackRect = [self.slider trackRectForBounds:self.bounds];
    CGRect thumbRect = [self.slider thumbRectForBounds:self.bounds
                                             trackRect:trackRect
                                                 value:self.slider.value];
    
    self.indexLabel.frame = CGRectMake(0, 0, thumbRect.size.width - 10, thumbRect.size.height - 10);
    if (self.type == SLIDER_INDEX_TYPE_CENTER) {
        self.indexLabel.center = CGPointMake(thumbRect.origin.x + (thumbRect.size.width / 2), thumbRect.origin.y + (thumbRect.size.height / 2));
    } else if (self.type == SLIDER_INDEX_TYPE_TOP) {
        self.indexLabel.center = CGPointMake(thumbRect.origin.x + (thumbRect.size.width / 2), thumbRect.origin.y - 15);
    } else if (self.type == SLIDER_INDEX_TYPE_BOTTOM) {
        self.indexLabel.center = CGPointMake(thumbRect.origin.x + (thumbRect.size.width / 2), thumbRect.origin.y +thumbRect.size.height + 15);
    }
    
    self.indexLabel.text = [NSString stringWithFormat:@"%.0f", self.slider.value];
}

#pragma UISlider

- (float)value {
    return self.slider.value;
}

- (float)minimumValue {
    return self.slider.minimumValue;
}

- (float)maximumValue {
    return self.slider.maximumValue;
}

- (void)setValue:(float)value {
    self.slider.value = value;
}

- (void)setMinimumValue:(float)minimumValue {
    self.slider.minimumValue = minimumValue;
}

- (void)setMaximumValue:(float)maximumValue {
    self.slider.maximumValue = maximumValue;
}

- (UIImage *)minimumValueImage {
    return self.slider.minimumValueImage;
}

- (UIImage *)maximumValueImage {
    return self.slider.maximumValueImage;
}

- (void)setMinimumValueImage:(UIImage *)minimumValueImage {
    self.slider.minimumValueImage = minimumValueImage;
}

- (void)setMaximumValueImage:(UIImage *)maximumValueImage {
    self.slider.maximumValueImage = maximumValueImage;
}

- (BOOL)isContinuous {
    return self.slider.isContinuous;
}

- (void)setContinuous:(BOOL)continuous {
    self.slider.continuous = continuous;
}

- (UIColor *)minimumTrackTintColor {
    return self.slider.minimumTrackTintColor;
}

- (UIColor *)maximumTrackTintColor {
    return self.slider.maximumTrackTintColor;
}

- (UIColor *)thumbTintColor {
    return self.slider.thumbTintColor;
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    self.slider.minimumTrackTintColor = minimumTrackTintColor;
}

- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    self.slider.maximumTrackTintColor = maximumTrackTintColor;
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    self.slider.thumbTintColor = thumbTintColor;
}

- (void)setValue:(float)value animated:(BOOL)animated {
    [self.slider setValue:value animated:animated];
}

- (void)setThumbImage:(nullable UIImage *)image forState:(UIControlState)state {
    [self.slider setThumbImage:image forState:state];
}

- (void)setMinimumTrackImage:(nullable UIImage *)image forState:(UIControlState)state {
    [self.slider setMinimumTrackImage:image forState:state];
}

- (void)setMaximumTrackImage:(nullable UIImage *)image forState:(UIControlState)state {
    [self.slider setMaximumTrackImage:image forState:state];
}

- (nullable UIImage *)thumbImageForState:(UIControlState)state {
    return [self.slider thumbImageForState:state];
}

- (nullable UIImage *)minimumTrackImageForState:(UIControlState)state {
    return [self.slider minimumTrackImageForState:state];
}

- (nullable UIImage *)maximumTrackImageForState:(UIControlState)state {
    return [self.slider maximumTrackImageForState:state];
}

- (UIImage *)currentThumbImage {
    return self.slider.currentThumbImage;
}

- (UIImage *)currentMinimumTrackImage {
    return self.slider.currentMinimumTrackImage;
}

- (UIImage *)currentMaximumTrackImage {
    return self.slider.currentMaximumTrackImage;
}

- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds {
    return [self.slider minimumValueImageRectForBounds:bounds];
}

- (CGRect)maximumValueImageRectForBounds:(CGRect)bounds {
    return [self.slider maximumValueImageRectForBounds:bounds];
}

- (CGRect)trackRectForBounds:(CGRect)bounds {
    return [self.slider trackRectForBounds:bounds];
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    return [self.slider thumbRectForBounds:bounds trackRect:rect value:value];
}

@end
