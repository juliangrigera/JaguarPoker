"
A PokerHand State

All changed cards, now remaining players can:
	- place bets
	- show their cards

Last state, hand can now be replaced
"
Class {
	#name : #BetState,
	#superclass : #PokerHandState,
	#category : #'JaguarPoker-Model'
}

{ #category : #visitor }
BetState >> accept: aHost with: aParameter [
	^ aHost visitBiddingHand: self with: aParameter
]

{ #category : #testing }
BetState >> canShowCards [
	^ self hand secondBetsRoundDone
]

{ #category : #game }
BetState >> enableCardsShowing [
	self hand secondBetsAreEven
		ifTrue: [ self hand
				state: (ShowCardsState hand: self hand);
				speaker: hand lastRaiser ]
]

{ #category : #'game - bets' }
BetState >> placeSecondBet: anInteger for: aPlayer [
	| chipsToCall |
	chipsToCall := hand chipsToCallSecondBetFor: aPlayer.
	hand addBet: (aPlayer getSecondBetOf: anInteger).
	anInteger > chipsToCall
		ifTrue: [ hand lastRaiser: aPlayer ].
	hand rotateSpeaker
]

{ #category : #'game - bets' }
BetState >> raiseSecondBet: anInteger for: aPlayer [
	| chipsToCall |
	chipsToCall := hand chipsToCallSecondBetFor: aPlayer.
	hand addBet: (aPlayer getSecondBetOf: chipsToCall + anInteger).
	anInteger > 0
		ifTrue: [ hand lastRaiser: aPlayer ].
	hand rotateSpeaker
]

{ #category : #game }
BetState >> rotateSpeaker [
	self hand secondBetsRoundDone
		ifFalse: [ self hand doRotateSpeaker ]
		ifTrue: [ self hand speaker: nil ]
]
