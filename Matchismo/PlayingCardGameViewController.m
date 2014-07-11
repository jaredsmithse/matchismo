//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Jared Smith on 7/2/14.
//  Copyright (c) 2014 jaredsmithse. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}
@end
