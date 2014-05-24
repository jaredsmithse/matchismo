//
//  Card.m
//  Matchismo
//
//  Created by Jared Smith on 4/24/14.
//  Copyright (c) 2014 jaredsmithse. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

- (NSArray *)getMatches:(NSArray *)otherCards
{
    return nil;
}

@end
