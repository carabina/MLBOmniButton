//
//  MLBFrameViewController.m
//  MLBOmniButtonDemo
//
//  Created by meilbn on 13/10/2016.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "MLBFrameViewController.h"
#import "MLBOmniButton.h"

@interface MLBFrameViewController ()

@property (strong, nonatomic) MLBOmniButton *buttonCenter;
@property (strong, nonatomic) MLBOmniButton *buttonTop;
@property (strong, nonatomic) MLBOmniButton *buttonLeft;
@property (strong, nonatomic) MLBOmniButton *buttonBottom;
@property (strong, nonatomic) MLBOmniButton *buttonRight;

@end

@implementation MLBFrameViewController {
	NSInteger _clickCount;
}

#pragma mark - Lifecycle

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
	[self initDatas];
	[self setupViews];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
	_buttonCenter.center = self.view.center;
	_buttonTop.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetHeight(_buttonTop.frame) / 2 + 20);
	_buttonLeft.center = CGPointMake(CGRectGetWidth(_buttonLeft.frame) / 2, CGRectGetMidY(self.view.frame));
	_buttonBottom.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetHeight(_buttonBottom.frame) / 2 - 20);
	_buttonRight.center = CGPointMake(CGRectGetWidth(self.view.frame) - CGRectGetWidth(_buttonRight.frame) / 2, CGRectGetMidY(self.view.frame));
}

#pragma mark - Private Methods

- (void)initDatas {
	_clickCount = 0;
}

- (void)setupViews {
	_buttonCenter = [self addOmniButtonWithFrame:CGRectMake(0, 0, 100, 100) bgColor:[UIColor lightGrayColor] title:@"Normal" imageName:@"icon_check_box_normal" imageViewPosition:MLBOmniButtonImageViewPositionLeft imageEdgeInsets:UIEdgeInsetsZero titleEdgeInsets:UIEdgeInsetsZero contentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
	[_buttonCenter setTitle:@"Selected" forState:UIControlStateSelected];
	[_buttonCenter setImage:[UIImage imageNamed:@"icon_check_box_selected"] forState:UIControlStateSelected];

	_buttonTop = [self addOmniButtonWithFrame:CGRectZero bgColor:[UIColor whiteColor] title:@"Top" imageName:@"icon_adding_user" imageViewPosition:MLBOmniButtonImageViewPositionTop imageEdgeInsets:UIEdgeInsetsMake(5, 15, 5, 15) titleEdgeInsets:UIEdgeInsetsZero contentEdgeInsets:UIEdgeInsetsZero];
	_buttonTop.mlb_badgePosition = MLBOmniButtonBadgePositionImageTopRight;
	_buttonTop.mlb_badgeValue = @"5";
	
	_buttonLeft = [self addOmniButtonWithFrame:CGRectZero bgColor:[UIColor whiteColor] title:@"Left" imageName:@"icon_default_avatar_grey" imageViewPosition:MLBOmniButtonImageViewPositionLeft imageEdgeInsets:UIEdgeInsetsZero titleEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8) contentEdgeInsets:UIEdgeInsetsZero];
	_buttonLeft.mlb_badgePosition = MLBOmniButtonBadgePositionImageTopLeft;
	_buttonLeft.mlb_badgeValue = @"3";
	
	_buttonBottom = [self addOmniButtonWithFrame:CGRectZero bgColor:[UIColor whiteColor] title:@"Bottom" imageName:@"icon_default_avatar_grey" imageViewPosition:MLBOmniButtonImageViewPositionBottom imageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5) titleEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8) contentEdgeInsets:UIEdgeInsetsZero];
	_buttonBottom.mlb_badgePosition = MLBOmniButtonBadgePositionLabelTopRight;
	_buttonBottom.mlb_badgeValue = @"1";
	
	_buttonRight = [self addOmniButtonWithFrame:CGRectZero bgColor:[UIColor whiteColor] title:@"Right" imageName:@"icon_button_right" imageViewPosition:MLBOmniButtonImageViewPositionRight imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8) titleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0) contentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
	_buttonRight.mlb_badgePosition = MLBOmniButtonBadgePositionLabelTopLeft;
	_buttonRight.mlb_badgeValue = @"10";
}

- (MLBOmniButton *)addOmniButtonWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor title:(NSString *)title imageName:(NSString *)imageName imageViewPosition:(MLBOmniButtonImageViewPosition)imageViewPosition imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
	MLBOmniButton *button = CGRectEqualToRect(frame, CGRectZero) ? [MLBOmniButton new] : [[MLBOmniButton alloc] initWithFrame:frame];
	button.backgroundColor = bgColor;
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//	button.imageView.backgroundColor = [UIColor redColor];
	[button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	button.mlb_imageViewPosition = imageViewPosition;
	button.imageEdgeInsets = imageEdgeInsets;
	button.titleEdgeInsets = titleEdgeInsets;
	button.contentEdgeInsets = contentEdgeInsets;
	[button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
	
	button.layer.borderColor = [UIColor colorWithRed:30 / 255.0 green:144 / 255.0 blue:255 / 255.0 alpha:1.000].CGColor;
	button.layer.borderWidth = 0.5;
	
	[self.view addSubview:button];
	
	return button;
}

#pragma mark - Action

- (void)buttonSelected:(UIButton *)sender {
	sender.selected = !sender.isSelected;
	if (sender == _buttonCenter) {
		_clickCount++;
		if (_clickCount > 10) {
			((MLBOmniButton *)sender).mlb_badgeBackgroundColor = [UIColor colorWithRed:0.214 green:0.811 blue:0.330 alpha:1.000];
			
			if (_clickCount > 15) {
				((MLBOmniButton *)sender).mlb_badgeBorderColor = [UIColor colorWithRed:0.699 green:0.215 blue:0.790 alpha:1.000];
				((MLBOmniButton *)sender).mlb_badgeBorderWidth = 1;
			}
		}
		
		if (_clickCount <= 20) {
			((MLBOmniButton *)sender).mlb_badgeValue = [@(_clickCount) stringValue];
		} else {
			((MLBOmniButton *)sender).mlb_badgeValue = @"";
			_clickCount = 0;
		}
	}
}

#pragma mark - Network Request




@end
