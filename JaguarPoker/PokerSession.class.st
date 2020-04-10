"
WASession with the currently logged player
"
Class {
	#name : #PokerSession,
	#superclass : #WASession,
	#instVars : [
		'player'
	],
	#category : #'JaguarPoker-Web'
}

{ #category : #accessing }
PokerSession >> player [
	^ player
]

{ #category : #accessing }
PokerSession >> player: anObject [
	player := anObject
]
