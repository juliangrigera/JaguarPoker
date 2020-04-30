"
A Hand after a Hand in which no player could place an initial bet
Antes are duplicated until they hit 8
"
Class {
	#name : #PokerExtraHand,
	#superclass : #PokerHand,
	#instVars : [
		'requiredAnte'
	],
	#category : #'JaguarPoker-Model'
}

{ #category : #'instance creation' }
PokerExtraHand class >> players: somePlayers dealer: aPlayer pot: someBets [
	^ (self players: somePlayers dealer: aPlayer)
		initializePot: someBets;
		yourself
]

{ #category : #testing }
PokerExtraHand >> allAntesPlaced [
	^ self players
		allSatisfy: [ :player | 
			self pot
				anySatisfy: [ :bet | bet player = player & (bet chipsCount = self requiredAnte) ] ]
]

{ #category : #testing }
PokerExtraHand >> antePlacedFor: aPlayer [
	^ self antes anySatisfy: [ :bet | (bet player = aPlayer) & (bet chipsCount = self requiredAnte) ]
]

{ #category : #initialization }
PokerExtraHand >> initializePot: someBets [
	self
		requiredAnte: (self maximumAnte min: someBets last chipsCount * 2).
	self pot: someBets
]

{ #category : #initialization }
PokerExtraHand >> maximumAnte [
	^ 8
]

{ #category : #'game - bets' }
PokerExtraHand >> placeAnteFor: aPlayer [
	self state placeAnteOf: self requiredAnte for: aPlayer
]

{ #category : #accessing }
PokerExtraHand >> requiredAnte [
	^ requiredAnte
]

{ #category : #accessing }
PokerExtraHand >> requiredAnte: anObject [
	requiredAnte := anObject
]
