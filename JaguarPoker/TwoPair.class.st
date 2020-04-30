"
Two Pairs
"
Class {
	#name : #TwoPair,
	#superclass : #CardsHand,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
TwoPair class >> matches: someCards inGame: aPokerGame [
	^ (someCards groupedBy: #value having: [ :group | group size = 2 ])
		size = 2
]

{ #category : #testing }
TwoPair >> beatenBy: aCardsHand [
	^ aCardsHand beatsTwoPair: self
]

{ #category : #'double dispatch' }
TwoPair >> beatsPair: aPair [
	^ true
]

{ #category : #accessing }
TwoPair >> description [
	^ 'Dos Pares'
]

{ #category : #accessing }
TwoPair >> pureHand [
	| allValues repeatedValues |
	allValues := self cards collect: #value.
	repeatedValues := allValues
		select: [ :value | (allValues occurrencesOf: value) = 2 ].
	^ self cards select: [ :card | repeatedValues includes: card value ]
]

{ #category : #testing }
TwoPair >> tiesWith: aCardsHand [
	^ aCardsHand tiesWithTwoPair: self
]

{ #category : #testing }
TwoPair >> tiesWithTwoPair: aTwoPair [
	^ aTwoPair pureHandValues = self pureHandValues
		& (aTwoPair remainingCardValues = self remainingCardValues)
]
