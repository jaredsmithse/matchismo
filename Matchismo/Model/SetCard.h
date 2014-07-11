//
//  SetCard.h
//  Matchismo
//
//  Created by Jared Smith on 7/5/14.
//  Copyright (c) 2014 jaredsmithse. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *suit;

+ (NSArray *)validSuits;

@end
