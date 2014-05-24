//
//  Card.h
//  Matchismo
//
//  Created by Jared Smith on 4/24/14.
//  Copyright (c) 2014 jaredsmithse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;
- (NSArray *)getMatches: (NSArray *)otherCards;

@end
