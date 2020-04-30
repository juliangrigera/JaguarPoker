"
Anny Straight, except Straight Flush
"
Class {
	#name : #Straight,
	#superclass : #CardsHand,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
Straight class >> matches: someCards inGame: aPokerGame [
	| sequential notAFlush |
	sequential := self cards: someCards areSequentialInGame: aPokerGame.
	notAFlush := (someCards collect: #suit as: Set) size > 1.
	^ someCards asSet size = 5 & sequential & notAFlush
]

{ #category : #testing }
Straight >> beatenBy: aCardsHand [
	^ aCardsHand beatsStraight: self
]

{ #category : #testing }
Straight >> beatsPair: aPair [
	^ true
]

{ #category : #testing }
Straight >> beatsStraight: aStraight [
	^ self highestValue > aStraight highestValue
]

{ #category : #testing }
Straight >> beatsThreeOfAKind: aThreeOfAKind [
	^ true
]

{ #category : #testing }
Straight >> beatsTwoPair: aTwoPair [
	^ true
]

{ #category : #accessing }
Straight >> description [
	^ 'Escalera'
]

{ #category : #testing }
Straight >> highestValue [
	^ self cardValues max
]

{ #category : #accessing }
Straight >> pureHand [
	^ self cards
]

{ #category : #testing }
Straight >> tiesWith: aCardsHand [
	^ self cardValues sorted = aCardsHand cardValues sorted
]
