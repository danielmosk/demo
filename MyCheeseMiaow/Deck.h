//
//  Deck.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 23/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject {@protected NSMutableArray *cards;}

- (void)addCard: (Card *)card atTop: (BOOL)atTop;
- (void)addCard: (Card *)card;
- (NSUInteger)count;
- (Card *)drawRandomCard;

@property (strong, nonatomic) NSMutableArray *cards; 


@end
