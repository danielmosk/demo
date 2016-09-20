// Copyright (c) 2016年 Lightricks. All rights reserved.
// Created by Daniel Moskovich.

#import <UIKit/UIKit.h>

#import "Card.h"
#import "CardViewInGrid.h"


NS_ASSUME_NONNULL_BEGIN

/// Container class for CardViewInGrid objects, with methods to access individual data fields.

@interface arrayOfCardViewInGrid :  NSMutableArray { NSMutableArray *_backendArray; }

/// Finds the card displays in a given view.
- (Card*) cardForView: (UIView *)view;
/// Answers whether a given card is currently being displayed.
- (BOOL) doesThisArray: (NSArray *)array containTheCard: (Card *)card;
/// Finds the location of a given card.
- (NSUInteger) locationForCard: (Card *)card;
/// Removes an entry containing a given card.
- (void) removeEntry: (Card *)card;
/// Finds the view displaying a given card.
- (UIView *) viewForCard: (Card *)card;

@end

NS_ASSUME_NONNULL_END
