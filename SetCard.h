//
//  SetCard.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/08/29.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card


/// For set cards, this is the total number of cards, i.e. 81.
+ (NSUInteger) maxRank;

@property (nonatomic) NSUInteger colour;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger suit;

@end
