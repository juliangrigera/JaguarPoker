"
First bid, before changing cards
"
Class {
	#name : #FirstBet,
	#superclass : #Bet,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
FirstBet >> isFirstBet [
	^ true
]

{ #category : #printing }
FirstBet >> printOn: aStream [
	aStream << 'Apuesta inicial de '.
	self chipsCount printOn: aStream.
	aStream << ' de '.
	aStream << self player name
]
