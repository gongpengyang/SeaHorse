//
//  OCController.m
//  KYCarSource
//
//  Created by gongpengyang on 2019/3/13.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

#import "OCController.h"
#import "KYCarSource-Swift.h"

@interface OCController ()

@end

@implementation OCController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我OC呀";
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
    btn.backgroundColor = [UIColor greenColor];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}
- (void)btnClick:(UIButton *)sender {
    KYCarTypeVC *vc = [[KYCarTypeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
