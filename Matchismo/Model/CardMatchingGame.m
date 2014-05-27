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
@property (nonatomic, readwrite) NSString* turnMessage;
@property (nonatomic, readwrite) NSInteger cardsToMatch;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSMutableArray *chosenCards;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)chosenCards
{
    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck andCardsToMatch:(NSInteger)cardsToMatch
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
        if (card.isChosen) {
            self.turnMessage = @"already chosen";
            [self.chosenCards removeObject:card];
            card.chosen = NO;
        } else {
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:self.chosenCards];
                    NSArray *matchingCards = [card getMatches:self.chosenCards];
                    if ([matchingCards count] > 0) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        [self setCommentaryForTurn:card];
                        for (Card *matchedCard in matchingCards) {
                            matchedCard.matched = YES;
                            [self.chosenCards removeObject:matchedCard];
                        }
                    } else {
                        [self setCommentaryForTurn:card];
                        self.score -= MISMATCH_PENALTY;
                        if ([self.chosenCards count] >= self.cardsToMatch - 1) {
                            Card *lastCard = [self.chosenCards firstObject];
                            [self.chosenCards removeObject:lastCard];
                            lastCard.chosen = NO;
                        }
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            if (!card.matched) {
                [self.chosenCards addObject:card];
            }
            card.chosen = YES;
        }
    }
}

- (void)setCommentaryForTurn:(Card *)card
{
    int matchScore = [card match:self.chosenCards];
    NSArray *matchingCards = [card getMatches:self.chosenCards];
    if (matchScore > 0) {
        switch ([matchingCards count]) {
            case 1:
                self.turnMessage = [NSString stringWithFormat:@"%@, %@: %d pts", [[matchingCards objectAtIndex:0] contents], card.contents, (matchScore * MATCH_BONUS)];
                break;
            case 2:
                self.turnMessage = [NSString stringWithFormat:@"%@, %@, %@: %d pts", [[matchingCards objectAtIndex:0] contents], [[matchingCards objectAtIndex:1] contents], card.contents, (matchScore * MATCH_BONUS)];
                break;
            default:
                break;
        }
    } else {
        switch ([self.chosenCards count]) {
            case 0:
                self.turnMessage = @"";
                break;
            case 1:
                self.turnMessage = [NSString stringWithFormat:@"%@, %@: -%d",[[self.chosenCards firstObject] contents], card.contents, MISMATCH_PENALTY];
                break;
            case 2:
                self.turnMessage = [NSString stringWithFormat:@"%@, %@, %@: -%d", [[self.chosenCards firstObject] contents], [[self.chosenCards objectAtIndex:1] contents], card.contents, MISMATCH_PENALTY];
                break;
            default:
                break;
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
