//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Jared Smith on 7/5/14.
//  Copyright (c) 2014 jaredsmithse. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [SetCard validSuits]) {
            for (NSUInteger rank = 1; rank <= 100; rank++) {
                SetCard *card = [[SetCard alloc] init];
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    
    return self;
}


@end
