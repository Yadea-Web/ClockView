//
//  LightLoadingView.m
//  ClockView
//
//  Created by liuyadi on 2016/11/10.
//  Copyright © 2016年 Geek Zoo Studio. All rights reserved.
//

#import "LightLoadingView.h"

#define kTimeDuration 5.0

@interface LightLoadingView()

@property (nonatomic, strong) UIColor      *tintColor;
@property (nonatomic, strong) UIColor      *selectedColor;
@property (nonatomic, assign) CGFloat      selectedValue;

@property (nonatomic, strong) CAShapeLayer *selectedCircleLayer;
@property (nonatomic, strong) CAShapeLayer *selectedLightLayer;
@property (nonatomic, strong) CAShapeLayer *pointLayer;

@property (nonatomic, assign) BOOL         animated;
@property (nonatomic, assign) BOOL         isInfineLoop;
@property (nonatomic, assign) CGRect viewFrame;

@property (nonatomic, strong) UILabel *progressLabel;

@end

@implementation LightLoadingView

- (instancetype)initLightLoadingViewWithFrame:(CGRect)frame tintColor:(UIColor *)tintColor selectedColor:(UIColor *)selectedColor value:(CGFloat)value animated:(BOOL)animated {
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor     = tintColor;
        self.selectedColor = selectedColor;
        self.selectedValue = value;
        self.animated = animated;
        self.viewFrame = frame;
    }
    return self;
}

- (void)setProgressValue:(CGFloat)value {
    if (value == 0) {
        [self initLayerPath];
    } else {
        // 里面圆的进度条
        [self setSelectedCircleWithValue:value preValue:self.selectedValue];
        
        // 实际的散光的值
        [self setSelectedLightLineWithValue:value preValue:self.selectedValue];
        
        // 带头的小圆点
        [self setSelectedPointWithValue:value preValue:self.selectedValue];
    }
    
    self.selectedValue = value;
}

- (void)initLayerPath {
    self.selectedCircleLayer.path = nil;
    self.selectedLightLayer.path = nil;
    self.pointLayer.path = nil;
    [self setSelectedPointWithValue:0 preValue:0];
}

- (void)infineLoop {
    self.isInfineLoop = YES;
    [self setProgressValue:0.0];
    [NSTimer scheduledTimerWithTimeInterval:kTimeDuration
                                        target:self
                                      selector:@selector(repeatLoading)
                                      userInfo:nil
                                       repeats:YES];
    [self setProgressValue:1.0];
}

- (void)repeatLoading {
    [self setProgressValue:0.0];
    [self setProgressValue:1.0];
}

#pragma mark - lazy load

- (CAShapeLayer *)pointLayer {
    if (!_pointLayer) {
        _pointLayer       = [[CAShapeLayer alloc] init];
        _pointLayer.frame = self.bounds;
        _pointLayer.fillColor = self.selectedColor.CGColor;
        [self.layer addSublayer:_pointLayer];
    }
    return _pointLayer;
}

- (CAShapeLayer *)selectedCircleLayer {
    if (!_selectedCircleLayer) {
        _selectedCircleLayer = [[CAShapeLayer alloc] init];
        _selectedCircleLayer.frame = self.bounds;
        _selectedCircleLayer.fillColor = nil;
        _selectedCircleLayer.strokeColor = self.selectedColor.CGColor;
        [self.layer addSublayer:_selectedCircleLayer];
    }
    return _selectedCircleLayer;
}

- (CAShapeLayer *)selectedLightLayer {
    if (!_selectedLightLayer) {
        _selectedLightLayer = [[CAShapeLayer alloc] init];
        _selectedLightLayer.frame = self.bounds;
        _selectedLightLayer.fillColor = nil;
        _selectedLightLayer.strokeColor = self.selectedColor.CGColor;
        [self.layer addSublayer:_selectedLightLayer];
    }
    return _selectedLightLayer;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        CGFloat radius = self.viewFrame.size.width / 2;
        _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, radius, radius)];
        _progressLabel.center = CGPointMake(radius, radius);
        _progressLabel.textColor = self.selectedColor;
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_progressLabel];
    }
    return _progressLabel;
}

- (void)setProgressLabelFont:(UIFont *)progressLabelFont {
    self.progressLabel.font = progressLabelFont;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 整个圆
    [self setNormalCircle];
    
    // 里面圆的进度条
    [self setSelectedCircleWithValue:self.selectedValue preValue:0];
    
    // 外面散光的那个
    [self setNormalLightLine];
    
    // 实际的散光的值
    [self setSelectedLightLineWithValue:self.selectedValue preValue:0];
    
    // 带头的小圆点
    [self setSelectedPointWithValue:self.selectedValue preValue:0];
}

- (void)setNormalCircle {
    UIColor *color = self.tintColor;
    [color set]; //设置线条颜色
    
    CGFloat radius = self.viewFrame.size.width / 2;
    CGFloat point = self.viewFrame.size.width / 4;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(point, point, radius, radius)];
    circlePath.lineWidth = 1.0;
    circlePath.lineCapStyle = kCGLineCapRound; //线条拐角
    circlePath.lineJoinStyle = kCGLineCapRound; //终点处理
    [circlePath stroke];
}

