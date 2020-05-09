"
A PokerHand State

Just dealt the cards, here we can: 
	- place bets (small, first round)
	- fold
	
Manual push forward towards ChangeCardsState
"
Class {
	#name : #DealtState,
	#superclass : #PokerHandState,
	#category : #'JaguarPoker-Model'
}

{ #category : #visitor }
DealtState >> accept: aHost with: aParameter [
	^ aHost visitDealtHand: self with: aParameter
]

{ #category : #testing }
DealtState >> canChangeCards [
	^ self hand firstBetsRoundDone
]

{ #category : #game }
DealtState >> enableCardsChange [
	self hand canChangeCards
		ifTrue: [ self hand activePlayers size > 1
				ifTrue: [ self hand
						state: (ChangeCardsState hand: self hand);
						resetSpeaker ]
				ifFalse: [ self hand state: (ShowCardsState hand: self hand) ] ]
		ifFalse: [ super enableCardsChange ]
]

{ #category : #visitor }
DealtState >> placeFirstBet: anInteger for: aPlayer [
	| chipsToCall allIn maxBet|
	allIn := anInteger >= aPlayer chipsCount.
	maxBet := anInteger min: aPlayer chipsCount.
	chipsToCall := hand chipsToCallFirstBetFor: aPlayer.
	hand addBet: (aPlayer getFirstBetOf: maxBet).
	anInteger > chipsToCall
		ifTrue: [ hand lastRaiser: aPlayer ].
	allIn ifTrue: [ hand markAsAllIn: aPlayer].
	hand rotateSpeaker
]

{ #category : #visitor }
DealtState >> raiseFirstBet: anInteger for: aPlayer [
	| chipsToCall bet allIn |
	chipsToCall := hand chipsToCallFirstBetFor: aPlayer.
	bet := chipsToCall + anInteger.
	allIn := bet >= aPlayer chipsCount.
	hand addBet: (aPlayer getFirstBetOf: bet).
	anInteger > 0
		ifTrue: [ hand lastRaiser: aPlayer ].
	allIn
		ifTrue: [ hand markAsAllIn: aPlayer ].
	hand rotateSpeaker
]

{ #category : #game }
DealtState >> rotateSpeaker [
	self hand firstBetsRoundDone
		ifFalse: [ self hand speaker: (self hand firstBettingPlayerAfter: self hand speaker) ]
		ifTrue: [ self hand speaker: nil ]
]

{ #category : #game }
DealtState >> speakingPlayers [
	^ self hand activePlayers
		reject: [ :bettingPlayer | self hand isAllIn: bettingPlayer ]
]
