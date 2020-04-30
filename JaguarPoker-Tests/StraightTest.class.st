"
A StraightTest is a test class for testing the behavior of Straight
"
Class {
	#name : #StraightTest,
	#superclass : #CardsHandTest,
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #tests }
StraightTest >> testMatchesInGame [
	self 
		assert: (Straight matches: { '7' ofClubs . '8' ofDiamonds . '9' ofClubs . '10' ofHearts . 'J' ofClubs } inGame: gameOf4); 
		assert: (Straight matches: { 'J' ofClubs . '7' ofClubs . '9' ofClubs . '10' ofHearts . '8' ofDiamonds } inGame: gameOf4); 
		assert: (Straight matches: { '6' ofClubs . '7' ofClubs . '8' ofDiamonds . '9' ofClubs . '10' ofHearts } inGame: gameOf5); 
		assert: (Straight matches: { '6' ofClubs . '10' ofHearts. '7' ofClubs . '8' ofDiamonds . '9' ofClubs  } inGame: gameOf5); 
		assert: (Straight matches: { '10' ofClubs . '9' ofHearts. '8' ofClubs . '7' ofDiamonds . '6' ofClubs  } inGame: gameOf5); 
		assert: (Straight matches: { '10' ofHearts . 'J' ofClubs . 'Q' ofClubs . 'K' ofDiamonds . 'A' ofClubs} inGame: gameOf4); 
		assert: (Straight matches: { '10' ofHearts. 'A' ofClubs . 'Q' ofClubs . 'K' ofDiamonds . 'J' ofClubs } inGame: gameOf4); 
		assert: (Straight matches: { '10' ofHearts . 'J' ofClubs . 'Q' ofClubs . 'K' ofDiamonds . 'A' ofClubs} inGame: gameOf5); 
		assert: (Straight matches: { 'A' ofHearts . '6' ofClubs . '7' ofClubs . '8' ofDiamonds . '9' ofClubs } inGame: gameOf5); 
		assert: (Straight matches: { 'A' ofClubs . '7' ofClubs . '8' ofDiamonds . '9' ofClubs . '10' ofHearts } inGame: gameOf4).
	self
		deny: (Straight matches: { 'A' ofClubs . '7' ofClubs . '8' ofDiamonds . '9' ofClubs . '10' ofHearts } inGame: gameOf5);
		deny: (Straight matches: { '7' ofClubs . '8' ofDiamonds . '9' ofClubs . '10' ofHearts . 'Q' ofClubs } inGame: gameOf5);
		deny: (Straight matches: { '7' ofClubs . '8' ofDiamonds . '9' ofClubs . '10' ofHearts . 'Q' ofClubs } inGame: gameOf5);
		deny: (Straight matches: { '7' ofClubs . '8' ofDiamonds . '9' ofClubs . '10' ofHearts . '10' ofClubs } inGame: gameOf5);
		deny: (Straight matches: { '7' ofClubs . '8' ofClubs . '9' ofClubs . '10' ofClubs . 'J' ofClubs } inGame: gameOf5);
		deny: (Straight matches: { '7' ofClubs . '8' ofDiamonds . '9' ofClubs . '10' ofHearts } inGame: gameOf5)
]
