//
//  ViewController.m
//  ClockView
//
//  Created by liuyadi on 2016/10/17.
//  Copyright © 2016年 Geek Zoo Studio. All rights reserved.
//

#import "ViewController.h"
#import "LightLoadingView.h"
#import "YDSlider.h"

@interface ViewController () <YDSliderDelegate>

@property (nonatomic, strong) LightLoadingView *lightLoading1;
@property (nonatomic, strong) LightLoadingView *lightLoading2;
@property (nonatomic, strong) LightLoadingView *lightLoading3;
@property (nonatomic, strong) LightLoadingView *lightLoading4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.lightLoading1];
    [self.view addSubview:self.lightLoading2];
    [self.view addSubview:self.lightLoading3];
    [self.view addSubview:self.lightLoading4];
    [self.lightLoading4 infineLoop];
    
    YDSlider *slider1 = [[YDSlider alloc] initWithFrame:CGRectMake(20, 350, 300, 40) indexLabelType:SLIDER_INDEX_TYPE_CENTER];
    slider1.delegate = self;
    slider1.tag = 1;
    slider1.minimumValue = 0;
    slider1.maximumValue = 100;
    slider1.minimumTrackTintColor = [self colorWithRGBValue:0xC9E4DA];
    slider1.maximumTrackTintColor = [self colorWithRGBValue:0x008C5E];
    [self.view addSubview:slider1];
    
    YDSlider *slider2 = [[YDSlider alloc] initWithFrame:CGRectMake(20, 400, 300, 40) indexLabelType:SLIDER_INDEX_TYPE_CENTER];
    slider2.delegate = self;
    slider2.tag = 2;
    slider2.minimumValue = 0;
    slider2.maximumValue = 100;
    slider2.minimumTrackTintColor = [self colorWithRGBValue:0xBFCAE6];
    slider2.maximumTrackTintColor = [self colorWithRGBValue:0x103667];
    [self.view addSubview:slider2];
    
    YDSlider *slider3 = [[YDSlider alloc] initWithFrame:CGRectMake(20, 450, 300, 40) indexLabelType:SLIDER_INDEX_TYPE_CENTER];
    slider3.delegate = self;
    slider3.tag = 3;
    slider3.minimumValue = 0;
    slider3.maximumValue = 100;
    slider3.minimumTrackTintColor = [self colorWithRGBValue:0xFCD9C4];
    slider3.maximumTrackTintColor = [self colorWithRGBValue:0x8E1E20];
    [self.view addSubview:slider3];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 500, 100, 50)];
    [button1 setTitle:@"Loading1" forState:UIControlStateNormal];
    [button1 setTitleColor:[self colorWithRGBValue:0x008C5E] forState:UIControlStateNormal];
    [button1 setBackgroundColor:[self colorWithRGBValue:0xC9E4DA]];
    [button1 addTarget:self action:@selector(changeProgressView1) forControlEvents:UIControlEventTouchUpInside];
    button1.layer.cornerRadius = 4;
    button1.layer.masksToBounds = YES;
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(130, 500, 100, 50)];
    [button2 setTitle:@"Loading2" forState:UIControlStateNormal];
    [button2 setTitleColor:[self colorWithRGBValue:0x103667] forState:UIControlStateNormal];
    [button2 setBackgroundColor:[self colorWithRGBValue:0xBFCAE6]];
    [button2 addTarget:self action:@selector(changeProgressView2) forControlEvents:UIControlEventTouchUpInside];
    button2.layer.cornerRadius = 4;
    button2.layer.masksToBounds = YES;
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(240, 500, 100, 50)];
    [button3 setTitle:@"Loading3" forState:UIControlStateNormal];
    [button3 setTitleColor:[self colorWithRGBValue:0x8E1E20] forState:UIControlStateNormal];
    [button3 setBackgroundColor:[self colorWithRGBValue:0xFCD9C4]];
    [button3 addTarget:self action:@selector(changeProgressView3) forControlEvents:UIControlEventTouchUpInside];
    button3.layer.cornerRadius = 4;
    button3.layer.masksToBounds = YES;
    [self.view addSubview:button3];
}

- (void)changeProgress {
    [self.lightLoading1 setProgressValue:0.8];
}

- (LightLoadingView *)lightLoading1 {
    if (!_lightLoading1) {
        _lightLoading1 = [[LightLoadingView alloc] initLightLoadingViewWithFrame:CGRectMake(10, 10, 150, 150) tintColor:[self colorWithRGBValue:0xC9E4DA] selectedColor:[self colorWithRGBValue:0x008C5E] value:0.2 animated:NO];
        _lightLoading1.backgroundColor = [UIColor whiteColor];
    }
    return _lightLoading1;
}

- (LightLoadingView *)lightLoading2 {
    if (!_lightLoading2) {
        _lightLoading2 = [[LightLoadingView alloc] initLightLoadingViewWithFrame:CGRectMake(170, 10, 150, 150) tintColor:[self colorWithRGBValue:0xBFCAE6] selectedColor:[self colorWithRGBValue:0x103667] value:0.2 animated:YES];
        _lightLoading2.backgroundColor = [UIColor whiteColor];
    }
    return _lightLoading2;
}

- (LightLoadingView *)lightLoading3 {
    if (!_lightLoading3) {
        _lightLoading3= [[LightLoadingView alloc] initLightLoadingViewWithFrame:CGRectMake(10, 170, 100, 100) tintColor:[self colorWithRGBValue:0xFCD9C4] selectedColor:[self colorWithRGBValue:0x8E1E20] value:0.2 animated:YES];
        _lightLoading3.backgroundColor = [UIColor whiteColor];
        _lightLoading3.progressLabelFont = [UIFont systemFontOfSize:12];
    }
    return _lightLoading3;
}

- (LightLoadingView *)lightLoading4 {
    if (!_lightLoading4) {
        _lightLoading4 = [[LightLoadingView alloc] initLightLoadingViewWithFrame:CGRectMake(170, 170, 200, 200) tintColor:[self colorWithRGBValue:0xE8D3E3] selectedColor:[self colorWithRGBValue:0x64004B] value:0.2 animated:YES];
        _lightLoading4.backgroundColor = [UIColor whiteColor];
    }
    return _lightLoading4;
}

- (UIColor *)colorWithRGBValue:(uint)value {
    uint r = (value & 0x00FF0000) >> 16;
    uint g = (value & 0x0000FF00) >> 8;
    uint b = (value & 0x000000FF);
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

#pragma mark - YDSliderDelegate

- (void)sliderValueChanged:(YDSlider *)slider {
    CGFloat value = slider.value / 100;
    if (slider.tag == 1) {
        [self.lightLoading1 setProgressValue:value];
    } else if (slider.tag == 2) {
        [self.lightLoading2 setProgressValue:value];
    } else if (slider.tag == 3) {
        [self.lightLoading3 setProgressValue:value];
    }
}

- (void)changeProgressView1 {
    [self.lightLoading1 setProgressValue:0.1];
}

- (void)changeProgressView2 {
    [self.lightLoading2 setProgressValue:0.7];
}

- (void)changeProgressView3 {
    [self.lightLoading3 setProgressValue:0.8];
}

@end
