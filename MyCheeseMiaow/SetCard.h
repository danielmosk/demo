//
//  SetCard.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/08/29.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger suit;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger colour;
@property (nonatomic) NSUInteger shading;


+ (NSUInteger) maxRank;

@end
