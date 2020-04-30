"
A FullHouseTest is a test class for testing the behavior of FullHouse
"
Class {
	#name : #FullHouseTest,
	#superclass : #CardsHandTest,
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #tests }
FullHouseTest >> testBeats [
	| fullQA fullJA fullQ9 fullQ9in4 flushIn4 |
	fullQA := CardsHand fromCards: {'A' ofSpades . 'A' ofDiamonds . 'Q' ofDiamonds . 'Q' ofClubs . 'Q' ofHearts} inGame: gameOf5.
	fullJA := CardsHand fromCards: {'J' ofSpades . 'A' ofDiamonds . 'A' ofDiamonds . 'J' ofClubs . 'J' ofHearts} inGame: gameOf5.
	fullQ9 := CardsHand fromCards: {'Q' ofSpades . 'Q' ofDiamonds . 'Q' ofHearts . '9' ofClubs . '9' ofHearts} inGame: gameOf5.
	fullQ9in4 := CardsHand fromCards: {'Q' ofSpades . 'Q' ofDiamonds . 'Q' ofHearts . '9' ofClubs . '9' ofHearts} inGame: gameOf4.
	flushIn4 := CardsHand fromCards: {'Q' ofSpades . 'A' ofSpades . 'J' ofSpades . '7' ofSpades . '9' ofSpades} inGame: gameOf4.
	self
		assert: (fullQA beats: fullJA);
		assert: (fullQA beats: fullQ9);
		assert: (fullQA beats: fullQ9);
		assert: (fullQA beats: pair).
	self 
		deny: (fullQ9in4 beats: flushIn4)
]

{ #category : #tests }
FullHouseTest >> testMatchesInGame [
	self 
		assert: (FullHouse matches: {'7' ofSpades . '7' ofClubs . '7' ofDiamonds . 'A' ofHearts . 'A' ofSpades} inGame: gameOf4); 
		assert: (FullHouse matches: {'7' ofSpades . 'A' ofHearts . '7' ofClubs . '7' ofDiamonds . 'A' ofSpades} inGame: gameOf4).
	self 
		deny: (FullHouse matches: {} inGame: gameOf4);
		deny: (FullHouse matches: {'7' ofSpades . 'A' ofHearts . '7' ofClubs . 'J' ofDiamonds . 'A' ofSpades} inGame: gameOf4);
		deny: (FullHouse matches: {'7' ofSpades . '7' ofHearts . '7' ofClubs . '7' ofDiamonds . 'A' ofSpades} inGame: gameOf4);
		deny: (FullHouse matches: {'7' ofSpades . '7' ofHearts . 'A' ofClubs . 'A' ofSpades} inGame: gameOf4)
]

{ #category : #tests }
FullHouseTest >> testTiesWith [
	| fullQA  fullQAb fullQAc fullAQ|
	fullQA := CardsHand fromCards: {'A' ofSpades . 'A' ofDiamonds . 'Q' ofDiamonds . 'Q' ofClubs . 'Q' ofHearts} inGame: gameOf5.
	fullQAb := CardsHand fromCards: {'A' ofSpades . 'Q' ofDiamonds . 'Q' ofClubs . 'Q' ofHearts . 'A' ofDiamonds} inGame: gameOf5.
	fullQAc := CardsHand fromCards: {'A' ofHearts . 'Q' ofHearts . 'Q' ofClubs . 'Q' ofDiamonds . 'A' ofClubs} inGame: gameOf5.
	fullAQ := CardsHand fromCards: {'A' ofHearts . 'A' ofHearts . 'Q' ofClubs . 'Q' ofDiamonds . 'A' ofClubs} inGame: gameOf5.
	self
		assert: (fullQA tiesWith: fullQA);
		assert: (fullQA tiesWith: fullQAb);
		assert: (fullQAb tiesWith: fullQA);
		assert: (fullQAb tiesWith: fullQAc);
		assert: (fullQAc tiesWith: fullQA).
	self
		deny: (fullQAc tiesWith: fullAQ);
		deny: (fullQA tiesWith: fullAQ)
]
