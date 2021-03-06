//
//  FIGWorthlyViewController.m
//  Worthly
//
//  Created by John Figueiredo on 1/29/14.
//  Copyright (c) 2014 John Figueiredo. All rights reserved.
//

#import "FIGWorthlyViewController.h"
#import "SAMGradientView.h"

@interface FIGWorthlyViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableViewCell *tableViewCellOne;
@property (weak, nonatomic) IBOutlet UIButton *analyzeButton;
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITextField *costTextField;
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;

@end

@implementation FIGWorthlyViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.082 green:0.184 blue:0.259 alpha:0.9];
  [self setButtonAttributes];
  [self setPlaceholderTextAttributes:@"Chore/Ride/Fix/Etc." andTextField:self.taskTextField];
  [self setPlaceholderTextAttributes:@"Time to Complete" andTextField:self.timeTextField];
  [self setPlaceholderTextAttributes:@"Total Price Tag" andTextField:self.costTextField];
  [self samGradientView];
  double delayInSeconds = 1.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self.taskTextField becomeFirstResponder];
    [self animateView];
  });
}

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (( IS_IPHONE_5 ) && [indexPath isEqual:[NSIndexPath indexPathForRow:0 inSection:0]]) {
    return 70;
  } else if (!( IS_IPHONE_5 ) && [indexPath isEqual:[NSIndexPath indexPathForRow:0 inSection:0]]) {
    return 5;
  }
  return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - Textfield Changing
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == self.taskTextField) {
    [self.timeTextField becomeFirstResponder];
  } else if (textField == self.timeTextField) {
    [self.costTextField becomeFirstResponder];
  } else if (textField == self.costTextField) {
    [self analyzeStart];
  }
  return YES;
}

#pragma mark - IBActions
- (IBAction)analyzeButtonPressed:(id)sender {
  [self analyzeStart];
}

#pragma mark - Private Methods
- (void)analyzeStart {
  NSLog(@"Hello World");
}

- (void)setButtonAttributes {
  NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Analyze" attributes:
                                          @{
                                            NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:18.0],
                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                            NSKernAttributeName : @(4.0f)
                                            }];
  [self.analyzeButton setAttributedTitle:attributedString forState:UIControlStateNormal];
}

- (void)setPlaceholderTextAttributes:(NSString *)string andTextField:(UITextField *)textField {
  UIColor *color = [UIColor lightGrayColor];
  NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:
                                          @{
                                            NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:10.0],
                                            NSForegroundColorAttributeName : color,
                                            NSKernAttributeName : @(4.0f)
                                            }];
  textField.attributedPlaceholder = attributedString;
}

- (void)animateView {
  [UIView animateWithDuration:0.5
                        delay:0.5
                      options: UIViewAnimationOptionBeginFromCurrentState
                   animations:^{
                     self.viewTop.backgroundColor = [UIColor colorWithRed:0.182 green:0.284 blue:0.359 alpha:0.9];
                     self.viewBottom.backgroundColor = [UIColor colorWithRed:0.182 green:0.284 blue:0.359 alpha:0.9];
//                     self.viewTop.frame = CGRectMake(0, 100.0f, 0, 0);
//                     self.viewBottom.frame = CGRectMake(0, 100.0f, 0, 0);
                   }
                   completion:^(BOOL finished){
                     NSLog(@"Done!");
                   }];
}
  
- (void)samGradientView {
//  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 150, 320, 568)];
//  CAGradientLayer *gradient = [CAGradientLayer layer];
//  gradient.frame = view.bounds;
//  gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.083 green:0.184 blue:0.259 alpha:1.0] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
//  [view.layer insertSublayer:gradient atIndex:0];
//  [self.view addSubview:view];
}

@end
