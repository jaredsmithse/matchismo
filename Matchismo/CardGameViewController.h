//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Jared Smith on 4/24/14.
//  Copyright (c) 2014 jaredsmithse. All rights reserved.
//
// Abstract class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"
@interface CardGameViewController : UIViewController

- (Deck *)createDeck; //abstract

@end
