"
A simple model for bids.
"
Class {
	#name : #Bet,
	#superclass : #Object,
	#instVars : [
		'chipsCount',
		'player'
	],
	#category : #'JaguarPoker-Model'
}

{ #category : #'instance creation' }
Bet class >> of: anInteger for: aPlayer [
	^ self new
		chipsCount: anInteger;
		player: aPlayer;
		yourself
]

{ #category : #accessing }
Bet >> chipsCount [
	^ chipsCount
]

{ #category : #accessing }
Bet >> chipsCount: anObject [
	chipsCount := anObject
]

{ #category : #testing }
Bet >> isAnte [
	^ false
]

{ #category : #testing }
Bet >> isFirstBet [
	^ false
]

{ #category : #testing }
Bet >> isSecondBet [
	^ false
]

{ #category : #accessing }
Bet >> player [
	^ player
]

{ #category : #accessing }
Bet >> player: anObject [
	player := anObject
]
