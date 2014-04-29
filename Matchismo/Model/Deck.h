//
//  Deck.h
//  Matchismo
//
//  Created by Jared Smith on 4/28/14.
//  Copyright (c) 2014 jaredsmithse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
