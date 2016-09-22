// Copyright (c) 2016年 Lightricks. All rights reserved.
// Created by Daniel Moskovich.

#import "CardMatchingGameProvider.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CardMatchingGameProvider

- (NSObject *)init {
  return [self init];
}

- (instancetype)initWithDeck: (Deck *)deck andInitialNumOfCards: (NSUInteger)initialNumberOfCards
               andMatchBonus: (NSUInteger)matchBonus
                 andStrategy: (id<MatchingStrategy>)matchingStrategy
          andMismatchPenalty: (NSUInteger)mismatchPenalty
andNumberOfCardsInMatchedSet: (NSUInteger)numberOfCardsInMatchedSet
        andRemoveWhenMatched: (BOOL)removeWhenMatched {
  if (self = [super init]) {
    _deck = deck;
    _initialNumberOfCards = initialNumberOfCards;
    _matchBonus = matchBonus;
    _matchingStrategy = matchingStrategy;
    _mismatchPenalty = mismatchPenalty;
    _numberOfCardsInMatchedSet = numberOfCardsInMatchedSet;
    _removeWhenMatched = removeWhenMatched;
  }
  return self;
}


NS_ASSUME_NONNULL_END

@end
