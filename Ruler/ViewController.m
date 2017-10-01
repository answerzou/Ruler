//
//  ViewController.m
//  Ruler
//
//  Created by BJJY on 2017/10/1.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "ViewController.h"
#import "AZSRuler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AZSRuler *ruler = [[AZSRuler alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 51) currentValue:@"100000"];
    ruler.backgroundColor = [UIColor greenColor];
    ruler.realValue = ^(NSString *value) {
        NSLog(@"%@", value);
    };
    [self.view addSubview:ruler];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
