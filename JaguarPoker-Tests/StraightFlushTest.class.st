"
A StraightFlushTest is a test class for testing the behavior of StraightFlush
"
Class {
	#name : #StraightFlushTest,
	#superclass : #CardsHandTest,
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #tests }
StraightFlushTest >> testMatchesInGame [
	self 
		assert: (StraightFlush matches: { '7' ofClubs . '8' ofClubs . '9' ofClubs . '10' ofClubs . 'J' ofClubs } inGame: gameOf4); 
		assert: (StraightFlush matches: { 'J' ofHearts . '7' ofHearts . '9' ofHearts . '10' ofHearts . '8' ofHearts } inGame: gameOf4); 
		assert: (StraightFlush matches: { '6' ofDiamonds . '7' ofDiamonds . '8' ofDiamonds . '9' ofDiamonds . '10' ofDiamonds } inGame: gameOf5); 
		assert: (StraightFlush matches: { '6' ofSpades . '10' ofSpades. '7' ofSpades . '8' ofSpades . '9' ofSpades  } inGame: gameOf5); 
		assert: (StraightFlush matches: { '10' ofClubs . '9' ofClubs. '8' ofClubs . '7' ofClubs . '6' ofClubs  } inGame: gameOf5); 
		assert: (StraightFlush matches: { '10' ofDiamonds . 'J' ofDiamonds . 'Q' ofDiamonds . 'K' ofDiamonds . 'A' ofDiamonds} inGame: gameOf4); 
		assert: (StraightFlush matches: { '10' ofHearts. 'A' ofHearts . 'Q' ofHearts . 'K' ofHearts . 'J' ofHearts } inGame: gameOf4); 
		assert: (StraightFlush matches: { '10' ofDiamonds . 'J' ofDiamonds . 'Q' ofDiamonds . 'K' ofDiamonds . 'A' ofDiamonds} inGame: gameOf5); 
		assert: (StraightFlush matches: { 'A' ofSpades . '6' ofSpades . '7' ofSpades . '8' ofSpades . '9' ofSpades } inGame: gameOf5); 
		assert: (StraightFlush matches: { 'A' ofClubs . '7' ofClubs . '8' ofClubs . '9' ofClubs . '10' ofClubs } inGame: gameOf4).
	self
		deny: (StraightFlush matches: { 'A' ofClubs . '7' ofClubs . '8' ofClubs . '9' ofClubs . '10' ofClubs } inGame: gameOf5);
		deny: (StraightFlush matches: { '7' ofClubs . '8' ofClubs . '9' ofClubs . '10' ofClubs . 'Q' ofClubs } inGame: gameOf5);
		deny: (StraightFlush matches: { '7' ofDiamonds . '8' ofDiamonds . '9' ofDiamonds . '10' ofDiamonds . 'Q' ofDiamonds } inGame: gameOf5);
		deny: (StraightFlush matches: { '7' ofHearts . '8' ofHearts . '9' ofHearts . '10' ofHearts . '10' ofHearts } inGame: gameOf5);
		deny: (StraightFlush matches: { '7' ofHearts . '8' ofHearts . '9' ofHearts . '10' ofHearts } inGame: gameOf5);
		deny: (StraightFlush matches: { '7' ofClubs . '8' ofDiamonds . '9' ofClubs . '10' ofHearts . 'J' ofClubs } inGame: gameOf4); 
		deny: (StraightFlush matches: { 'J' ofClubs . '7' ofClubs . '9' ofClubs . '10' ofHearts . '8' ofDiamonds } inGame: gameOf4); 
		deny: (StraightFlush matches: { '6' ofClubs . '7' ofClubs . '8' ofDiamonds . '9' ofClubs . '10' ofHearts } inGame: gameOf5); 
		deny: (StraightFlush matches: { '6' ofClubs . '10' ofHearts. '7' ofClubs . '8' ofDiamonds . '9' ofClubs  } inGame: gameOf5); 
		deny: (StraightFlush matches: { '10' ofClubs . '9' ofHearts. '8' ofClubs . '7' ofDiamonds . '6' ofClubs  } inGame: gameOf5); 
		deny: (StraightFlush matches: { '10' ofHearts . 'J' ofClubs . 'Q' ofClubs . 'K' ofDiamonds . 'A' ofClubs} inGame: gameOf4); 
		deny: (StraightFlush matches: { '10' ofHearts. 'A' ofClubs . 'Q' ofClubs . 'K' ofDiamonds . 'J' ofClubs } inGame: gameOf4); 
		deny: (StraightFlush matches: { '10' ofHearts . 'J' ofClubs . 'Q' ofClubs . 'K' ofDiamonds . 'A' ofClubs} inGame: gameOf5); 
		deny: (StraightFlush matches: { 'A' ofHearts . '6' ofClubs . '7' ofClubs . '8' ofDiamonds . '9' ofClubs } inGame: gameOf5); 
		deny: (StraightFlush matches: { 'A' ofClubs . '7' ofClubs . '8' ofDiamonds . '9' ofClubs . '10' ofHearts } inGame: gameOf4)
]
