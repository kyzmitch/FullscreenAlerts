//
//  ViewController.m
//  FullscreenAlertDemo
//
//  Created by Andrey Ermoshin on 10/04/2017.
//  Copyright © 2017 kyzmitch. All rights reserved.
//

#import "ViewController.h"
#import "FSAViewPresenter.h"

@interface ViewController ()
{
@private
    UIButton *_button;
}
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:[self button]];
    
    [self button].translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *buttonViews = NSDictionaryOfVariableBindings(_button);
    NSArray *horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"|-50.0-[_button]-50.0-|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:buttonViews];
    NSArray *vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-300.0-[_button]-300.0-|"
                                                                options:0
                                                                metrics:nil
                                                                  views:buttonViews];
    [NSLayoutConstraint activateConstraints:horizontal];
    [NSLayoutConstraint activateConstraints:vertical];
}

- (UIButton *)button {
    if (_button == nil) {
        _button = [[UIButton alloc] init];
        [_button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitle:@"Show fullscreen alert" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_button setBackgroundColor:[UIColor whiteColor]];
    }
    
    return _button;
}

- (void)buttonPressed {
    [FSAViewPresenter showAlertOfType:ErrorView withText:@"The error description" animated:YES onClose:^{
        NSLog(@"Fullscreen alert closed");
    }];
}

@end
