"
3 and 2
"
Class {
	#name : #FullHouse,
	#superclass : #CardsHand,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
FullHouse class >> matches: someCards [
	^ someCards size = 5
		&
			((someCards groupedBy: #value)
				allSatisfy: [ :cards | cards size >= 2 ])
]
