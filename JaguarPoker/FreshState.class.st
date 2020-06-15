"
A PokerHand State

Just created, here we can: 
	- place antes
	- deal, if all antes are placed
	
Automated push forward, after dealt moves to DealtState
"
Class {
	#name : #FreshState,
	#superclass : #PokerHandState,
	#category : #'JaguarPoker-Model'
}

{ #category : #visitor }
FreshState >> accept: aHost with: aParameter [
	^ aHost visitFreshHand: self with: aParameter
]

{ #category : #game }
FreshState >> canDeal [
	^ self hand allAntesPlaced
]

{ #category : #game }
FreshState >> deal [
	self canDeal
		ifTrue: [ self hand doDeal.
			self hand state: (DealtState hand: self hand) ]
		ifFalse: [ self error: 'Some antes are missing' ]
]

{ #category : #testing }
FreshState >> isFresh [
	^ true
]

{ #category : #'game - bids' }
FreshState >> placeAnteFor: aPlayer [
	hand addBet: (aPlayer getAnte)
]

{ #category : #'game - bids' }
FreshState >> placeAnteOf: chipsCount for: aPlayer [
	hand addBet: (aPlayer getAnteOf: chipsCount)
]
