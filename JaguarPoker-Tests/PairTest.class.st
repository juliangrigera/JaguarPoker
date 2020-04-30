"
A PairTest is a test class for testing the behavior of Pair
"
Class {
	#name : #PairTest,
	#superclass : #CardsHandTest,
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #tests }
PairTest >> testBeats [
	|aajk6  aajk7 ajak6 aj8j7 aajj qq kkj kkjb aak109 |
	aajk6 := CardsHand fromCards: { 'A' ofClubs . 'A' ofHearts . 'J' ofClubs . 'K' ofHearts . '6' ofClubs } inGame: gameOf5.
	aajk7 := CardsHand fromCards: { 'A' ofClubs . 'A' ofHearts . 'J' ofClubs . 'K' ofHearts . '7' ofClubs } inGame: gameOf5.
	ajak6 := CardsHand fromCards: { 'A' ofClubs . 'J' ofHearts . 'A' ofSpades . 'K' ofHearts . '6' ofClubs } inGame: gameOf5.
	ajak6 := CardsHand fromCards: { 'A' ofClubs . 'J' ofHearts . 'A' ofSpades . 'K' ofHearts . '6' ofClubs } inGame: gameOf5.
	aak109 := CardsHand fromCards: { 'A' ofClubs . 'A' ofHearts . 'K' ofClubs . '10' ofHearts . '9' ofClubs } inGame: gameOf5.
	aj8j7 := CardsHand fromCards: { 'A' ofClubs . 'J' ofHearts . '8' ofDiamonds . 'J' ofClubs . '7' ofSpades } inGame: gameOf5.
	aajj := CardsHand fromCards: { 'A' ofClubs . 'A' ofHearts . 'J' ofClubs . 'J' ofHearts } inGame: gameOf5.
	qq := CardsHand fromCards: { 'Q' ofClubs . 'Q' ofHearts } inGame: gameOf5.
	kkj := CardsHand fromCards: { 'K' ofSpades . 'K' ofDiamonds . 'J' ofClubs} inGame: gameOf5.
	kkjb := CardsHand fromCards: { 'K' ofClubs . 'K' ofHearts . 'J' ofSpades} inGame: gameOf5.
	self
		assert: (aajk7 beats: aajk6);
		assert: (aajk7 beats: ajak6);
		assert: (aajk7 beats: aak109);
		assert: (qq beats: aj8j7);
		assert: (kkj beats: qq).
	self
		deny: (kkj beats: kkjb);
		deny: (kkj beats: aajj)
]

{ #category : #test }
PairTest >> testMatchesInGame [
	self
		assert: (Pair matches: {'7' ofSpades . '7' ofClubs . 'J' ofClubs . 'Q' ofDiamonds . 'A' ofSpades} inGame: gameOf4);
		assert: (Pair matches: {'7' ofSpades . '7' ofClubs} inGame: gameOf4);
		assert: (Pair matches: {'7' ofSpades . '7' ofClubs . 'A' ofDiamonds} inGame: gameOf4).
	self
		deny: (Pair matches: {} inGame: gameOf4);
		deny: (Pair matches: {'7' ofSpades . '7' ofClubs . 'J' ofClubs . '7' ofDiamonds . 'A' ofSpades} inGame: gameOf4);
		deny: (Pair matches: {'7' ofSpades . '9' ofClubs . 'J' ofClubs . '10' ofDiamonds . 'A' ofSpades} inGame: gameOf4);
		deny: (Pair matches: {'7' ofSpades . '9' ofClubs} inGame: gameOf4);
		deny: (Pair matches: {'7' ofSpades . '9' ofClubs . '7' ofClubs . '9' ofDiamonds . 'A' ofSpades} inGame: gameOf4);
		deny: (Pair matches: {'7' ofSpades . '9' ofClubs . '7' ofClubs . '9' ofDiamonds . '9' ofSpades} inGame: gameOf4)
]

{ #category : #tests }
PairTest >> testTiesWith [
	|aajk6 ajak6 aj96j aj8j7 aajj qq kkj kkjb |
	aajk6 := CardsHand fromCards: { 'A' ofClubs . 'A' ofHearts . 'J' ofClubs . 'K' ofHearts . '6' ofClubs } inGame: gameOf5.
	ajak6 := CardsHand fromCards: { 'A' ofClubs . 'J' ofHearts . 'A' ofSpades . 'K' ofHearts . '6' ofClubs } inGame: gameOf5.
	aj96j := CardsHand fromCards: { 'A' ofClubs . 'J' ofHearts . '9' ofClubs . 'A' ofHearts . 'J' ofClubs } inGame: gameOf5.
	aj8j7 := CardsHand fromCards: { 'A' ofClubs . 'J' ofHearts . '8' ofDiamonds . 'J' ofClubs . '7' ofSpades } inGame: gameOf5.
	aajj := CardsHand fromCards: { 'A' ofClubs . 'A' ofHearts . 'J' ofClubs . 'J' ofHearts } inGame: gameOf5.
	qq := CardsHand fromCards: { 'Q' ofClubs . 'Q' ofHearts } inGame: gameOf5.
	kkj := CardsHand fromCards: { 'K' ofSpades . 'K' ofDiamonds . 'J' ofClubs} inGame: gameOf5.
	kkjb := CardsHand fromCards: { 'K' ofClubs . 'K' ofHearts . 'J' ofSpades} inGame: gameOf5.
	self
		assert: (aajk6 tiesWith: aajk6);
		assert: (aajk6 tiesWith: ajak6);
		assert: (qq tiesWith: qq);
		assert: (kkj tiesWith: kkjb).
	self
		deny: (aajk6 tiesWith: aajj);
		deny: (aj8j7 tiesWith: aj96j)
]
