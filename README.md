## ClockView


### Description

* 像太阳光一样散光的进度条，用UIBezierPath画的

### Demo

![](https://github.com/miss-yadi/ClockView/blob/master/loading.gif)

### Usage
#### 初始化：设置frame，默认颜色、选中颜色、初始值、是否有动画

	LightLoadingView *lightLoading1 = [[LightLoadingView alloc] initLightLoadingViewWithFrame:CGRectMake(10, 10, 150, 150) tintColor:[self colorWithRGBValue:0xC9E4DA] selectedColor:[self colorWithRGBValue:0x008C5E] value:0.2 animated:YES];

#### 如果想一直循环转的话，就调用

	[self.lightLoading1 infineLoop];

#### 设置进度条的值，0-1之间

    [self.lightLoading1 setProgressValue:0.8];