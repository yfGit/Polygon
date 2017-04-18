//
//  ViewController.m
//  雷达
//
//  Created by 许毓方 on 2017/4/10.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "ViewController.h"

#import "UIBezierPath+Polygon.h"

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@property (nonatomic, strong) NSArray *colors;

@property (nonatomic, strong) NSArray *lengths;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colors = @[[UIColor blueColor],
                    [UIColor magentaColor],
                    [UIColor orangeColor],
                    [UIColor darkGrayColor]];
    self.lengths = @[@100, @70, @50, @20];
    
    
    [self three];
    
    [self four];
    
    [self five];
    
    [self six];
}


- (void)three
{
    UIView *view = [self createShapeView];
    view.center  = CGPointMake(SCREEN_WIDTH/4.0, SCREEN_HEIGHT/4.0);
    for (int i = 0; i < 4; i ++) {
        
        CAShapeLayer *layer = [self createShapeLayer];
        CGPoint center = CGPointMake(view.frame.size.width/2.0, view.frame.size.height/2.0);
        layer.path = [UIBezierPath drawPolygonWithPolygonType:PolygonTypeThree center:center length:[self.lengths[i] doubleValue]];
        layer.fillColor       = [self.colors[i] CGColor];
        [view.layer addSublayer:layer];
    }
    
    
}

- (void)four
{
    UIView *view = [self createShapeView];
    view.center  = CGPointMake(SCREEN_WIDTH/4.0*3.0, SCREEN_HEIGHT/4.0);
    
    for (int i = 0; i < 4; i ++) {
        CAShapeLayer *layer = [self createShapeLayer];
        CGPoint center = CGPointMake(view.frame.size.width/2.0, view.frame.size.height/2.0);
        layer.path = [UIBezierPath drawPolygonWithPolygonType:PolygonTypeFour center:center length:[self.lengths[i] doubleValue]];
        layer.fillColor       = [self.colors[i] CGColor];
        [view.layer addSublayer:layer];
    }
    
    
}

- (void)five
{
    UIView *view = [self createShapeView];
    view.center  = CGPointMake(SCREEN_WIDTH/4.0, SCREEN_HEIGHT/4.0*3.0);
    
    for (int i = 0; i < 4; i ++) {
        
        CAShapeLayer *layer = [self createShapeLayer];
        CGPoint center = CGPointMake(view.frame.size.width/2.0, view.frame.size.height/2.0);
        layer.path = [UIBezierPath drawPolygonWithPolygonType:PolygonTypeFive center:center length:[self.lengths[i] doubleValue]];
        layer.fillColor       = [self.colors[i] CGColor];
        [view.layer addSublayer:layer];
    }
}

- (void)six
{
    UIView *view = [self createShapeView];
    view.center  = CGPointMake(SCREEN_WIDTH/4.0*3.0, SCREEN_HEIGHT/4.0*3.0);
    
    for (int i = 0; i < 4; i ++) {
        CAShapeLayer *layer = [self createShapeLayer];
        CGPoint center = CGPointMake(view.frame.size.width/2.0, view.frame.size.height/2.0);
        layer.path = [UIBezierPath drawPolygonWithPolygonType:PolygonTypeSix center:center length:[self.lengths[i] doubleValue]];
        layer.fillColor       = [self.colors[i] CGColor];
        [view.layer addSublayer:layer];
    }
}


- (UIView *)createShapeView
{
    UIView *view = [[UIView alloc] init];
    view.alpha = 0.7;
    view.bounds  = CGRectMake(0, 0, SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    view.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:view atIndex:0];
    
    return view;
}

- (CAShapeLayer *)createShapeLayer
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.strokeColor     = [UIColor clearColor].CGColor;
    
    return layer;
}



@end
