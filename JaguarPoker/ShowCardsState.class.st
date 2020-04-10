"
Final state, all show cards
"
Class {
	#name : #ShowCardsState,
	#superclass : #PokerHandState,
	#category : #'JaguarPoker-Model'
}

{ #category : #visitor }
ShowCardsState >> accept: aHost with: aParameter [
	^ aHost visitShowCardsHand: self with: aParameter
]

{ #category : #testing }
ShowCardsState >> canSharePot [
	^ true
]
