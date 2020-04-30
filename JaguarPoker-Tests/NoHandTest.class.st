"
A NoHandTest is a test class for testing the behavior of NoHand
"
Class {
	#name : #NoHandTest,
	#superclass : #CardsHandTest,
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #test }
NoHandTest >> testBeats [
	|a9jk6 a97k6 aq1086|
	a9jk6 := CardsHand fromCards: { 'A' ofClubs . '9' ofHearts . 'J' ofClubs . 'K' ofHearts . '6' ofClubs } inGame: gameOf5.
	a97k6 := CardsHand fromCards: { 'A' ofClubs . '9' ofHearts . '7' ofClubs . 'K' ofHearts . '6' ofClubs } inGame: gameOf5.
	aq1086 := CardsHand fromCards: { 'A' ofClubs . 'Q' ofHearts . '10' ofClubs . '8' ofHearts . '6' ofClubs } inGame: gameOf5.
	self
		assert: (a9jk6 beats: a97k6);
		assert: (a9jk6 beats: a97k6);
		assert: (a97k6 beats: aq1086)
]