- (void)setSelectedCircleWithValue:(CGFloat)value preValue:(CGFloat)preValue {
    
    CGFloat radius = self.viewFrame.size.width / 2;
    
    UIBezierPath *circlePath;
    
    if (self.animated) {
        // 有动画
        circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                    radius:radius/2
                                                startAngle:-M_PI_2
                                                  endAngle:M_PI + M_PI_2
                                                 clockwise:YES];
        CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeAnimation.fromValue = [NSNumber numberWithFloat:preValue];
        strokeAnimation.toValue = [NSNumber numberWithFloat:value];
        strokeAnimation.duration = kTimeDuration;
        strokeAnimation.beginTime = 0.0;
        strokeAnimation.fillMode = kCAFillModeForwards;
        strokeAnimation.removedOnCompletion = NO;
        [self.selectedCircleLayer addAnimation:strokeAnimation forKey:@"strokeEndAnimation"];
    } else {
        CGFloat angle = value * 100 * 0.6 * 6 * M_PI / 180;
        circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                    radius:radius/2
                                                startAngle:-M_PI_2
                                                  endAngle:-M_PI_2 + angle
                                                 clockwise:YES];
    }
    self.selectedCircleLayer.path = circlePath.CGPath;
}

- (UIBezierPath *)lightPathWithAngle:(CGFloat)angle {
    CGFloat radius = self.viewFrame.size.width / 2;
    CGFloat point = self.viewFrame.size.width / 4;
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(0, -radius + point - 10)];
    [path1 addLineToPoint:CGPointMake(0, -radius + point - 20)];
    path1.lineWidth = 1.0;
    path1.lineCapStyle = kCGLineCapRound; //线条拐角
    path1.lineJoinStyle = kCGLineCapRound; //终点处理
    [path1 applyTransform:CGAffineTransformMakeRotation(angle)];
    [path1 applyTransform:CGAffineTransformMakeTranslation(radius, radius)];
    
    return path1;
}

- (void)setNormalLightLine {
    UIColor *color = self.tintColor;
    [color set]; //设置线条颜色
    
    for (int i = 0; i < 60; i++) {
        CGFloat angle = i * 6 * M_PI / 180;
        UIBezierPath *path1 = [self lightPathWithAngle:angle];
        [path1 stroke];
    }
}

- (void)setSelectedLightLineWithValue:(CGFloat)value preValue:(CGFloat)preValue {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    UIColor *color = self.selectedColor;
    [color set]; //设置线条颜色
    
    if (self.animated) {
        for (int i = 0; i < 60; i++) {
            CGFloat angle = i * 6 * M_PI / 180;
            UIBezierPath *path1 = [self lightPathWithAngle:angle];
            [path appendPath:path1];
        }
        
        // 有动画
        CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeAnimation.fromValue = [NSNumber numberWithFloat:preValue];
        strokeAnimation.toValue = [NSNumber numberWithFloat:value];
        strokeAnimation.duration = kTimeDuration;
        strokeAnimation.beginTime = 0.0;
        strokeAnimation.fillMode = kCAFillModeForwards;
        strokeAnimation.removedOnCompletion = NO;
        [self.selectedLightLayer addAnimation:strokeAnimation forKey:@"strokeEndAnimation"];
    } else {
        value = value * 100 * 0.6;
        for (int i = 0; i < value; i++) {
            CGFloat angle = i * 6 * M_PI / 180;
            UIBezierPath *path1 = [self lightPathWithAngle:angle];
            [path appendPath:path1];
        }
    }
    
    self.selectedLightLayer.path = path.CGPath;
}

- (void)setSelectedPointWithValue:(CGFloat)value preValue:(CGFloat)preValue {
    CGFloat angle = (value * 100 * 0.6) * 6 * M_PI / 180;
    CGFloat preAngle = (preValue * 100 * 0.6) * 6 * M_PI / 180;
    
    CGFloat radius = self.viewFrame.size.width / 2;
    CGFloat point = self.viewFrame.size.width / 4;
    
    UIBezierPath *pointPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(radius - 2, point - 2, 5, 5)];
    pointPath.lineWidth = 1.0;
    
    if (self.animated) {
        // 有动画
        CABasicAnimation *zRotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        zRotateAnimation.fromValue = [NSNumber numberWithFloat:preAngle];
        zRotateAnimation.toValue = [NSNumber numberWithFloat:angle];
        zRotateAnimation.duration = kTimeDuration;
        zRotateAnimation.beginTime = 0.0;
        zRotateAnimation.fillMode = kCAFillModeForwards;
        zRotateAnimation.removedOnCompletion = NO;
        [self.pointLayer addAnimation:zRotateAnimation forKey:@"rotateAnimation"];
    } else {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.pointLayer.affineTransform = CGAffineTransformMakeRotation(angle);
        [CATransaction commit];
    }
    self.pointLayer.path = pointPath.CGPath;
    if (!self.isInfineLoop) {
        self.progressLabel.text = [NSString stringWithFormat:@"%.0f", value * 100];
    }
}

@end
