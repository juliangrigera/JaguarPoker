"
Five of a suit
"
Class {
	#name : #Poker,
	#superclass : #CardsHand,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
Poker class >> matches: someCards [
	^ (someCards groupedBy: #value) anySatisfy: [ :cards | cards size = 4 ]
]
