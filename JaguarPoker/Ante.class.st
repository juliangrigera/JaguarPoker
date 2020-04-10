"
Ante bid
"
Class {
	#name : #Ante,
	#superclass : #Bet,
	#category : #'JaguarPoker-Model'
}

{ #category : #testing }
Ante >> isAnte [
	^ true
]

{ #category : #printing }
Ante >> printOn: aStream [
	aStream << 'Luz de '.
	aStream << self player name.
	aStream << ' ('.
	self chipsCount printOn: aStream.
	aStream << ')'.
]
