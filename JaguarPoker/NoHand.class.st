"
No game
"
Class {
	#name : #NoHand,
	#superclass : #CardsHand,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
NoHand class >> matches: aCollection inGame: aPokerGame [ 
	self shouldBeImplemented.
]

{ #category : #testing }
NoHand >> beatenBy: aCardsHand [
	^ aCardsHand beatsNoHand: self
]

{ #category : #testing }
NoHand >> beatsNoHand: aNoHand [
	| values otherValues |
	values := self cardValues sorted reversed.
	otherValues := aNoHand cardValues sorted reversed.
	values
		with: otherValues
		do: [ :mine :other | 
			other > mine
				ifTrue: [ ^ false ].
			mine > other
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
NoHand >> description [
	^ 'Nada'
]

{ #category : #accessing }
NoHand >> pureHand [
	^ {  }
]

{ #category : #testing }
NoHand >> tiesWith: aCardsHand [
	^ aCardsHand tiesWithNoHand: self
]

{ #category : #testing }
NoHand >> tiesWithNoHand: aNoHand [
	^ self cardValues sorted = aNoHand cardValues sorted
]
