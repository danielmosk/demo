//
//  SetMatchingGame.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/08/30.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardMatchingGame.h"
#import "SetCard.h"
#import "Deck.h"

@interface SetMatchingGame : CardMatchingGame


// designated initializer
- (instancetype)initWithCardCount:(NSUInteger) count
                        usingDeck:(Deck *) deck;

-(void)chooseCardAtIndex:(NSUInteger) index;

@property (nonatomic, readonly) NSMutableArray *cardHistory; //of arrays of SetCards



@end
