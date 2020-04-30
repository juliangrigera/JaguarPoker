"
A  Hand, as in the set of cards a player shows.
Create with #cards:inGame:
"
Class {
	#name : #CardsHand,
	#superclass : #Object,
	#instVars : [
		'cards',
		'game'
	],
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
CardsHand class >> cards: someCards areSequentialInGame: aPokerGame [
	| lesserCardValue sequential |
	lesserCardValue := aPokerGame lesserCardValue.
	sequential := true.
	someCards sorted
		overlappingPairsDo: [ :prev :next | 
			prev numericValue + 1 = next numericValue
				|
					(next value = 'A'
						& (someCards sorted first numericValue = lesserCardValue))
				ifFalse: [ sequential := false ] ].
	^ sequential
]

{ #category : #'instance creation' }
CardsHand class >> cards: someCards game: aPokerGame [
	^ self new
		cards: someCards;
		game: aPokerGame;
		yourself
]

{ #category : #'instance creation' }
CardsHand class >> fromCards: someCards inGame: aPokerGame [
	| handClass |
	handClass := (self allSubclasses copyWithout: NoHand)
		detect:
			[ :cardsHandClass | cardsHandClass matches: someCards inGame: aPokerGame ]
		ifNone: [ NoHand ].
	^ handClass cards: someCards game: aPokerGame
]

{ #category : #testing }
CardsHand class >> matches: someCards inGame: aPokerGame [
	^ self subclassResponsibility
]

{ #category : #testing }
CardsHand >> beatenBy: aCardsHand [
	^ self subclassResponsibility
]

{ #category : #testing }
CardsHand >> beats: aCardsHand [
	^ (self beatenBy: aCardsHand) not & (self tiesWith: aCardsHand) not
]

{ #category : #'double dispatch' }
CardsHand >> beatsFlush: aFlush [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> beatsFullHouse: aFullHouse [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> beatsNoHand: aNoHand [
	^ true
]

{ #category : #'double dispatch' }
CardsHand >> beatsPair: aPair [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> beatsPoker: aPoker [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> beatsStraight: aStraight [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> beatsStraightFlush: aStraightFlush [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> beatsThreeOfAKind: aThreeOfAKind [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> beatsTwoPair: aTwoPair [
	^ false
]

{ #category : #testing }
CardsHand >> cardValues [
	^ self cards collect: #numericValue
]

{ #category : #accessing }
CardsHand >> cards [
	^ cards
]

{ #category : #accessing }
CardsHand >> cards: someCards [ 
	cards := someCards
]

{ #category : #accessing }
CardsHand >> description [
	^ self subclassResponsibility
]

{ #category : #accessing }
CardsHand >> game [
	^ game
]

{ #category : #accessing }
CardsHand >> game: aPokerGame [ 
	game := aPokerGame
]

{ #category : #accessing }
CardsHand >> pureHand [
	^ self subclassResponsibility
]

{ #category : #accessing }
CardsHand >> pureHandValues [
	^ self pureHand collect: #numericValue as: Set
]

{ #category : #accessing }
CardsHand >> remainingCardValues [
	^ self remainingCards collect: #numericValue as: Set
]

{ #category : #accessing }
CardsHand >> remainingCards [
	^ self cards copyWithoutAll: self pureHand
]

{ #category : #testing }
CardsHand >> tiesWith: aCardsHand [
	^ self subclassResponsibility
]

{ #category : #'double dispatch' }
CardsHand >> tiesWithFlush: aFlush [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> tiesWithFullHouse: aFullHouse [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> tiesWithNoHand: aNoHand [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> tiesWithPair: aPair [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> tiesWithPoker: aPoker [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> tiesWithStraight: aStraight [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> tiesWithStraightFlush: aStraightFlush [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> tiesWithThreeOfAKind: aThreeOfAKind [
	^ false
]

{ #category : #'double dispatch' }
CardsHand >> tiesWithTwoPair: aTwoPair [
	^ false
]
