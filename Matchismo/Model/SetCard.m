//
//  SetCard.m
//  Matchismo
//
//  Created by Jared Smith on 7/5/14.
//  Copyright (c) 2014 jaredsmithse. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (SetCard *otherCard in otherCards) {
        if ([self.suit isEqualToString:otherCard.suit]) {
            score+= 1;
        }
    }
    return score;
}

- (NSArray *)getMatches: (NSArray *)otherCards
{
    NSMutableArray *matchingCards = [[NSMutableArray alloc] init];
    for (SetCard *otherCard in otherCards) {
        if ([self.suit isEqualToString:otherCard.suit]) {
            [matchingCards addObject:otherCard];
        }
    }
    
    return matchingCards;
}

- (NSString *)contents
{
    return self.suit;
}

@synthesize suit = _suit; // because we provide setter AND getter

+ (NSArray *)validSuits
{
    return @[@"●",@"■",@"▲"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[SetCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

@end
