// Copyright (c) 2016年 Lightricks. All rights reserved.
// Created by Daniel Moskovich.

#import <UIKit/UIKit.h>

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

/// Value class for CardMatchingGame

@interface CardMatchingGameProvider : NSObject

/// Designated initializer
- (instancetype)initWithDeck: (Deck *)deck andInitialNumOfCards: (NSUInteger)initialNumberOfCards
andNumberOfCardsInMatchedSet:  (NSUInteger)numberOfCardsInMatchedSet
        andRemoveWhenMatched: (BOOL)removeWhenMatched NS_DESIGNATED_INITIALIZER;

/// The deck of cards used in the game.
@property (strong, nonatomic) Deck *deck;
/// Sets the number of cards with which the game begins.
@property (nonatomic) NSUInteger initialNumberOfCards;
/// Number of cards we must match for a set
@property (nonatomic) NSUInteger numberOfCardsInMatchedSet;
/// Determines whether matched cards are removed from the game.
@property (nonatomic) BOOL removeWhenMatched;


@end

NS_ASSUME_NONNULL_END
