"
A PokerHand State

Fixed flow: FreshState -> DealtState -> ChangeCardsState -> BidState 
"
Class {
	#name : #PokerHandState,
	#superclass : #Object,
	#instVars : [
		'hand'
	],
	#category : #'JaguarPoker-Model'
}

{ #category : #'instance creation' }
PokerHandState class >> hand: aPokerHand [
	^ self new
		hand: aPokerHand;
		yourself
]

{ #category : #visitor }
PokerHandState >> accept: aHost with: aParameter [
	self subclassResponsibility
]

{ #category : #game }
PokerHandState >> acceptBets [
	self error: 'Cannot take bets right now'
]

{ #category : #testing }
PokerHandState >> canAcceptBets [
	^ false
]

{ #category : #testing }
PokerHandState >> canChangeCards [
	^ false
]

{ #category : #testing }
PokerHandState >> canDeal [
	^ false
]

{ #category : #testing }
PokerHandState >> canSharePot [
	^ false
]

{ #category : #testing }
PokerHandState >> canShowCards [
	^ false
]

{ #category : #game }
PokerHandState >> deal [
	self error: 'Cannot deal now'
]

{ #category : #game }
PokerHandState >> enableCardsChange [
	self error: 'Cannot allow cards change now'
]

{ #category : #game }
PokerHandState >> enableCardsShowing [
	self error: 'Cannot show cards yet'
]

{ #category : #accessing }
PokerHandState >> hand [
	^ hand
]

{ #category : #accessing }
PokerHandState >> hand: aPokerHand [ 
	hand := aPokerHand
]

{ #category : #testing }
PokerHandState >> isFresh [
	^ false
]

{ #category : #'game - bets' }
PokerHandState >> placeAnteFor: aPlayer [
	self error: 'No se puede poner luz ahora'
]

{ #category : #'game - bets' }
PokerHandState >> placeAnteOf: chipsCount for: aPlayer [
	self error: 'No se puede poner luz ahora'
]

{ #category : #'game - bets' }
PokerHandState >> placeFirstBet: anInteger for: aPlayer [
	self error: 'Cannot first bet right now'
]

{ #category : #'game - bets' }
PokerHandState >> placeSecondBet: anInteger for: aPlayer [
	self error: 'No se puede apostar ahora'
]

{ #category : #game }
PokerHandState >> rotateSpeaker [
	"Do nothing"
]

{ #category : #testing }
PokerHandState >> showingCards [
	^ false
]

{ #category : #game }
PokerHandState >> speakingPlayers [
	^ self hand activePlayers
]
