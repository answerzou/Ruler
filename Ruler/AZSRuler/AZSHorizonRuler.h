//
//  AZSHorizonRuler.h
//  AZSHorizonRuler
//
//  Created by answer.zou on 16/8/13.
//  Copyright © 2016年 answer.zou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RealValue)(NSString *);

@interface AZSHorizonRuler : UIView <UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *rulerScrollView;

@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, copy)NSString *currentValue;

@property (nonatomic, strong)NSMutableArray *labelArray;

@property (nonatomic, assign)CGFloat offsetTag;

@property (nonatomic, copy)RealValue realValue;


-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSMutableArray *)dataArray currentValue:(NSString *)currentValue;

@end
