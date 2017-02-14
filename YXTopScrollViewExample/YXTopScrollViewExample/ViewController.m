//
//  ViewController.m
//  YXTopScrollViewExample
//
//  Created by shiqin on 2017/2/13.
//  Copyright © 2017年 mifo. All rights reserved.
//

#import "ViewController.h"
#import "YXTopScrollView.h"

@interface ViewController ()

@property (nonatomic, weak) YXTopScrollView * yxTopScrollV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * itemArr = @[@"推荐",@"悬疑",@"言情",@"幻想",@"历史",@"都市",@"文学",@"武侠",@"官场商战",@"经管",@"社科",@"QQ阅读",@"读客图书",@"果麦文化",@"中信出版",@"博集天卷",@"磨铁阅读",@"速播专区",@"推理世界",@"正能量有声书"];
    
    YXTopScrollView * yxTopScrollV = [[YXTopScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];

    yxTopScrollV.items = itemArr;
    
    yxTopScrollV.lineHeight = 3;

    yxTopScrollV.btnClick = ^(NSString * text) {
    
        NSLog(@"text = %@",text);
    
    };
    
    [self.view addSubview:yxTopScrollV];
    
    self.yxTopScrollV = yxTopScrollV;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"%@",self.yxTopScrollV);
}


@end
