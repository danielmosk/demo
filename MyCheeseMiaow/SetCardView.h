//
//  SetCardView.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/09/08.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCardGameViewController.h"

@interface SetCardView : UIView

@property (nonatomic) BOOL faceUp;

@property (nonatomic) NSUInteger suit;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger colour;
@property (nonatomic) NSUInteger shading;

@end
