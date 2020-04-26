"
Simple Pair
"
Class {
	#name : #Pair,
	#superclass : #CardsHand,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
Pair class >> matches: someCards [
	^ (someCards collect: #value) asSet size + 1 = someCards size
]
