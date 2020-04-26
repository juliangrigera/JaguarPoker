"
A  Hand, as in the set of cards a player shows.
Create with #cards:inGame:
"
Class {
	#name : #CardsHand,
	#superclass : #Object,
	#instVars : [
		'cards',
		'game'
	],
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
CardsHand class >> matches: someCards [
	^ self subclassResponsibility
]

{ #category : #testing }
CardsHand >> beats: aCardsHand [
	^ self subclassResponsibility
]
