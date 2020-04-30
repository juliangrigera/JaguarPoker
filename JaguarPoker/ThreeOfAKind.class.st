"
Self explanatory
"
Class {
	#name : #ThreeOfAKind,
	#superclass : #CardsHand,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
ThreeOfAKind class >> matches: someCards inGame: aPokerGame [
	^ (someCards groupedBy: #value) size = (someCards size - 2)
		&
			(someCards groupedBy: #value having: [ :group | group size = 3 ])
				isNotEmpty
]

{ #category : #testing }
ThreeOfAKind >> beatenBy: aCardsHand [
	^ aCardsHand beatsThreeOfAKind: self
]

{ #category : #'double dispatch' }
ThreeOfAKind >> beatsPair: aPair [
	^ true
]

{ #category : #testing }
ThreeOfAKind >> beatsThreeOfAKind: aThreeOfAKind [
	| values otherValues |
	self numericValue > aThreeOfAKind numericValue
		ifTrue: [ ^ true ].
	self numericValue = aThreeOfAKind numericValue
		& (self remainingCardValues size > aThreeOfAKind remainingCardValues size)
		ifTrue: [ ^ true ].
	self numericValue = aThreeOfAKind numericValue
		ifTrue: [ values := self remainingCardValues sorted reversed.
			otherValues := aThreeOfAKind remainingCardValues sorted reversed.
			values
				with: otherValues
				do: [ :mine :other | 
					other > mine
						ifTrue: [ ^ false ].
					mine > other
						ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : #'double dispatch' }
ThreeOfAKind >> beatsTwoPair: aTwoPair [
	^ true
]

{ #category : #accessing }
ThreeOfAKind >> description [
	^ 'Pierna'
]

{ #category : #accessing }
ThreeOfAKind >> numericValue [
	^ self pureHand anyOne numericValue
]

{ #category : #accessing }
ThreeOfAKind >> pureHand [
	| allValues repeatedValue |
	allValues := self cards collect: #value.
	repeatedValue := allValues
		detectMax: [ :value | allValues occurrencesOf: value ].
	^ self cards select: [ :card | card value = repeatedValue ]
]

{ #category : #testing }
ThreeOfAKind >> tiesWith: aCardsHand [
	^ aCardsHand tiesWithThreeOfAKind: self
]

{ #category : #testing }
ThreeOfAKind >> tiesWithThreeOfAKind: aThreeOfAKind [
	^ self pureHandValues = aThreeOfAKind pureHandValues
		& (self remainingCardValues = aThreeOfAKind remainingCardValues)
]
