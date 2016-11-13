//
//  SGBaseViewController.m
//  TO-DO
//
//  Created by Siegrain on 16/5/19.
//  Copyright © 2016年 com.siegrain. All rights reserved.
//

#import "AppDelegate.h"
#import "SGBaseViewController.h"
#import "UINavigationController+Transparent.h"

@implementation SGBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _lcUser = [AppDelegate globalDelegate].lcUser;
    _cdUser = [AppDelegate globalDelegate].cdUser;
    
    [self setupViews];
    [self bindConstraints];
}

- (void)setupViews {
    [self setupNavigation];
    [self attachGestureRecognizer];
}

- (void)bindConstraints {
}

- (void)setupNavigation {
    [self.navigationController transparentNavigationBar];
    
    _leftNavigationButton = [[UIButton alloc] init];
    _leftNavigationButton.tintColor = [UIColor whiteColor];
    _leftNavigationButton.frame = CGRectMake(0, 0, 20, 17);
    _leftNavigationButton.titleLabel.font = [SGHelper themeFontNavBar];
    [_leftNavigationButton addTarget:self action:@selector(toggleDrawer) forControlEvents:UIControlEventTouchUpInside];
    [_leftNavigationButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    
    UIView *placeholderView = [[UIView alloc] init];
    placeholderView.frame = CGRectMake(0, 0, 5, 1);
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.frame = CGRectMake(0, 0, kScreenWidth - 55 * 2, 20);
    _titleLabel.font = [SGHelper themeFontNavBar];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftNavigationButton];
    UIBarButtonItem *placeHolderBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:placeholderView];
    UIBarButtonItem *titleBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_titleLabel];
    [self.navigationItem setLeftBarButtonItems:@[leftBarButtonItem, placeHolderBarButtonItem, titleBarButtonItem] animated:YES];
    
    _rightNavigationButton = [[UIButton alloc] init];
    _rightNavigationButton.tintColor = [UIColor whiteColor];
    _rightNavigationButton.frame = CGRectMake(0, 0, 20, 20);
    _rightNavigationButton.titleLabel.font = [SGHelper themeFontNavBar];
    [_rightNavigationButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [_rightNavigationButton addTarget:self action:@selector(rightNavButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightNavigationButton];
}

- (void)rightNavButtonDidPress {
    
}

- (void)attachGestureRecognizer {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    // Mark: 意为不要取消其他视图的触摸事件，为YES的话就不能触发为其他控件添加的触摸事件
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(toggleDrawer)];
    leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:leftSwipeGestureRecognizer];
}

#pragma mark - drawer

- (void)toggleDrawer {
    [[AppDelegate globalDelegate] toggleDrawer:self animated:YES];
}

#pragma mark - tap gesture method

- (void)hideKeyboard:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}
@end