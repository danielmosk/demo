//
//  CardMatchingGame.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/09/11.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSMutableArray *matchHistory;
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger scorechange;

@end

@implementation CardMatchingGame

#pragma mark - Designated initializer
#pragma mark -

- (NSObject *)init {
  return [self init];
}

- (instancetype)initWithProvider: (CardMatchingGameProvider *)gameParameters {
  if (self = [super init]) {
    self.gameParameters = gameParameters;
    if (self) {
      for (int i = 0; i < self.gameParameters.initialNumberOfCards; i++) {
        Card *card = [self.gameParameters.deck drawRandomCard];
        if (card) {
          [self.cards addObject: card];
        } else {
          self = nil;
          break; }
      }
    }
  }
  return self;
}

#pragma mark - Initialization of properties
#pragma mark -

- (NSArray *)allCards {
  if (!_allCards) _allCards = [[NSArray alloc] init];
  return _allCards;
}

- (NSMutableArray *)cards {
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (NSMutableArray *)matchHistory {
  if (!_matchHistory) _matchHistory = [[NSMutableArray alloc] init];
  return _matchHistory;
}

- (CardMatchingGameProvider *)gameParameters {
  if (!_gameParameters) _gameParameters = [[CardMatchingGameProvider alloc] init];
  return _gameParameters;
}

#pragma mark - Instance methods
#pragma mark -

- (Card *)cardAtIndex: (NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}


- (void) drawCard {
  Card *card = [self.gameParameters.deck drawRandomCard];
  if (card) {
    [self.cards addObject:card]; }
}

- (void)removeHiddenCards {
  NSMutableIndexSet *cardsToRemove = [[NSMutableIndexSet alloc] init];
  for (NSUInteger i = 0; i < [self.cards count]; i++) {
    if (((Card *)self.cards[i]).hidden) { [cardsToRemove addIndex: i];}
  }
  [self.cards removeObjectsAtIndexes:cardsToRemove];
}

- (void)deselectPreviouslyMatchedCards {
  for (Card *card in self.cards) {
    if (card.isMatched) {
      card.chosen = NO;
      card.matched = NO;
    }
  }
}

- (void)emptyAllCards {
  if ([self.allCards count] == self.gameParameters.numberOfCardsInMatchedSet) {
    self.allCards = [[NSArray alloc] init];
  }
}

- (NSInteger)applyBonusses: (NSInteger)matchScore {
  if (matchScore > 0) {
    return (matchScore * self.gameParameters.matchBonus);
  } else {
    return (-self.gameParameters.mismatchPenalty);
  }
}

#define kCOST_TO_CHOOSE 1

- (void)chooseCard: (Card *)card
{
  self.scorechange =0;
  NSInteger matchScore = 0;
  NSMutableArray *otherCards = [[NSMutableArray alloc] initWithArray:self.cards];
  [otherCards removeObject:card];
  if (!card.isMatched) {
    if (card.isChosen){
      card.chosen = NO;
    } else {
      NSMutableArray *potentiallyMatchingCards = [NSMutableArray array];
      for (Card *otherCard in otherCards) {
        if (otherCard.isChosen && !otherCard.isMatched)
        { [potentiallyMatchingCards addObject: otherCard];
          if ([potentiallyMatchingCards count] + 1 ==
            self.gameParameters.numberOfCardsInMatchedSet) {
            self.allCards = [potentiallyMatchingCards arrayByAddingObject: card];
            if (![self newMatch: self.matchHistory]) {
              break; }
            matchScore = [self.gameParameters.matchingStrategy
                          homogeneityMeasure: self.allCards];
            self.scorechange = [self applyBonusses: matchScore];
            if (matchScore) {
              [self.matchHistory addObject: self.allCards];
              card.matched = YES;
              for (Card *bufferCard in potentiallyMatchingCards)
                bufferCard.matched = YES;
            } else {
              card.chosen = NO;
              for (Card *bufferCard in potentiallyMatchingCards)
                bufferCard.chosen = NO;
            }
            break;
          }
        }
      }
      self.score += (self.scorechange - kCOST_TO_CHOOSE);
      card.chosen = YES;
    }
  }
}

- (BOOL)newMatch: (NSArray *)historyArray {
  BOOL newMatchFlag = YES;
  if ([self.matchHistory count] > 0)
    for (NSArray *match in historyArray) {
        if ([self hashMatch:self.allCards] == [self hashMatch:match]) {
          newMatchFlag = NO;
        }
      }
  return newMatchFlag;
}


- (NSUInteger)hashMatch: (NSArray *)matchedCards {
  NSUInteger value = 0;
    for (int i = 0; i < [matchedCards count]; i++){
      Card *tempCard = matchedCards[i];
      value += (tempCard.integerContents * pow([tempCard numberOfCards],i));
    }
  return value;
}





@end
