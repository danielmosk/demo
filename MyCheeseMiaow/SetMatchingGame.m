//
//  SetMatchingGame.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/08/30.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "SetMatchingGame.h"


@interface SetMatchingGame()

@property (nonatomic, strong) NSMutableArray *cards;    //of SetCard

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger scorechange;
@property (nonatomic, readwrite) NSMutableArray *cardHistory; //of SetCard

@end


@implementation SetMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards=[[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)cardHistory
{
    if (!_cardHistory) _cardHistory = [[NSMutableArray alloc] init];
    return _cardHistory;
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
                card.chosen=NO;
            }   else {
                self = nil;
                break; }
        }
    }
    return self;
}

@synthesize score= _score;
@synthesize scorechange = _scorechange;


static const int COST_TO_CHOOSE=1;
static const int MISMATCH_PENALTY=3;
static const int MATCH_BONUS=10;


- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.scorechange=0;
    if ([self.allCards count]== 3)
    {
        self.allCards= [[NSArray alloc] init];
    }
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    for (SetCard *otherCard in self.cards)
            {
                if (otherCard.chosen)
                {
                    [otherCards addObject:otherCard];

                    if([otherCards count]==2)
                    {
                        self.allCards= [otherCards arrayByAddingObject:card];
                        card.chosen=!card.isChosen;
                        for (Card *otherCard in otherCards)
                            otherCard.chosen=NO;
                        if (self.newTriple)
                            {
                            int matchScore = [card match:otherCards];
                                if (matchScore)
                                    {
                                    [self.cardHistory addObject:self.allCards];
                                    self.scorechange = matchScore * MATCH_BONUS;
                                    }
                                else
                                  {
                                  self.scorechange -= MISMATCH_PENALTY;
                                  }
                           }
                      break;
                } // end of "if (cardcount == 2)"
            }
           }// end of for loop
        card.chosen = !card.isChosen;
        self.score += (self.scorechange - COST_TO_CHOOSE);
        NSLog(@"Score: %i", (int)self.score);
}
    
- (BOOL) newTriple
    {
        BOOL temp=YES; // object is new
        if ([self.cardHistory count]>0) // might not be new
        for (NSArray *triple in self.cardHistory)
            {
                if ([triple count]== 3)
                {
                    if ((int)[self valueForTriple:self.allCards] == (int)[self valueForTriple:triple])
                    {
                        temp = NO;
                    }
                }
            }
        NSLog(temp ? @"New" : @"Not new");
        return temp;
}



- (NSUInteger) valueForTriple: (NSArray *) tripleOfCards
{
  int value=0;
  NSArray *primes = @[@2, @3, @5];
  if ([tripleOfCards count]==3)
  {
      for (int i=0; i<[tripleOfCards count]; i++){
          SetCard *tempCard = tripleOfCards[i];
          value += tempCard.contents.intValue*(int)primes[i];
      }
  }
  return value;
}



@end
