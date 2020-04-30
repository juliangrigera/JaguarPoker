"
Simple Pair
"
Class {
	#name : #Pair,
	#superclass : #CardsHand,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
Pair class >> matches: someCards inGame: aPokerGame [
	^ (someCards collect: #value) asSet size + 1 = someCards size
]

{ #category : #testing }
Pair >> beatenBy: aCardsHand [
	^ aCardsHand beatsPair: self
]

{ #category : #testing }
Pair >> beatsPair: aPair [
	| values otherValues |
	self numericValue > aPair numericValue
		ifTrue: [ ^ true ].
	self numericValue = aPair numericValue
		& (self remainingCardValues size > aPair remainingCardValues size)
		ifTrue: [ ^ true ].
	self numericValue = aPair numericValue
		ifTrue: [ values := self remainingCardValues sorted reversed.
			otherValues := aPair remainingCardValues sorted reversed.
			values
				with: otherValues
				do: [ :mine :other | 
					other > mine
						ifTrue: [ ^ false ].
					mine > other
						ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : #accessing }
Pair >> description [
	^ 'Par'
]

{ #category : #testing }
Pair >> numericValue [
	^ self pureHand anyOne numericValue
]

{ #category : #testing }
Pair >> pureHand [
	| allValues repeatedValue |
	allValues := self cards collect: #value.
	repeatedValue := allValues
		detectMax: [ :value | allValues occurrencesOf: value ].
	^ self cards select: [ :card | card value = repeatedValue ]
]

{ #category : #testing }
Pair >> remainingCards [
	^ self cards copyWithoutAll: self pureHand
]

{ #category : #testing }
Pair >> tiesWith: aPair [
	^ aPair tiesWithPair: self
]

{ #category : #testing }
Pair >> tiesWithPair: aPair [
	^ self pureHandValues = aPair pureHandValues
		& (self remainingCardValues = aPair remainingCardValues)
]
