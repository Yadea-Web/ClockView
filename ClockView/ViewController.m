//
//  ViewController.m
//  ClockView
//
//  Created by liuyadi on 2016/10/17.
//  Copyright © 2016年 Geek Zoo Studio. All rights reserved.
//

#import "ViewController.h"
#import "LightLoadingView.h"

@interface ViewController ()

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
    [self.lightLoading1 infineLoop];
    [self.view addSubview:self.lightLoading2];
    [self.view addSubview:self.lightLoading3];
    [self.view addSubview:self.lightLoading4];
}

- (void)changeProgress {
    [self.lightLoading1 setProgressValue:0.8];
}

- (LightLoadingView *)lightLoading1 {
    if (!_lightLoading1) {
        _lightLoading1 = [[LightLoadingView alloc] initLightLoadingViewWithFrame:CGRectMake(10, 10, 150, 150) tintColor:[self colorWithRGBValue:0xC9E4DA] selectedColor:[self colorWithRGBValue:0x008C5E] value:0.2 animated:YES];
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

@end
