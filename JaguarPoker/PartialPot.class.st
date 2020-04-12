Class {
	#name : #PartialPot,
	#superclass : #Object,
	#instVars : [
		'hand',
		'player'
	],
	#category : #'JaguarPoker-Model'
}

{ #category : #'instance creation' }
PartialPot class >> player: aPlayer hand: aPokerHand [
	^ self new
		player: aPlayer;
		hand: aPokerHand;
		yourself
]

{ #category : #accessing }
PartialPot >> activePlayers [
	^ self hand activePlayers
]

{ #category : #accessing }
PartialPot >> chipsCount [
	| foldedPlayers foldedPlayersBets ownBet othersMaxBets |
	foldedPlayers := self hand players copyWithoutAll: self activePlayers.
	foldedPlayersBets := (self hand pot
		select: [ :bet | foldedPlayers includes: bet player ])
		sumNumbers: #chipsCount.
	ownBet := self hand totalInPotFor: self player.
	othersMaxBets := self otherPlayers
		sumNumbers: [ :otherPlayer | (self hand totalInPotFor: otherPlayer) min: ownBet ].
	^ foldedPlayersBets + ownBet + othersMaxBets
]

{ #category : #accessing }
PartialPot >> hand [
	^ hand
]

{ #category : #accessing }
PartialPot >> hand: anObject [
	hand := anObject
]

{ #category : #accessing }
PartialPot >> otherPlayers [
	^ self hand activePlayers copyWithout: self player
]

{ #category : #accessing }
PartialPot >> player [
	^ player
]

{ #category : #accessing }
PartialPot >> player: anObject [
	player := anObject
]
