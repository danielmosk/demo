// Copyright (c) 2016年 Lightricks. All rights reserved.
// Created by Daniel Moskovich.

#import <UIKit/UIKit.h>

#import "Card.h"

#import "PlayingCardView.h"

NS_ASSUME_NONNULL_BEGIN

/// Contains a card in play, its location on the gridView, and its view.

@interface CardViewInGrid : NSObject


@property (strong, nonatomic) Card *cardForView;
@property (nonatomic) NSUInteger gridLocation;
@property (strong, nonatomic) UIView *view;

@end

NS_ASSUME_NONNULL_END
