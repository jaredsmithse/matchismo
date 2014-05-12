//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jared Smith on 4/29/14.
//  Copyright (c) 2014 jaredsmithse. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger cardsToMatch;
@property (nonatomic, readwrite) NSInteger chosenCards;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

//- (NSMutableArray *)chosenCards
//{
//    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
//    return _chosenCards;
//}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck andCardsToMatch:(NSInteger *)cardsToMatch
{
    self = [super init];
    self.cardsToMatch = cardsToMatch;
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        //if the card is chosen, flip it back over
        if (card.isChosen) {
            self.chosenCards++;
            card.chosen = NO;
        } else {
            // match against another card
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        self.chosenCards -= 2;
                        card.matched = YES;
                        otherCard.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        if (self.chosenCards >= self.cardsToMatch - 1) {
                            self.chosenCards--;
                            otherCard.chosen = NO;
                        }
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            self.chosenCards++;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

-(instancetype)init
{
    return nil;
}

@end
