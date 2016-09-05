//
//  CardMatchingGame.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 24/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;    //of Card
@property (nonatomic, readwrite) NSInteger scorechange;

@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) _cards=[[NSMutableArray alloc] init];
    return _cards;
}

- (NSUInteger) mode {
Card *card = [self.cards firstObject];
if (_mode< card.cardsInPlay)
    _mode = card.cardsInPlay;
return _mode;
}

- (instancetype)initWithCardCount:(NSUInteger) count
                        usingDeck:(Deck *) deck;
{
    self = [super init];
    
    if (self) {
        for (int i=0; i<count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card)
            {
                [self.cards addObject:card];
            }   else {
                self = nil;
                break; }
        }
    }
    return self;
}


static const int COST_TO_CHOOSE=1;
static const int MISMATCH_PENALTY=2;
static const int MATCH_BONUS=4;


- (NSArray *)allCards
{
    if (!_allCards) _allCards = [[NSArray alloc] init];
    return _allCards;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.scorechange=0;
    if ([self.allCards count]== self.mode)
    {
        self.allCards= [[NSArray alloc] init];
    }
    if (!card.isMatched) {
        if (card.isChosen){
            card.chosen = NO;
        }
        else {  //match against other card
            NSMutableArray *otherCards = [NSMutableArray array];
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isChosen && !otherCard.isMatched)
                { [otherCards addObject:otherCard];
                    NSLog(@"OtherCard: %@, %lu, %lu", otherCard.contents, [otherCards count], self.mode);
                    if ([otherCards count]+1== self.mode)
                        {
                        self.allCards= [otherCards arrayByAddingObject:card];
                        NSLog(@"OtherCard: %@.  Number of Allcards: %lu", otherCard.contents, [self.allCards count]);
                        int matchScore = [card match:otherCards];
                            if (matchScore)
                                    {
                                    self.scorechange = matchScore * MATCH_BONUS;
                                    card.matched = YES;
                                    for (Card *bufferCard in otherCards)
                                        bufferCard.matched =YES;
                                    }
                            else
                                    {
                                        card.chosen = NO;
                                    for (Card *bufferCard in otherCards)
                                            bufferCard.chosen=NO;
                                    self.scorechange -= MISMATCH_PENALTY;
                                    }
                            break;
                        }
                }
            }
            self.score += (self.scorechange - COST_TO_CHOOSE);
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


@end
