//
//  AZSRuler.m
//  Ruler
//
//  Created by answer.zou on 16/8/13.
//  Copyright © 2016年 answer.zou. All rights reserved.
//

#import "AZSRuler.h"
#import "UIColor+HexColor.h"

#define DISTANCEVALUE (self.bounds.size.width / 5)
#define DISTANCELEFTANDRIGHT DISTANCEVALUE * 0.5
#define DISTANCETOPANDBOTTOM 5
#define SolidPointWidth 10.0f
#define SolidPointHeight SolidPointWidth

#define RulerColor [UIColor colorFromHex:@"B8B8B8"]//[UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1]

@interface AZSRuler ()

@property(nonatomic, assign)CGPoint beginP;
@property(nonatomic, assign)CGPoint endP;

@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation AZSRuler {
    NSString *tempVale;
}

-(NSMutableArray *)dataArray {
    int a = 30000;
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        [_dataArray addObject:@"30000"];
        [_dataArray insertObject:@"" atIndex:0];
        [_dataArray insertObject:@"" atIndex:0];
        
        for (int i=0; i<17; i++) {
            a += 10000;
            [_dataArray addObject:[NSString stringWithFormat:@"%d", a]];
        }
        
    }
    return _dataArray;
}

-(instancetype)initWithFrame:(CGRect)frame currentValue:(NSString *)currentValue{
    self = [super initWithFrame:frame];
    if (self) {
        _currentValue = currentValue;
        tempVale = currentValue;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setupRuler];
        
    }
    
    return self;
}

-(void)setupRuler {
    _rulerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, 10, self.bounds.size.width, self.bounds.size.height)];
//    _rulerScrollView.backgroundColor = [UIColor orangeColor];
    _rulerScrollView.contentSize = CGSizeMake( self.frame.size.width * self.dataArray.count / 5 + DISTANCEVALUE * 2, self.bounds.size.height);
    _rulerScrollView.delegate = self;
    _rulerScrollView.bounces = false;
    _rulerScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_rulerScrollView];
    
    //每个小格
    [self drawRacAndBlackLine];
    [self drawRacAndLine];
}

- (void)drawRacAndLine {
    
    //屏幕中间水滴
//    CAShapeLayer *shapeLayerLine = [CAShapeLayer layer];
//    shapeLayerLine.strokeColor = [UIColor colorFromHex:@"5ed6a4"].CGColor;
//    shapeLayerLine.fillColor = [UIColor colorFromHex:@"5ed6a4"].CGColor;
//    shapeLayerLine.lineWidth = 1.f;
//    shapeLayerLine.lineCap = kCALineCapRound;
//    
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake((self.frame.size.width ) / 2  - 0.5, self.beginP.y + 8 - 15 - 5 + 1.8 - 6 + 5) radius:10 startAngle: M_PI -M_PI / 5 endAngle:M_PI * 2.2 clockwise:YES];
//    [bezierPath moveToPoint:CGPointMake( (self.frame.size.width ) / 2 , self.beginP.y + 8 - 5 + 1.8 - 1 + 5)];
//    [bezierPath addLineToPoint:CGPointMake((self.frame.size.width ) / 2 - 8 - 0.5, self.beginP.y + 8 - 15 - 5 + 1.8 + 5)];
//    [bezierPath addLineToPoint:CGPointMake((self.frame.size.width ) / 2 + 7.5 + 0.5, self.beginP.y + 8 - 15 - 5 + 1.8 + 5)];
//    
//    shapeLayerLine.path = bezierPath.CGPath;
//    
//    [self.layer addSublayer:shapeLayerLine];
    UIImageView *waterImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_home_slider"]];
    waterImg.frame = CGRectMake(0, 0, 17.5,18);
//    waterImg.backgroundColor = [UIColor greenColor];
    
