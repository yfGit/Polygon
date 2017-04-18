//
//  ShapeView.m
//  雷达
//
//  Created by 许毓方 on 2017/4/12.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "ShapeView.h"
#import "UIBezierPath+Polygon.h"

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)

@interface ShapeView ()

@property (nonatomic, assign) double maxLenght;

@property (nonatomic, strong) NSMutableArray *labelArr;

@property (nonatomic, strong) CAShapeLayer *dataLayer;

@end

@implementation ShapeView

- (void)awakeFromNib
{
    self.maxLenght = 140;
    
    [super awakeFromNib];
    [self createUI];
    [self shape];
}

// 文字
- (void)createUI
{
    self.labelArr    = [NSMutableArray array];
    CGPoint center   = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_WIDTH/2.0);
    double length    = SCREEN_WIDTH/2.0 - 30;
    NSArray *lengths = @[@(length), @(length), @(length),
                         @(length), @(length), @(length)];
    NSArray *coordinates = [UIBezierPath coordinatesWithCenter:center lengths:lengths];
    NSArray *title = @[@"参战率  50.0", @"KDA  50.0", @"发育  50.0",
                         @"推进  50.0", @"生存  50.0", @"输出  50.0"];
    
    
    for (NSUInteger i = 0; i < coordinates.count; i ++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.bounds   = CGRectMake(0, 0, 50, 50);
        label.center   = [coordinates[i] CGPointValue];
        label.text     = title[i];
        label.font     = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        [self addSubview:label];
        [self.labelArr addObject:label];
    }
}

// 背景
- (void)shape
{
    NSArray *lengths = @[@(self.maxLenght), @100, @60, @20];
    CGPoint center   = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_WIDTH/2.0);
    NSArray *colors  = @[[UIColor colorWithRed:0.5 green:0.5 blue:0.6 alpha:0.5],
                         [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5],
                         [UIColor colorWithRed:0.5 green:0.5 blue:0.4 alpha:0.5],
                         [UIColor colorWithRed:0.5 green:0.5 blue:0.3 alpha:0.5]];
    // 正六边形
    for (NSUInteger i = 0; i < lengths.count; i ++) {
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.strokeColor   = [UIColor cyanColor].CGColor;
        layer.fillColor     = [colors[i] CGColor];
        layer.path          = [UIBezierPath drawPolygonWithPolygonType:PolygonTypeSix
                                                                center:center
                                                                length:[lengths[i] doubleValue]];
        [self.layer addSublayer:layer];
    }
    
    NSArray *coordinates = [UIBezierPath coordinatesWithPolygonType:PolygonTypeSix
                                                             center:center
                                                             length:[lengths.firstObject doubleValue]];
    // 对角线
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSUInteger i = 0; i < coordinates.count; i ++) {
        
        [path moveToPoint:center];
        [path addLineToPoint:[coordinates[i] CGPointValue]];
        
    }
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.strokeColor   = [UIColor darkGrayColor].CGColor;
    shape.fillColor     = [UIColor clearColor].CGColor;
    shape.path          = path.CGPath;
    [self.layer addSublayer:shape];
}


// 数据
- (void)setLengths:(NSMutableArray *)lengths
{
    NSAssert(lengths.count == self.labelArr.count, @"数据不全");
    _lengths = lengths;
    
    [self drawData];
}

- (void)drawData
{
    // label
    NSMutableArray *lengths = [NSMutableArray array];
    for (NSUInteger i = 0; i < self.lengths.count; i ++) {
        
        UILabel *label = self.labelArr[i];
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
        NSString *string = [label.text stringByTrimmingCharactersInSet:set];
        label.text = [NSString stringWithFormat:@"%@%.1f", string, [self.lengths[i] doubleValue]];
    
        // 转换百分比值
        double length = [self.lengths[i] doubleValue] / 100 * self.maxLenght;
        [lengths addObject:@(length)];
    }
    
    // 线
    CGPoint center   = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_WIDTH/2.0);
    self.dataLayer.path = [UIBezierPath drawPolygonWithCenter:center lengths:lengths];

}

- (CAShapeLayer *)dataLayer
{
    if (!_dataLayer) {
        self.dataLayer = [CAShapeLayer layer];
        self.dataLayer.strokeColor = [UIColor clearColor].CGColor;
        self.dataLayer.fillColor   = [UIColor colorWithRed:0 green:0.5 blue:0.8 alpha:0.8].CGColor;
        
        [self.layer addSublayer:self.dataLayer];
    }
    return _dataLayer;
}


@end
