"
Main WAComponent.

Task for managing the flow of: login -> wait for other players-> start game
"
Class {
	#name : #PokerMainTask,
	#superclass : #WATask,
	#instVars : [
		'gamingPlayer'
	],
	#category : #'JaguarPoker-Web'
}

{ #category : #testing }
PokerMainTask class >> canBeRoot [
	^ true
]

{ #category : #testing }
PokerMainTask class >> initialize [
	(WAAdmin register: self asApplicationAt: #poker)
		addLibrary: JQDeploymentLibrary;
		addLibrary: JQUiDeploymentLibrary;
		addLibrary: TBSDeploymentLibrary;
		addLibrary: PokerFileLibrary;
		sessionClass: PokerSession
]

{ #category : #accessing }
PokerMainTask >> game [
	^ self gamingPlayer game
]

{ #category : #accessing }
PokerMainTask >> gamingPlayer [
	^ gamingPlayer
]

{ #category : #accessing }
PokerMainTask >> gamingPlayer: anObject [
	^ gamingPlayer := anObject
]

{ #category : #running }
PokerMainTask >> go [
	[ gamingPlayer := self call: PokerLogin new ]
		doWhileTrue: [ self gamingPlayer isNil ].
	self storePlayerInSession.
	[ self call: (PokerWaitingRoomView game: self game) ]
		doWhileFalse: [ self game canStart ].
	self game started
		ifFalse: [ self game start ].
	[ self call: (PokerHandView game: self game) ]
		doWhileTrue: [ self game stillOn ]
]

{ #category : #running }
PokerMainTask >> storePlayerInSession [
	self session player: gamingPlayer player
]
