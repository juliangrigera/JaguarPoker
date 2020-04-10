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
		'visibleCards',
		'changedCards'
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

{ #category : #accessing }
Player >> getChips: anInteger [
	self chips: self chips + anInteger
]

{ #category : #'game - bets' }
Player >> getFirstBetOf: anInteger [
	self chips: self chips - anInteger.
	^ FirstBet of: anInteger for: self
]

{ #category : #'game - bets' }
Player >> getSecondBetOf: anInteger [
	self chips: self chips - anInteger.
	^ SecondBet of: anInteger for: self
]

{ #category : #initialization }
Player >> initialize [
	chips := 100.
	cards := OrderedCollection new.
	changedCards := false.
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
	changedCards := false
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
