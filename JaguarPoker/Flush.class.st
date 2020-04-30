"
5 cards, all same suit
"
Class {
	#name : #Flush,
	#superclass : #CardsHand,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
Flush class >> matches: someCards inGame: aPokerGame [
	| sequential anyFlush |
	sequential := self cards: someCards areSequentialInGame: aPokerGame.
	anyFlush := (someCards collect: #suit as: Set) size = 1.
	^ someCards asSet size = 5 & anyFlush & sequential not
]

{ #category : #testing }
Flush >> beatenBy: aCardsHand [
	^ aCardsHand beatsFlush: self
]

{ #category : #testing }
Flush >> beatsFlush: aFlush [
	| values otherValues |
	values := self cardValues sorted reversed.
	otherValues := aFlush cardValues sorted reversed.
	values
		with: otherValues
		do: [ :mine :other | 
			mine > other
				ifTrue: [ ^ true ].
			other > mine
				ifTrue: [ ^ false ] ].
	^ false
]

{ #category : #testing }
Flush >> beatsFullHouse: aFullHouse [
	^ self game playersCount = 4
]

{ #category : #testing }
Flush >> beatsPair: aPair [
	^ true
]

{ #category : #testing }
Flush >> beatsStraight: aStraight [
	^ true
]

{ #category : #testing }
Flush >> beatsThreeOfAKind: aThreeOfAKind [
	^ true
]

{ #category : #testing }
Flush >> beatsTwoPair: aTwoPair [
	^ true
]

{ #category : #accessing }
Flush >> description [
	^ 'Color'
]

{ #category : #accessing }
Flush >> pureHand [
	^ self cards
]

{ #category : #testing }
Flush >> tiesWith: aCardsHand [
	^ aCardsHand tiesWithFlush: self
]

{ #category : #testing }
Flush >> tiesWithFlush: aFlush [
	^ aFlush cardValues asSet = self cardValues asSet
]
