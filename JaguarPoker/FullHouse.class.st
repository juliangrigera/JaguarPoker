"
3 and 2
"
Class {
	#name : #FullHouse,
	#superclass : #CardsHand,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
FullHouse class >> matches: someCards inGame: aPokerGame [
	^ someCards size = 5
		&
			((someCards groupedBy: #value)
				allSatisfy: [ :cards | cards size >= 2 ])
]

{ #category : #testing }
FullHouse >> beatenBy: aCardsHand [
	^ aCardsHand beatsFullHouse: self
]

{ #category : #'double dispatch' }
FullHouse >> beatsFlush: aFlush [
	^ self game playersCount = 5
]

{ #category : #'double dispatch' }
FullHouse >> beatsPair: aPair [
	^ true
]

{ #category : #'double dispatch' }
FullHouse >> beatsStraight: aStraight [
	^ true
]

{ #category : #'double dispatch' }
FullHouse >> beatsThreeOfAKind: aThreeOfAKind [
	^ true
]

{ #category : #'double dispatch' }
FullHouse >> beatsTwoPair: aTwoPair [
	^ true
]

{ #category : #accessing }
FullHouse >> description [
	^ 'Full'
]

{ #category : #accessing }
FullHouse >> pureHand [
	^ self cards
]

{ #category : #testing }
FullHouse >> tiesWith: aCardsHand [
	^ aCardsHand tiesWithFullHouse: self
]

{ #category : #testing }
FullHouse >> tiesWithFullHouse: aFullHouse [
	^ self cardValues sorted = aFullHouse cardValues sorted
]
