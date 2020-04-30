"
A poker game.

Manages pokers hands. Has a previous state where it waits for players (but no State pattern).
"
Class {
	#name : #PokerGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'code',
		'currentHand',
		'dealer'
	],
	#classInstVars : [
		'StoredGames'
	],
	#category : #'JaguarPoker-Model'
}

{ #category : #'instance creation' }
PokerGame class >> gameWithCode: aString [
	^ self storedGames
		detect: [ :game | game code = aString ]
		ifNone: [ self newGameWithCode: aString ]
]

{ #category : #'class initialization' }
PokerGame class >> initialize [
	StoredGames := nil
]

{ #category : #accessing }
PokerGame class >> newGameWithCode: aString [
	| newGame |
	newGame := self new
		code: aString;
		yourself.
	self storedGames add: newGame.
	^ newGame
]

{ #category : #'instance creation' }
PokerGame class >> players: somePlayers [
	^ self new
		players: somePlayers;
		yourself
]

{ #category : #accessing }
PokerGame class >> storedGames [
	^ StoredGames ifNil: [ StoredGames := OrderedCollection new ]
]

{ #category : #accessing }
PokerGame >> addPlayer: aPlayer [
	self players
		detect: [ :player | player name = aPlayer name ]
		ifNone: [ self playersCount < 5
				ifTrue: [ self players add: aPlayer ]
				ifFalse: [ self error: 'Somos muchos' ] ]
]

{ #category : #testing }
PokerGame >> canStart [
	^ self playersCount >= 4
]

{ #category : #accessing }
PokerGame >> code [
	^ code
]

{ #category : #accessing }
PokerGame >> code: anObject [
	code := anObject
]

{ #category : #accessing }
PokerGame >> currentHand: anObject [
	currentHand := anObject
]

{ #category : #accessing }
PokerGame >> currentPokerHand [
	^ currentHand
]

{ #category : #accessing }
PokerGame >> dealer [
	^ dealer
]

{ #category : #accessing }
PokerGame >> dealer: anObject [
	dealer := anObject
]

{ #category : #initialization }
PokerGame >> initialize [
	super initialize.
	players := OrderedCollection new
]

{ #category : #accessing }
PokerGame >> lesserCardValue [
	^ self playersCount = 5
		ifTrue: [ 6 ]
		ifFalse: [ 7 ]
]

{ #category : #private }
PokerGame >> mustKeepAntes [
	^ self currentPokerHand isNotNil
		and: [ self currentPokerHand allAntesPlaced
				& self currentPokerHand firstBets isEmpty ]
]

{ #category : #game }
PokerGame >> newHand [
	| newHand |
	self
		resetPlayers;
		rotateDealer.
	newHand := self mustKeepAntes
		ifTrue: [ PokerExtraHand
				players: self players
				dealer: self dealer
				pot: self currentPokerHand pot ]
		ifFalse: [ PokerHand players: self players dealer: self dealer ].
	self currentHand: newHand
]

{ #category : #accessing }
PokerGame >> playerNamedOrNew: aString [
	^ self players
		detect: [ :player | player name = aString ]
		ifNone: [ Player name: aString ]
]

{ #category : #accessing }
PokerGame >> players [
	^ players
]

{ #category : #accessing }
PokerGame >> players: anObject [
	players := anObject
]

{ #category : #accessing }
PokerGame >> playersCount [
	^ self players size
]

{ #category : #game }
PokerGame >> resetPlayers [
	self players do: [ :player | player returnCards ]
]

{ #category : #game }
PokerGame >> rotateDealer [
	| nextDealer |
	nextDealer := self players
		after: self dealer
		ifAbsent: [ self players first ].
	self dealer: nextDealer
]

{ #category : #game }
PokerGame >> start [
	self newHand
]

{ #category : #testing }
PokerGame >> started [
	^ self currentPokerHand isNotNil
]

{ #category : #testing }
PokerGame >> stillOn [
	^ true
]
