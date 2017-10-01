//
//  AZSHorizonRuler.m
//  AZSHorizonRuler
//
//  Created by answer.zou on 16/8/13.
//  Copyright © 2016年 answer.zou. All rights reserved.
//

#import "AZSHorizonRuler.h"
#import "UIColor+HexColor.h"

#define DISTANCEVALUE (self.bounds.size.height / 5 )
#define DISTANCELEFTANDRIGHT DISTANCEVALUE * 0.5
#define DISTANCETOPANDBOTTOM 5

@implementation AZSHorizonRuler {
     NSString *tempVale;
}

-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSMutableArray *)dataArray currentValue:(NSString *)currentValue{
    self = [super initWithFrame:frame];
    if (self) {
        
        [dataArray insertObject:@"" atIndex:0];
        [dataArray insertObject:@"" atIndex:0];
        _dataArray = dataArray;
        _currentValue = currentValue;
        tempVale = currentValue;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setupRuler];
        
    }
    
    return self;
}

-(void)setupRuler {
    _rulerScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _rulerScrollView.contentSize = CGSizeMake(self.bounds.size.width, self.frame.size.height * _dataArray.count / 5 + DISTANCEVALUE * 2);
    _rulerScrollView.backgroundColor = [UIColor whiteColor];
    _rulerScrollView.delegate = self;
    _rulerScrollView.bounces = false;
    _rulerScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_rulerScrollView];
    
    //每个小格
    [self drawRacAndBlackLine];
    [self drawRacAndLine];
}

- (void)drawRacAndLine {
    
//    //屏幕中间蓝色竖线
    CAShapeLayer *shapeLayerLine = [CAShapeLayer layer];
    shapeLayerLine.strokeColor = [UIColor colorFromHex:@"5ed6a4"].CGColor;
    shapeLayerLine.fillColor = [UIColor colorFromHex:@"5ed6a4"].CGColor;
    shapeLayerLine.lineWidth = 2.f;
    shapeLayerLine.lineCap = kCALineCapSquare;
    
    CGMutablePathRef pathLine = CGPathCreateMutable();
    CGPathMoveToPoint(pathLine, NULL, 20, (self.frame.size.height ) / 2);
    CGPathAddLineToPoint(pathLine, NULL, 5, (self.frame.size.height ) / 2);
    
    shapeLayerLine.path = pathLine;
    [self.layer addSublayer:shapeLayerLine];
    
}

- (void)drawRacAndBlackLine {
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineWidth = 1.f;
    shapeLayer1.lineCap = kCALineCapButt;
    CGMutablePathRef pathRef1 = CGPathCreateMutable();
    _labelArray = [NSMutableArray arrayWithCapacity:0];
    
    NSLog(@"********%@", _currentValue);
    for (int i = 2; i<_dataArray.count; i++) {
        
        
        UILabel *rule = [[UILabel alloc] init];
        rule.tag = i;
        rule.textColor = [UIColor blackColor];
        rule.text = _dataArray[i];
        CGSize textSize = [rule.text sizeWithAttributes:@{ NSFontAttributeName : rule.font }];
        rule.frame = CGRectMake(32, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i - textSize.width / 2 + 2, 0, 0);
        [rule sizeToFit];
        
        [self.rulerScrollView addSubview:rule];
        
        if ([_dataArray[i] isEqualToString:_currentValue]) {
            _offsetTag = i;
            rule.textColor = [UIColor colorFromHex:@"5ed6a4"];
            rule.transform = CGAffineTransformScale(rule.transform, 1.3, 1.3);
        }
        
        [_labelArray addObject:rule];
        CGPathMoveToPoint(pathRef1, NULL, 20, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i);
        CGPathAddLineToPoint(pathRef1, NULL, 5, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i);
        
    }
    shapeLayer1.path = pathRef1;
    [self.rulerScrollView.layer addSublayer:shapeLayer1];
    _rulerScrollView.contentOffset = CGPointMake(0, (_offsetTag - 2) * DISTANCEVALUE);
}

#pragma  mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self animationRebound:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self animationRebound:scrollView];
}

- (void)animationRebound:(UIScrollView *)scrollView {
    
    NSString *str = [[NSString stringWithFormat:@"%.2f", scrollView.contentOffset.y / DISTANCEVALUE] componentsSeparatedByString:@"."][1];
    CGFloat numStr = [[[NSString stringWithFormat:@"%.2f", scrollView.contentOffset.y / DISTANCEVALUE] componentsSeparatedByString:@"."][0] floatValue];
    
    if ([str floatValue] > 50) {
        numStr = numStr + 1;
        [UIView animateWithDuration:.2f animations:^{
            scrollView.contentOffset = CGPointMake(0, (numStr ) * DISTANCEVALUE);
        }];
        
    }else {
        [UIView animateWithDuration:.2f animations:^{
            scrollView.contentOffset = CGPointMake(0, numStr  * DISTANCEVALUE);
        }];
    }
    for (UILabel *label in _labelArray) {
        if (label.tag - 2 == numStr) {
            
            if (tempVale != _dataArray[[[NSString stringWithFormat:@"%.f", numStr + 2] integerValue]]) {
                
                label.transform = CGAffineTransformScale(label.transform, 1.3, 1.3);
                label.textColor = [UIColor colorFromHex:@"5ed6a4"];
            }
            
        }else {
            label.transform = CGAffineTransformIdentity;
            label.textColor = [UIColor blackColor];
        }
    }
    
    NSLog(@"%f", [str floatValue]);
    NSLog(@"%.f", numStr);
    
    //回调
    self.realValue(_dataArray[[[NSString stringWithFormat:@"%.f", numStr + 2] integerValue]]);
    tempVale = _dataArray[[[NSString stringWithFormat:@"%.f", numStr + 2] integerValue]];
    
    
}
@end
