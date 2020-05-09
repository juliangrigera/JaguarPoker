"
A PokerHand State

All initial bets are equal, here we can just change cards.

Manual push forward towards BidState
"
Class {
	#name : #ChangeCardsState,
	#superclass : #PokerHandState,
	#category : #'JaguarPoker-Model'
}

{ #category : #visitor }
ChangeCardsState >> accept: aHost with: aParameter [
	^ aHost visitChangingCardsHand: self with: aParameter
]

{ #category : #game }
ChangeCardsState >> acceptBets [
	self hand state: (BetState hand: self hand).
	(hand isAllIn: hand lastRaiser)
		ifTrue: [ self hand speaker: (hand firstActiveAfter: hand lastRaiser) ]
		ifFalse: [ self hand speaker: hand lastRaiser ]
]

{ #category : #testing }
ChangeCardsState >> canAcceptBets [
	^ true
]

{ #category : #game }
ChangeCardsState >> rotateSpeaker [
	self hand changesRoundDone
		ifFalse: [ self hand speaker: (self hand firstActiveAfter: self hand speaker) ]
		ifTrue: [ self hand speaker: nil ]
]
