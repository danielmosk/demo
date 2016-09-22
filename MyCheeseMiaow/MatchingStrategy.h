// Copyright (c) 2016年 Lightricks. All rights reserved.
// Created by Daniel Moskovich.

NS_ASSUME_NONNULL_BEGIN

@protocol MatchingStrategy<NSObject>

- (NSUInteger)homogeneityMeasure: (NSArray *)cardsToMatch;

@end

NS_ASSUME_NONNULL_END
