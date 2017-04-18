
//
//  CustomController.m
//  雷达
//
//  Created by 许毓方 on 2017/4/12.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "CustomController.h"
#import "ShapeView.h"

@interface CustomController ()

@property (weak, nonatomic) IBOutlet ShapeView *shapeView;


@end

@implementation CustomController

- (IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.shapeView.lengths = @[@50,@50,@50,@50,@50,@50].mutableCopy;
}

- (IBAction)sliderChanged:(UISlider *)sender
{
    NSMutableArray *lengths = self.shapeView.lengths;
    switch (sender.tag) {
        case 10:
            lengths[0] = @(sender.value);
            self.shapeView.lengths = lengths;
            break;
            
        case 11:
            lengths[1] = @(sender.value);
            self.shapeView.lengths = lengths;
            break;
            
        case 12:
            lengths[2] = @(sender.value);
            self.shapeView.lengths = lengths;
            break;
            
        case 13:
            lengths[3] = @(sender.value);
            self.shapeView.lengths = lengths;
            break;
            
        case 14:
            lengths[4] = @(sender.value);
            self.shapeView.lengths = lengths;
            break;
            
        case 15:
            lengths[5] = @(sender.value);
            self.shapeView.lengths = lengths;
            break;
            
        default:
            break;
    }
//    NSLog(@"---> %.1f",sender.value);
}

@end
