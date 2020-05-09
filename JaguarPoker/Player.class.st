"
A poker player.

Manages chips and cards on each hand. Needs to be reset after each hand to give back the cards.
"
Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'chips',
		'cards',
		'passed',
		'visibleCards',
		'changedCards',
		'cashboxesCount'
	],
	#category : #'JaguarPoker-Model'
}

{ #category : #accessing }
Player class >> name: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : #testung }
Player >> canShow: aCard [
	^ self visibleCards includes: aCard
]

{ #category : #accessing }
Player >> cards [
	^ cards
]

{ #category : #accessing }
Player >> cards: anObject [
	cards := anObject
]

{ #category : #accessing }
Player >> cardsCount [
	^ cards size
]

{ #category : #game }
Player >> cardsHandInGame: aPokerGame [
	^ CardsHand fromCards: self visibleCards inGame: aPokerGame
]

{ #category : #'game - bets' }
Player >> cashboxValue [
	^ 100
]

{ #category : #accessing }
Player >> cashboxesCount [
	^ cashboxesCount
]

{ #category : #accessing }
Player >> changedCards [
	^ changedCards
]

{ #category : #accessing }
Player >> chips [
	^ chips
]

{ #category : #accessing }
Player >> chips: anObject [
	chips := anObject
]

{ #category : #accessing }
Player >> chipsCount [
	^ self chips
]

{ #category : #game }
Player >> discard: someCards [
	self cards removeAll: someCards.
	changedCards := true
]

{ #category : #game }
Player >> drawCards: someCards [
	self cards addAll: someCards
]

{ #category : #'game - bets' }
Player >> getAnte [
	self chips: self chips - 1.
	^ Ante of: 1 for: self
]

{ #category : #'game - bets' }
Player >> getAnteOf: chipsCount [
	self chips: self chips - chipsCount.
	^ Ante of: chipsCount for: self
]

{ #category : #'game - bets' }
Player >> getCashbox [
	cashboxesCount := cashboxesCount + 1.
	self chips: self chips + self cashboxValue
]

{ #category : #accessing }
Player >> getChips: anInteger [
	self chips: self chips + anInteger
]

{ #category : #'game - bets' }
Player >> getFirstBetOf: anInteger [
	| bet |
	bet := anInteger min: self chipsCount.
	self chips: self chips - bet.
	^ FirstBet of: bet for: self
]

{ #category : #'game - bets' }
Player >> getSecondBetOf: anInteger [
	| bet |
	bet := anInteger min: self chipsCount.
	self chips: self chips - bet.
	^ SecondBet of: bet for: self
]

{ #category : #initialization }
Player >> initialize [
	chips := self cashboxValue.
	cashboxesCount := 1.
	cards := OrderedCollection new.
	changedCards := false.
	passed := false.
	visibleCards := OrderedCollection new
]

{ #category : #accessing }
Player >> name [
	^ name
]

{ #category : #accessing }
Player >> name: anObject [
	name := anObject
]

{ #category : #accessing }
Player >> pass [
	passed := true
]

{ #category : #accessing }
Player >> passed [
	^ passed
]

{ #category : #accessing }
Player >> passed: aBoolean [
	passed := aBoolean
]

{ #category : #printing }
Player >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: self name;
		nextPutAll: ')'
]

{ #category : #game }
Player >> returnCards [
	self cards: OrderedCollection new.
	self visibleCards: OrderedCollection new.
	changedCards := false.
	passed := false
]

{ #category : #accessing }
Player >> showCards: someCards [
	self visibleCards: someCards
]

{ #category : #accessing }
Player >> visibleCards [
	^ visibleCards
]

{ #category : #accessing }
Player >> visibleCards: anObject [
	visibleCards := anObject
]
