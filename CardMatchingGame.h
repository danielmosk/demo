//
//  CardMatchingGame.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/09/11.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
// TODO: Eliminate initWithDeck
// Replace by initWithProvider

#import <Foundation/Foundation.h>

#import "CardMatchingGameProvider.h"
#import "Deck.h"

/// Parent model for card matching games.

@interface CardMatchingGame : NSObject

/// Initializes with the given parameters
- (instancetype)initWithProvider: (CardMatchingGameProvider *)gameParameters
NS_DESIGNATED_INITIALIZER;

/// Returns the card at a given index of the game's internal array or nil.
- (Card *)cardAtIndex: (NSUInteger)index;
/// Response of the game to a choice of card.
- (void)chooseCard: (Card *)card;
/// Deselects cards matched on the previous turn.
- (void)deselectPreviouslyMatchedCards;
/// Draws a random card from the deck and add it to the game.
- (void)drawCard;
/// Empties a collection of cards which has been matched on the previous turn.
- (void)emptyAllCards;
/// Has the player seen this match before?
- (BOOL)newMatch: (NSArray *)historyArray;
/// Removes hidden cards.
- (void)removeHiddenCards;

/// Cards currently under consideration for forming a set.
@property (nonatomic, strong) NSArray *allCards;
/// All cards currently in play.
@property (nonatomic, strong) NSMutableArray *cards;
/// The history of successful matches so far.
@property (nonatomic, readonly) NSMutableArray *matchHistory;
/// The game score.
@property (nonatomic, readonly) NSInteger score;
/// The change in the game score on this turn.
@property (nonatomic, readonly) NSInteger scorechange;
/// The parameters that characterize the game.
@property (nonatomic, strong) CardMatchingGameProvider *gameParameters;

@end
