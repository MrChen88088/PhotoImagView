//
//  ViewController.m
//  CacheData
//
//  Created by MrChen on 17/8/8.
//  Copyright © 2017年 LEIJING.CHEN. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewVC.h"
#define WIDTH 50
#define PHOTO_HEIGHT 150

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeInterval:) userInfo:nil repeats:YES];
//    
//    NSTimer  *tempTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timeInterval:) userInfo:nil repeats:YES];
//    
//    [[NSRunLoop  currentRunLoop] addTimer:tempTimer forMode:NSDefaultRunLoopMode];
//    
//    self.timer2 = tempTimer;
//    
//    CGRect rect = [UIScreen mainScreen].bounds;
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectInset(rect, 0, 200)];
//    [self.view addSubview:scrollView];
//    
//    UIView *contentView = [[UIView alloc] initWithFrame:CGRectInset(scrollView.bounds, -100, -100)];
//    contentView.backgroundColor = [UIColor redColor];
//    [scrollView addSubview:contentView];
//    scrollView.contentSize = contentView.frame.size;
    
//    
//    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(perforTask) object:nil];
//    
//    [self.thread1 start];
//    
    
    
    //[self drawMyLayer];
    
    
    [self drawMyLayerPhoto];
}



#pragma mark----绘制头像

-(void)drawMyLayerPhoto{

    CALayer * layer = [[CALayer alloc]init];
    layer.bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layer.position = CGPointMake(160, 200);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = PHOTO_HEIGHT / 2;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 2;
    layer.delegate = self;
    [self.view.layer addSublayer:layer];
    [layer setNeedsDisplay];
    
}


#pragma mark----绘制图像

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{

    CGContextSaveGState(ctx);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    
    UIImage *image = [UIImage imageNamed:@"我的_家庭服务"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    
    CGContextRestoreGState(ctx);

}








#pragma mark 绘制图层
-(void)drawMyLayer{
    CGSize size=[UIScreen mainScreen].bounds.size;
    
    //获得根图层
    CALayer *layer=[[CALayer alloc]init];
    //设置背景颜色,由于QuartzCore是跨平台框架，无法直接使用UIColor
    layer.backgroundColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    //设置中心点
    layer.position=CGPointMake(size.width/2, size.height/2);
    //设置大小
    layer.bounds=CGRectMake(0, 0, WIDTH,WIDTH);
    //设置圆角,当圆角半径等于矩形的一半时看起来就是一个圆形
    layer.cornerRadius= WIDTH/2;
    //设置阴影
    layer.shadowColor=[UIColor grayColor].CGColor;
    layer.shadowOffset=CGSizeMake(2, 2);
    layer.shadowOpacity=.9;
    //设置边框
    //    layer.borderColor=[UIColor whiteColor].CGColor;
    //    layer.borderWidth=1;
    
    //设置锚点
    //    layer.anchorPoint=CGPointZero;
    
    [self.view.layer addSublayer:layer];
    
}





#pragma mark 点击放大
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CALayer *layer=self.view.layer.sublayers[0];
    CGFloat width=layer.bounds.size.width;
    if (width==WIDTH) {
        width=WIDTH*4;
    }else{
        width=WIDTH;
    }
    layer.bounds=CGRectMake(0, 0, width, width);
    layer.position=[touch locationInView:self.view];
    layer.cornerRadius=width/2;
}


-(void)timeInterval:(NSTimer *)timer{

    if (self.timer1 == timer) {
        NSLog(@"timer1...");
    } else {
        NSLog(@"timer2...");
    }

    
}
- (IBAction)ImageViewClick:(id)sender {
    
    ImageViewVC *vc = [[ImageViewVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


-(void)perforTask{

    NSLog(@"线程启动中.....");
    

    __weak typeof(self) weakSelf = self;
    
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        if ([NSThread currentThread].isCancelled) {
            
            [weakSelf.timer1 invalidate];
        }
        
        NSLog(@"Time1....");
        
    }];
    
    
    NSLog(@"runloop before performSelector:%@",[NSRunLoop currentRunLoop]);

    [self performSelector:@selector(caculate) withObject:nil afterDelay:2.0];
    
    NSLog(@"runloop after performSelector:%@",[NSRunLoop currentRunLoop]);
    
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"注意：如果RunLoop不退出（运行中），这里的代码并不会执行，RunLoop本身就是一个循环.");
    
}


-(void)caculate{
    
    for (int i = 0;i < 9999;++i) {
        NSLog(@"%i,%@",i,[NSThread currentThread]);
        if ([NSThread currentThread].isCancelled) {
            return;
        }
    }
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
