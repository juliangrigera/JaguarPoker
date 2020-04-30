"
Five of a suit
"
Class {
	#name : #Poker,
	#superclass : #CardsHand,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
Poker class >> matches: someCards inGame: aPokerGame [
	^ (someCards groupedBy: #value) anySatisfy: [ :cards | cards size = 4 ]
]

{ #category : #testing }
Poker >> beatenBy: aCardsHand [
	^ aCardsHand beatsPoker: self
]

{ #category : #'double dispatch' }
Poker >> beatsFlush: aFlush [
	^ true
]

{ #category : #'double dispatch' }
Poker >> beatsFullHouse: aFullHouse [
	^ true
]

{ #category : #'double dispatch' }
Poker >> beatsPair: aPair [
	^ true
]

{ #category : #testing }
Poker >> beatsPoker: aCardsHand [
	^ self numericValue > aCardsHand numericValue
]

{ #category : #'double dispatch' }
Poker >> beatsStraight: aStraight [
	^ true
]

{ #category : #'double dispatch' }
Poker >> beatsThreeOfAKind: aThreeOfAKind [
	^ true
]

{ #category : #'double dispatch' }
Poker >> beatsTwoPair: aTwoPair [
	^ true
]

{ #category : #accessing }
Poker >> description [
	^ 'Poker'
]

{ #category : #private }
Poker >> numericValue [
	^ self pureHand anyOne numericValue
]

{ #category : #accessing }
Poker >> pureHand [
	| allValues repeatedValue |
	allValues := self cards collect: #value.
	repeatedValue := allValues
		detectMax: [ :value | allValues occurrencesOf: value ].
	^ self cards select: [ :card | card value = repeatedValue ]
]

{ #category : #testing }
Poker >> tiesWith: aCardsHand [
	^ self numericValue = aCardsHand numericValue
]
