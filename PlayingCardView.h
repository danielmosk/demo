//
//  PlayingCardView.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/09/08.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PlayingCardGameViewController.h"

/// View for playing cards

@interface PlayingCardView : UIView

@property (nonatomic) BOOL faceUp;
@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;

@end