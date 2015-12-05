//
//  CCBalloonView.m
//  01- Floating balloon
//
//  Created by 闲人 on 15/12/5.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "CCBalloonView.h"

@interface CCBalloonView ()

/** 用来存放所有气球的数组 */
@property(nonatomic, strong) NSMutableArray *balloons;

/** 用来存放气球位置的数组 */
@property(nonatomic, strong) NSMutableArray *locations;

/** 定时器 */
@property(nonatomic, strong) CADisplayLink *link;

@end

@implementation CCBalloonView

- (NSMutableArray *)locations
{
    if (!_locations) {
        self.locations = [NSMutableArray array];
    }
    return _locations;
}

- (NSMutableArray *)balloons{
    
    if (_balloons == nil) {
        self.balloons = [NSMutableArray array];
        // 将气球添加到数组,加8个
        NSInteger count = 8;
        UIImage *ballonImage = [UIImage imageNamed:@"balloon"];
        CGFloat ballonW = ballonImage.size.width;
        CGFloat viewW = self.bounds.size.width;
        for (int i = 0; i< count; i++) {
            //初始化气球的间距
            // 左右的间距
            CGFloat leftRithtMargin = 30;
            // 气球的间距
            CGFloat balloonDistances = (viewW - 2*leftRithtMargin - count*ballonW) / (count -1);
            CGPoint location = CGPointMake(leftRithtMargin + i *(ballonW + balloonDistances), self.frame.size.height);
            
            [self.locations addObject:[NSValue valueWithCGPoint:location]];
            
//            NSLog(@"%f", location.x);
            
            [_balloons addObject:ballonImage];
        }
    }
    return _balloons;
}

// 重写deawRect方法
- (void)drawRect:(CGRect)rect
{
    // 绘制多个图片到UIView
    NSInteger count = self.balloons.count;
    for (int i = 0; i < count; i++) {
        // 获取对应的气球
        UIImage *balloonImage = self.balloons[i];
        // 获取对应的位置
        CGPoint location = [self.locations[i] CGPointValue];
        
        // 更改每个气球的位置，在y方向-10
//        location.y -= 10;
        // 补充 -10 观察到太快了，而且所有气球都是同一个速度来移动，丑，改用另一种方法,随机生成个数。
        location.y -= arc4random_uniform(5);
        // 如果到了顶部就返回底部重新开始
        if (location.y < 0 ) {
            location.y = rect.size.height;
        }
        
        // 更新数组中的值
        [self.locations replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:location]];
        
        [balloonImage drawAtPoint:location];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addAnimaion];
    }
    return self;
}

- (void)addAnimaion
{
    // 调用定时器 重新绘制
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    // 添加到主运行循环
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.link = link;
}

// 点击屏幕暂停or播放动画
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.link.paused = !self.link.paused;
    
    
    // 下面这是百度来的  记住移除用这个invalidate方法就行了。
//    [self.link invalidate];
//    self.link = nil;
    // 移除主运行循环，不需要手写，因为invalidate方法，内部会把主定时，从主运行循环移除
    
    //[self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
















@end
