//
//  UIBezierPath+Polygon.m
//  雷达
//
//  Created by 许毓方 on 2017/4/11.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "UIBezierPath+Polygon.h"


@implementation UIBezierPath (Polygon)


#pragma mark - 正多边形
/**
 正多边形

 @param polygonType 几边形
 @param center 圆心
 @param length 角到圆心的距离
 */
+ (CGPathRef) drawPolygonWithPolygonType:(PolygonType)polygonType center:(CGPoint)center length:(double)length
{
    NSArray *lengths;
    switch (polygonType) {
        case PolygonTypeThree:
            lengths = @[@(length), @(length), @(length)];
            break;
        case PolygonTypeFour:
            lengths = @[@(length), @(length), @(length), @(length)];
            break;
        case PolygonTypeFive:
            lengths = @[@(length), @(length), @(length), @(length), @(length)];
            break;
        case PolygonTypeSix:
            lengths = @[@(length), @(length), @(length), @(length), @(length), @(length)];
            break;
            
        default:
            break;
    }
    return [self drawPolygonWithCenter:center lengths:lengths];
}

#pragma mark - 坐标转换
/**
 用距离得各点坐标
 */
+ (NSArray *) coordinatesWithPolygonType:(PolygonType)polygonType center:(CGPoint)center length:(double)length
{
    NSArray *lengths;
    switch (polygonType) {
        case PolygonTypeThree:
            lengths = @[@(length), @(length), @(length)];
            break;
        case PolygonTypeFour:
            lengths = @[@(length), @(length), @(length), @(length)];
            break;
        case PolygonTypeFive:
            lengths = @[@(length), @(length), @(length), @(length), @(length)];
            break;
        case PolygonTypeSix:
            lengths = @[@(length), @(length), @(length), @(length), @(length), @(length)];
            break;
            
        default:
            break;
    }
    return [self coordinatesWithCenter:center lengths:lengths];
}

/**
 用距离得各点坐标
 */
+ (NSArray *) coordinatesWithCenter:(CGPoint)center lengths:(NSArray *)lengths
{
    PolygonType polygonType = lengths.count;
    NSArray *coordinates;
    
    switch (polygonType) {
        case PolygonTypeThree:
            coordinates = [self threeConverCoordinateFromLength:lengths Center:center];
            break;
        case PolygonTypeFour:
            coordinates = [self fourConverCoordinateFromLength:lengths Center:center];
            break;
        case PolygonTypeFive:
            coordinates = [self fiveConverCoordinateFromLength:lengths Center:center];
            break;
        case PolygonTypeSix:
            coordinates = [self sixConverCoordinateFromLength:lengths Center:center];
            break;
            
        default:
            break;
    }
    return coordinates;
}


#pragma mark - 连线
/**
 坐标连线
 */
+ (CGPathRef) drawPolygonWithCenter:(CGPoint)center lengths:(NSArray *)lengths
{
    NSArray *coordinates = [self coordinatesWithCenter:center lengths:lengths];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    for (int i = 0; i < coordinates.count; i++) {
        CGPoint point = [coordinates[i] CGPointValue];
        if (i == 0) {
            [bezierPath moveToPoint:point];
        } else {
            [bezierPath addLineToPoint:point];
        }
    }
    [bezierPath closePath];
    
    return bezierPath.CGPath;
    
    return nil;
}


#pragma mark - 多边形

#pragma mark  三边形
/**
 算出三边形点
 
   *     1
  * *   2 3
 

 变换
 
  * *   1 2
   *     3
 
 point = CGPointMake(center.x - length * sin(M_PI / 3.0), center.y - length * cos(M_PI / 3.0));
 point = CGPointMake(center.x + length * sin(M_PI / 3.0), center.y - length * cos(M_PI / 3.0));
 point = CGPointMake(center.x, center.y + length);
 
 */
+ (NSArray *) threeConverCoordinateFromLength:(NSArray *)lengthArray Center:(CGPoint)center
{
    /* 正三边形内切圆半径
     fabs(length * sin(M_PI / 6.0));
     */
    
    NSMutableArray *coordinateArray = [NSMutableArray array];
    for (int i = 0; i < lengthArray.count; i ++) {
        
        double length = [lengthArray[i] doubleValue];
        CGPoint point = CGPointZero;
        if (i == 0) {
            point = CGPointMake(center.x,
                                center.y - length);
        }else if (i == 1) {
            point = CGPointMake(center.x - length * sin(M_PI / 3.0),
                                center.y + length * cos(M_PI / 3.0));
        }else {
            point = CGPointMake(center.x + length * sin(M_PI / 3.0),
                                center.y + length * cos(M_PI / 3.0));
        }
        
        [coordinateArray addObject:[NSValue valueWithCGPoint:point]];
    }
    return coordinateArray;
}
#pragma mark  四边形
/**
 算出四边形点
 
 *  *   1  2
 *  *   4  3
 
 */
