"
Last bid, after changing cards
"
Class {
	#name : #SecondBet,
	#superclass : #Bet,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
SecondBet >> isSecondBet [
	^ true
]

{ #category : #printing }
SecondBet >> printOn: aStream [
	aStream << 'Apuesta de '.
	self chipsCount printOn: aStream.
	aStream << ' de '.
	aStream << self player name.
	
]
