//
//  UIBezierPath+Polygon.h
//  雷达
//
//  Created by 许毓方 on 2017/4/11.
//  Copyright © 2017年 Vincent. All rights reserved.
//  多边形 path

#import <UIKit/UIKit.h>


/**
 多边形
 */
typedef NS_ENUM(NSUInteger, PolygonType) {
    PolygonTypeThree = 3,  // 正三边形
    PolygonTypeFour,
    PolygonTypeFive,
    PolygonTypeSix
};


@interface UIBezierPath (Polygon)


/**
 正多边形
 
 @param polygonType 几边形
 @param center 圆心
 @param length 角到圆心的距离
 */
+ (CGPathRef) drawPolygonWithPolygonType:(PolygonType)polygonType center:(CGPoint)center length:(double)length;


/**
 点, 距离 获取path
 */
+ (CGPathRef) drawPolygonWithCenter:(CGPoint)center lengths:(NSArray *)lengths;


/**
 能力分析图各角的位置
 放置对应能力说明
 */
+ (NSArray *) coordinatesWithPolygonType:(PolygonType)polygonType center:(CGPoint)center length:(double)length;
+ (NSArray *) coordinatesWithCenter:(CGPoint)center lengths:(NSArray *)lengths;

@end