+ (NSArray *) fourConverCoordinateFromLength:(NSArray *)lengthArray Center:(CGPoint)center
{
    /* 正四边形内切圆半径
     fabs(length * sin(M_PI / 4.0));
     */
    
    NSMutableArray *coordinateArray = [NSMutableArray array];
    for (int i = 0; i < lengthArray.count ; i ++) {
        
        double length = [lengthArray[i] doubleValue];
        CGPoint point = CGPointZero;
        if (i == 0) {
            point = CGPointMake(center.x - length * sin(M_PI / 4.0),
                                center.y - length * cos(M_PI / 4.0));
        } else if (i == 1) {
            point = CGPointMake(center.x + length * sin(M_PI / 4.0),
                                center.y - length * cos(M_PI / 4.0));
        } else if (i == 2) {
            point = CGPointMake(center.x + length * cos(M_PI / 4.0),
                                center.y + length * sin(M_PI / 4.0));
        } else {
            point = CGPointMake(center.x - length * cos(M_PI / 4.0),
                                center.y + length * sin(M_PI / 4.0));
        }
        
        [coordinateArray addObject:[NSValue valueWithCGPoint:point]];
    }
    return coordinateArray;
}


#pragma mark 五边形
/**
 算出五边形的点
 
      *       1
    *   *   5   2
     * *     4 3
 
 变换
 
     * *     1 2
    *   *   3   4
      *       5
 
 point = CGPointMake(center.x - length * sin(M_PI / 5.0), center.y - length * cos(M_PI / 5.0));
 
 point = CGPointMake(center.x + length * sin(M_PI / 5.0), center.y - length * cos(M_PI / 5.0));
 
 point = CGPointMake(center.x + length * cos(M_PI / 10.0), center.y + length * sin(M_PI / 10.0));
 
 point = CGPointMake(center.x, center.y +length);
 
 point = CGPointMake(center.x - length * cos(M_PI / 10.0), center.y + length * sin(M_PI / 10.0));
 
 */
+ (NSArray *) fiveConverCoordinateFromLength:(NSArray *)lengthArray Center:(CGPoint)center
{
    /* 正五边形内切圆半径
        fabs(length * cos(M_PI / 5.0));
    */
    
    NSMutableArray *coordinateArray = [NSMutableArray array];
    for (int i = 0; i < lengthArray.count ; i ++) {
        
        double length = [lengthArray[i] doubleValue];
        CGPoint point = CGPointZero;
        if (i == 0) {
            point = CGPointMake(center.x,
                                center.y - length);
        } else if (i == 1) {
            point = CGPointMake(center.x + length * cos(M_PI / 10.0),
                                center.y - length * sin(M_PI / 10.0));
        } else if (i == 2) {
            point = CGPointMake(center.x + length * sin(M_PI / 5.0),
                                center.y + length * cos(M_PI / 5.0));
        } else if (i == 3) {
            point = CGPointMake(center.x - length * sin(M_PI / 5.0),
                                center.y + length * cos(M_PI / 5.0));
        } else {
            point = CGPointMake(center.x - length * cos(M_PI / 10.0),
                                center.y - length * sin(M_PI / 10.0));
        }
        
        [coordinateArray addObject:[NSValue valueWithCGPoint:point]];
    }
    return coordinateArray;
}


#pragma mark 六边形
/**
 算出六边形的点
 
  * *     1 2
 *   *   6   3
  * *     5 4

*/
+ (NSArray *) sixConverCoordinateFromLength:(NSArray *)lengthArray Center:(CGPoint)center
{
    /* 正四边形内切圆半径
     fabs(length * cos(M_PI / 6.0)));
     */
    
    NSMutableArray *coordinateArray = [NSMutableArray array];
    for (int i = 0; i < lengthArray.count ; i ++) {
        
        double length = [lengthArray[i] doubleValue];
        CGPoint point = CGPointZero;
        if (i == 0) {
            point = CGPointMake(center.x - length / 2.0f,
                                center.y - length * cos(M_PI / 6.0));
        } else if (i == 1) {
            point = CGPointMake(center.x + length / 2.0f,
                                center.y - length * cos(M_PI / 6.0));
        } else if (i == 2) {
            point = CGPointMake(center.x + length,
                                center.y );
        } else if (i == 3) {
            point = CGPointMake(center.x + length / 2.0f,
                                center.y + length * cos(M_PI / 6.0));
        } else if (i == 4) {
            point = CGPointMake(center.x - length / 2.0f,
                                center.y + length * cos(M_PI / 6.0));
        } else {
            point = CGPointMake(center.x - length,
                                center.y);
        }
        
        [coordinateArray addObject:[NSValue valueWithCGPoint:point]];
    }
    return coordinateArray;
}


@end
