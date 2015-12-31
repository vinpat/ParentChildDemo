//
//  PCDAppViewController.m
//  ParentChildDemo
//
//  Created by Vinod on 29/12/15.
//
//

#import "PCDAppViewController.h"

@interface PCDAppViewController () {
    UIViewController *prevController;
    UIView *containerViewB;
}
@property(nonatomic, strong)UIViewController *firstController;
@property(nonatomic, strong)UIViewController *secondController;

@end

@implementation PCDAppViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *superview = self.view;
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectZero];
    containerView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [superview addSubview:containerView];
    
    containerViewB = [[UIView alloc] initWithFrame:CGRectZero];
    containerViewB.backgroundColor = [UIColor yellowColor];
    [containerViewB setTranslatesAutoresizingMaskIntoConstraints:NO];
    [superview addSubview:containerViewB];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(containerView, containerViewB, superview);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView(==150)]-20-[containerViewB]-20-|" options:0 metrics:nil views:views];
    NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|" options:0 metrics:nil views:views];
    NSArray *constraints3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerViewB]|" options:0 metrics:nil views:views];
    [superview addConstraints:constraints];
    [superview addConstraints:constraints2];
    [superview addConstraints:constraints3];
    
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"1", @"2"]];
    [segmentedControl setTintColor:[UIColor blackColor]];
    segmentedControl.clipsToBounds = YES;
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [containerView addSubview:segmentedControl];
 
    views = NSDictionaryOfVariableBindings(segmentedControl, containerView);
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[segmentedControl]-50-|" options:0 metrics:nil views:views];
    constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[segmentedControl]-100-|" options:0 metrics:nil views:views];
    [containerView addConstraints:constraints];
    [containerView addConstraints:constraints2];
    
    segmentedControl.selectedSegmentIndex = 0;
    [self segmentAction:segmentedControl];
}

// Getter Methods to get child view controllers

- (UIViewController *)firstController {
    if (!_firstController) {
        _firstController = [[UIViewController alloc] init];
        _firstController.view.backgroundColor = [UIColor purpleColor];
    }
    return _firstController;
}

- (UIViewController *)secondController {
    if (!_secondController) {
        _secondController = [[UIViewController alloc] init];
        _secondController.view.backgroundColor = [UIColor brownColor];
    }
    return _secondController;
}

- (void)segmentAction:(UISegmentedControl*)sControl {
    UIViewController *controller;
    
    switch (sControl.selectedSegmentIndex) {
        case 0:
            controller = self.firstController;
            break;
            
        case 1:
            controller = self.secondController;
            break;
            
        default:
            controller = self.firstController;
            break;
    }
    
    UIView *controllerView = controller.view;
    if (prevController) {
        [prevController willMoveToParentViewController:nil];
        [prevController.view removeFromSuperview];
        [prevController removeFromParentViewController];
    }
    
    [self addChildViewController:controller];
    controller.view.translatesAutoresizingMaskIntoConstraints = NO;
    [containerViewB addSubview:controllerView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(controllerView, containerViewB);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[controllerView]-10-|" options:0 metrics:nil views:views];
    NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[controllerView]-10-|" options:0 metrics:nil views:views];
    [containerViewB addConstraints:constraints];
    [containerViewB addConstraints:constraints2];

    [controller didMoveToParentViewController:self];
    prevController = controller;
}

@end
