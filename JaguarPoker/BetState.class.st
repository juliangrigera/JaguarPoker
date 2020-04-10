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
				rotateSpeaker ]
]

{ #category : #'game - bets' }
BetState >> placeSecondBet: anInteger for: aPlayer [
	hand
		addBet: (aPlayer getSecondBetOf: anInteger);
		rotateSpeaker
]

{ #category : #game }
BetState >> rotateSpeaker [
	self hand secondBetsRoundDone
		ifFalse: [ self hand doRotateSpeaker ]
		ifTrue: [ self hand speaker: nil ]
]
