"
A PokerTest is a test class for testing the behavior of Poker
"
Class {
	#name : #PokerTest,
	#superclass : #CardsHandTest,
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #test }
PokerTest >> testMatchesInGame [
	| poker threeOfaKind justAPoker  shortOfAPoker  fullHouse |
	poker := {'7' ofSpades . '7' ofClubs . '7' ofDiamonds . '7' ofHearts . 'A' ofSpades}.
	justAPoker := {'7' ofSpades . '7' ofClubs . '7' ofDiamonds . '7' ofHearts }.
	threeOfaKind := {'7' ofSpades . '7' ofClubs . 'J' ofClubs . '7' ofDiamonds . 'A' ofSpades}.
	shortOfAPoker := {'7' ofSpades . '7' ofClubs . '7' ofDiamonds . '9' ofClubs }.
	fullHouse := {'7' ofSpades . '9' ofClubs . '7' ofClubs . '9' ofDiamonds . '9' ofSpades}.
	self 
		assert: (Poker matches: poker inGame: gameOf5); 
		assert: (Poker matches: justAPoker inGame: gameOf5).
	self 
		deny: (Poker matches: {} inGame: gameOf5);
		deny: (Poker matches: threeOfaKind inGame: gameOf5);
		deny: (Poker matches: fullHouse inGame: gameOf5);
		deny: (Poker matches: shortOfAPoker inGame: gameOf5).
]
