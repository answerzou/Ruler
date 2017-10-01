//
//  AZSRuler.h
//  Ruler
//
//  Created by answer.zou on 16/8/13.
//  Copyright © 2016年 answer.zou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RealValue)(NSString *x);

@interface AZSRuler : UIView <UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *rulerScrollView;

//@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, copy)NSString *currentValue;

@property (nonatomic, strong)NSMutableArray *labelArray;

@property (nonatomic, assign)CGFloat offsetTag;

@property (nonatomic, copy)RealValue realValue;


-(instancetype)initWithFrame:(CGRect)frame currentValue:(NSString *)currentValue;

@end
