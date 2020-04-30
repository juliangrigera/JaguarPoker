"
Straight and Flush
"
Class {
	#name : #StraightFlush,
	#superclass : #Straight,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
StraightFlush class >> matches: someCards inGame: aPokerGame [
	| sequential alsoAFlush |
	sequential := self cards: someCards areSequentialInGame: aPokerGame.
	alsoAFlush := (someCards collect: #suit as: Set) size = 1.
	^ someCards asSet size = 5 & sequential & alsoAFlush
]

{ #category : #testing }
StraightFlush >> beatenBy: aCardsHand [
	^ aCardsHand beatsStraightFlush: self
]

{ #category : #'double dispatch' }
StraightFlush >> beatsFlush: aFlush [
	^ true
]

{ #category : #'double dispatch' }
StraightFlush >> beatsFullHouse: aFullHouse [
	^ true
]

{ #category : #'double dispatch' }
StraightFlush >> beatsPoker: aPoker [
	^ true
]

{ #category : #accessing }
StraightFlush >> description [
	^ 'ROYAL!!!'
]
