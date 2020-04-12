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
		ifTrue: [ self hand
				state: (ChangeCardsState hand: self hand);
				resetSpeaker ]
		ifFalse: [ super enableCardsChange ]
]

{ #category : #visitor }
DealtState >> placeFirstBet: anInteger for: aPlayer [
	| chipsToCall |
	chipsToCall := hand chipsToCallFirstBetFor: aPlayer.
	hand addBet: (aPlayer getFirstBetOf: anInteger).
	anInteger > chipsToCall
		ifTrue: [ hand lastRaiser: aPlayer ].
	hand rotateSpeaker
]

{ #category : #visitor }
DealtState >> raiseFirstBet: anInteger for: aPlayer [
	| chipsToCall |
	chipsToCall := hand chipsToCallFirstBetFor: aPlayer.
	hand addBet: (aPlayer getFirstBetOf: chipsToCall + anInteger).
	anInteger > 0
		ifTrue: [ hand lastRaiser: aPlayer ].
	hand rotateSpeaker
]

{ #category : #game }
DealtState >> rotateSpeaker [
	self hand firstBetsRoundDone
		ifFalse: [ self hand doRotateSpeaker ]
		ifTrue: [ self hand speaker: nil ]
]
