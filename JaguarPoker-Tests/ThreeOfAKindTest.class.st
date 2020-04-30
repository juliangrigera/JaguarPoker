"
A ThreeOfAKindTest is a test class for testing the behavior of ThreeOfAKind
"
Class {
	#name : #ThreeOfAKindTest,
	#superclass : #CardsHandTest,
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #tests }
ThreeOfAKindTest >> testMatchesInGame [
	self
		assert: (ThreeOfAKind matches: {'A' ofSpades . 'A' ofClubs . 'A' ofHearts . '7' ofDiamonds . '10' ofSpades} inGame: gameOf4);
		assert: (ThreeOfAKind matches: {'7' ofSpades . '7' ofClubs . 'J' ofClubs . '7' ofDiamonds . 'A' ofSpades} inGame: gameOf4);
		assert: (ThreeOfAKind matches: {'7' ofSpades . '9' ofClubs . '7' ofClubs . 'A' ofDiamonds . '7' ofHearts} inGame: gameOf5);
		assert: (ThreeOfAKind matches: {'9' ofClubs . '7' ofClubs . '9' ofDiamonds . '9' ofSpades} inGame: gameOf4);
		assert: (ThreeOfAKind matches: {'J' ofClubs . 'J' ofDiamonds . 'J' ofSpades} inGame: gameOf5).
	self
		deny: (ThreeOfAKind matches: {} inGame: gameOf4);
		deny: (ThreeOfAKind matches: {'7' ofSpades . '7' ofClubs} inGame: gameOf4);
		deny: (ThreeOfAKind matches: {'7' ofSpades . '7' ofClubs . 'A' ofDiamonds} inGame: gameOf4);
		deny: (ThreeOfAKind matches: {'7' ofSpades . '7' ofClubs . 'J' ofClubs . '7' ofDiamonds . '7' ofHearts} inGame: gameOf4);
		deny: (ThreeOfAKind matches: {'7' ofSpades . '9' ofClubs . '7' ofClubs . '9' ofDiamonds . '9' ofHearts} inGame: gameOf4);
		deny: (ThreeOfAKind matches: {'7' ofSpades . '9' ofClubs} inGame: gameOf4);
		deny: (ThreeOfAKind matches: {'7' ofSpades . '7' ofClubs . 'A' ofClubs . '7' ofDiamonds . '7' ofHearts} inGame: gameOf4);
		deny: (ThreeOfAKind matches: {'7' ofSpades . 'A' ofClubs . '7' ofClubs . 'A' ofDiamonds} inGame: gameOf4)
]
