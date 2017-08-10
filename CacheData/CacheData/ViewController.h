//
//  ViewController.h
//  CacheData
//
//  Created by MrChen on 17/8/8.
//  Copyright © 2017年 LEIJING.CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIResponderStandardEditActions,CALayerDelegate>

@property (nonatomic,weak) NSTimer *timer1;
@property (nonatomic,weak) NSTimer *timer2;
@property (nonatomic,strong) NSThread *thread1;

@end