//    waterImg.image = [UIImage imageNamed:@"bg_home_slider"];
    waterImg.center = CGPointMake(self.center.x, 13);
    [self addSubview:waterImg];
    
}
- (void)drawRacAndBlackLine {
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.strokeColor = RulerColor.CGColor;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineWidth = 1.f;
    shapeLayer1.lineCap = kCALineCapButt;
    CGMutablePathRef pathRef1 = CGPathCreateMutable();
    _labelArray = [NSMutableArray arrayWithCapacity:0];

    for (int i = 2; i < self.dataArray.count; i++) {
        
        UILabel *rule = [[UILabel alloc] init];
        rule.tag = i;
        rule.font = [UIFont systemFontOfSize:9];
        rule.textColor = RulerColor;
        rule.text = self.dataArray[i];
        CGSize textSize = [rule.text sizeWithAttributes:@{ NSFontAttributeName : rule.font }];
        rule.frame = CGRectMake(DISTANCELEFTANDRIGHT + DISTANCEVALUE * i - textSize.width / 2, self.frame.size.height - DISTANCETOPANDBOTTOM - textSize.height - 7, 0, 0);
        [rule sizeToFit];
        
        
        if (i == 2) {
            self.beginP = CGPointMake(rule.center.x, rule.frame.origin.y - 20);
        }
        
        if (i == self.dataArray.count - 1) {
            self.endP = CGPointMake(rule.center.x, rule.frame.origin.y - 20);
        }

        [self.rulerScrollView addSubview:rule];
        
        CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.beginP.y - 15 + 8 + 9);
        CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.beginP.y + 8);
        shapeLayer1.path = pathRef1;
        [self.rulerScrollView.layer addSublayer:shapeLayer1];
        
        
//        if (i != self.dataArray.count - 1) {
//            
//            CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i + DISTANCEVALUE * 0.5, self.beginP.y - 10 + 8);
//            CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i + DISTANCEVALUE * 0.5, self.beginP.y + 8);
//            shapeLayer1.path = pathRef1;
//        }
        
        if (i != self.dataArray.count - 1) {
            for (int j=1; j<10; j++) {
                CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i + DISTANCEVALUE * j / 10, self.beginP.y - 10 + 8 + 7);
                CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i + DISTANCEVALUE * j / 10, self.beginP.y + 8);
                shapeLayer1.path = pathRef1;
            }
        }
        
        [self.rulerScrollView.layer addSublayer:shapeLayer1];


        if ([self.dataArray[i] isEqualToString:_currentValue]) {
            _offsetTag = i;
//            rule.textColor = [UIColor colorFromHex:@"5ed6a4"];
//            rule.transform = CGAffineTransformScale(rule.transform, 1.3, 1.3);
        }
        
        [_labelArray addObject:rule];
        
        
    }
    CGPathMoveToPoint(pathRef1, NULL, self.beginP.x - self.frame.size.width * 0.5, self.beginP.y + 8);
    CGPathAddLineToPoint(pathRef1, NULL, self.frame.size.width * 0.5 + self.endP.x, self.beginP.y + 8);
    shapeLayer1.path = pathRef1;
    [self.rulerScrollView.layer addSublayer:shapeLayer1];
    _rulerScrollView.contentOffset = CGPointMake((_offsetTag - 2) * DISTANCEVALUE, 0);
}

#pragma  mark - ScrollViewDelegate 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self animationRebound:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self animationRebound:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self animationRebound:scrollView];
}

- (void)animationRebound:(UIScrollView *)scrollView {
        NSString *str = [[NSString stringWithFormat:@"%.2f", scrollView.contentOffset.x / DISTANCEVALUE] componentsSeparatedByString:@"."][1];
    CGFloat numStr = [[NSString stringWithFormat:@"%.2f", scrollView.contentOffset.x / DISTANCEVALUE]floatValue];
    
    NSLog(@"%f", [str floatValue]);
    
    if (self.realValue) {
        NSString *value = [NSString stringWithFormat:@"%.1f", numStr];
        self.realValue([NSString stringWithFormat:@"%.f", value.floatValue * 10000 + 30000]);
    }

    tempVale = self.dataArray[[[NSString stringWithFormat:@"%.f", numStr + 2] integerValue]];

}

@end
