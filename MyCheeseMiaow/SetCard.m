//
//  SetCard.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/08/29.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (id) init
{
    self= [super init];
    if (self) {
        self.cardsInPlay=3;
    }
    return self;
}

- (int)match:(NSArray *)setofSetCards //length 2.
{
    int match=0;
    SetCard *firstCard= [setofSetCards firstObject];
    SetCard *secondCard= [setofSetCards lastObject];
    if (((self.number+firstCard.number+secondCard.number)%3 == 0) && ((self.colour+firstCard.colour+secondCard.colour)%3 == 0) && ((self.colour+firstCard.colour+secondCard.colour)%3 == 0) && ((self.suit+firstCard.suit+secondCard.suit)%3 == 0))
        match=1;
    return match;
}


- (void)setNumber:(NSUInteger)rank
{
    if (rank) {
        _number = rank %3;
    }
}

- (void)setColour:(NSUInteger)rank
{
    if (rank) {
        _colour = (rank /3)%3;
    }
}

- (void)setShading:(NSUInteger)rank
{
    if (rank) {
        _shading = (rank /9)%3;
    }
}

//@"●",  @"■", @"▲"
- (void)setSuit:(NSUInteger)rank
{
    if (rank) {
        _suit= (rank/27)%3;
    }
}


+ (NSUInteger)maxRank
{
    return 81;
}

- (NSString *)contents
{
    return [NSString stringWithFormat:@"%lu,", (self.number+(3*self.colour)+(9*self.shading)+(27*self.suit))];
}


@end
