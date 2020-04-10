"
Just a bundle of Player and PokerGame
"
Class {
	#name : #GamingPlayer,
	#superclass : #Object,
	#instVars : [
		'game',
		'player'
	],
	#category : #'JaguarPoker-Web'
}

{ #category : #'instance creation' }
GamingPlayer class >> game: aPokerGame player: aPlayer [
	^ self new
		game: aPokerGame;
		player: aPlayer;
		yourself
]

{ #category : #accessing }
GamingPlayer >> game [
	^ game
]

{ #category : #accessing }
GamingPlayer >> game: anObject [
	game := anObject
]

{ #category : #accessing }
GamingPlayer >> player [
	^ player
]

{ #category : #accessing }
GamingPlayer >> player: anObject [
	player := anObject
]
