//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Jared Smith on 7/5/14.
//  Copyright (c) 2014 jaredsmithse. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@implementation SetCardGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

@end
