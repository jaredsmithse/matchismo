//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jared Smith on 4/24/14.
//  Copyright (c) 2014 jaredsmithse. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic, readwrite) NSInteger cardsToMatch;
@property (weak, nonatomic) IBOutlet UILabel *turnInfoLabel;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] andCardsToMatch:[self getGameType]];
    self.cardsToMatch = [self getGameType];
    return _game;
}

- (IBAction)touchNewGameButton:(id)sender
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] andCardsToMatch:[self getGameType]];
    self.cardsToMatch = [self getGameType];
    self.turnInfoLabel.text = @"";
    [self updateUI];
}

- (Deck *)createDeck // abstract
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    printf("I have clicke on the CARD\n");
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateCommentaryForPlayAtIndex: cardIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle: [self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (NSInteger)getGameType
{
//    if ([[_gameType titleForSegmentAtIndex:_gameType.selectedSegmentIndex]  isEqual:@"2 Cards"]) {
        return 2;
//    } else {
//        return 3;
//    }
}

- (void)updateCommentaryForPlayAtIndex:(NSUInteger)index
{
    self.turnInfoLabel.text = self.game.turnMessage;
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *) backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}


@end
