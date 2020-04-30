"
A TwoPairTest is a test class for testing the behavior of TwoPair
"
Class {
	#name : #TwoPairTest,
	#superclass : #CardsHandTest,
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #tests }
TwoPairTest >> testMatchesInGame [
	self
		assert: (TwoPair matches: {'7' ofSpades . '7' ofClubs . 'J' ofClubs . 'J' ofDiamonds . 'A' ofSpades} inGame: gameOf4);
		assert: (TwoPair matches: {'7' ofSpades . '9' ofClubs . '7' ofClubs . '9' ofDiamonds . 'A' ofSpades} inGame: gameOf4);
		assert: (TwoPair matches: {'A' ofSpades . '9' ofClubs . '7' ofClubs . '9' ofDiamonds . '7' ofSpades} inGame: gameOf4);
		assert: (TwoPair matches: {'9' ofClubs . '7' ofClubs . '9' ofDiamonds . '7' ofSpades} inGame: gameOf4).
	self
		deny: (TwoPair matches: {} inGame: gameOf4);
		deny: (TwoPair matches: {'7' ofSpades . '7' ofClubs} inGame: gameOf4);
		deny: (TwoPair matches: {'7' ofSpades . '7' ofClubs . 'A' ofDiamonds} inGame: gameOf4);
		deny: (TwoPair matches: {'7' ofSpades . '7' ofClubs . 'J' ofClubs . '7' ofDiamonds . 'A' ofSpades} inGame: gameOf4);
		deny: (TwoPair matches: {'7' ofSpades . '9' ofClubs . 'J' ofClubs . '10' ofDiamonds . 'A' ofSpades} inGame: gameOf4);
		deny: (TwoPair matches: {'7' ofSpades . '9' ofClubs} inGame: gameOf4);
		deny: (TwoPair matches: {'7' ofSpades . '9' ofClubs . '7' ofClubs . '9' ofDiamonds . '9' ofSpades} inGame: gameOf4);
		deny: (TwoPair matches: {'7' ofSpades . '7' ofClubs . 'A' ofClubs . '7' ofDiamonds . '7' ofHearts} inGame: gameOf4)
]

{ #category : #test }
TwoPairTest >> testTiesWith [
	|aajj6 aajj7 aja6j ajaj7 aajj|
	aajj6 := CardsHand fromCards: { 'A' ofClubs . 'A' ofHearts . 'J' ofClubs . 'J' ofHearts . '6' ofClubs } inGame: gameOf5.
	aajj7 := CardsHand fromCards: { 'A' ofClubs . 'A' ofHearts . 'J' ofClubs . 'J' ofHearts . '7' ofClubs } inGame: gameOf5.
	aja6j := CardsHand fromCards: { 'A' ofClubs . 'J' ofHearts . '6' ofClubs . 'A' ofHearts . 'J' ofClubs } inGame: gameOf5.
	ajaj7 := CardsHand fromCards: { 'A' ofClubs . 'J' ofHearts . 'A' ofDiamonds . 'J' ofClubs . '7' ofSpades } inGame: gameOf5.
	aajj := CardsHand fromCards: { 'A' ofClubs . 'A' ofHearts . 'J' ofClubs . 'J' ofHearts } inGame: gameOf5.
	self
		assert: (aajj6 tiesWith: aajj6);
		assert: (aajj tiesWith: aajj);
		assert: (aajj6 tiesWith: aja6j);
		assert: (aajj7 tiesWith: ajaj7).
	self
		deny: (aajj6 tiesWith: aajj);
		deny: (aajj6 tiesWith: aajj7)
]
