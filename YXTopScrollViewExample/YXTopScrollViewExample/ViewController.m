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
    
    self.navigationController.navigationBar.barTintColor = [UIColor brownColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray * itemArr = @[@"推荐",@"悬疑",@"言情",@"幻想",@"历史",@"都市",@"文学",@"武侠",@"官场商战",@"经管",@"社科",@"QQ阅读",@"读客图书",@"果麦文化",@"中信出版",@"博集天卷",@"磨铁阅读",@"速播专区",@"推理世界",@"正能量有声书"];
    
    YXTopScrollView * yxTopV = [YXTopScrollView initWithOriginY:0 height:50 forItems:itemArr];

    yxTopV.btnClick = ^(NSString * text) {
    
        NSLog(@"text = %@",text);
    
    };
    
    [self.view addSubview:yxTopV];
    
    self.yxTopScrollV = yxTopV;
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
