//
//  PlayingCard.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 23/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray*) validSuits;
+ (NSUInteger) maxRank;

@end
