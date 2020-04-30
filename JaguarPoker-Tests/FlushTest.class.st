"
A FlushTest is a test class for testing the behavior of Flush
"
Class {
	#name : #FlushTest,
	#superclass : #CardsHandTest,
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #test }
FlushTest >> testBeats [
	| upToK upToQ upToAClubs upToAHearts fullHouse inGameOf5 fullInGameOf5|
	upToK := CardsHand fromCards: { '7' ofClubs . '8' ofClubs . '9' ofClubs . 'K' ofClubs . 'J' ofClubs } inGame: gameOf4.
	upToQ := CardsHand fromCards: { '7' ofClubs . '8' ofClubs . '9' ofClubs . 'Q' ofClubs . 'J' ofClubs } inGame: gameOf4.
	upToAClubs := CardsHand fromCards:{ '6' ofClubs . 'J' ofClubs . 'A' ofClubs . '10' ofClubs . '8' ofClubs } inGame: gameOf4.
	upToAHearts := CardsHand fromCards:{ '6' ofHearts . 'J' ofHearts . 'A' ofHearts . '10' ofHearts . '8' ofHearts } inGame: gameOf4.
	fullHouse := CardsHand fromCards:{ '6' ofHearts . 'J' ofHearts . '6' ofHearts . '6' ofClubs . 'J' ofSpades } inGame: gameOf4.
	inGameOf5 := CardsHand fromCards: { '7' ofClubs . '8' ofClubs . '9' ofClubs . 'Q' ofClubs . 'J' ofClubs } inGame: gameOf5.
	fullInGameOf5 := CardsHand fromCards:{ '6' ofHearts . 'J' ofHearts . '6' ofHearts . '6' ofClubs . 'J' ofSpades } inGame: gameOf5.
	self
		assert: (upToK beats: upToQ);
		assert: (upToAClubs beats: upToQ);
		assert: (upToAClubs beats: fullHouse).
	self
		deny: (upToK beats: upToK);
		deny: (upToAClubs beats: upToAHearts);
		deny: (inGameOf5 beats: fullInGameOf5)
]

{ #category : #tests }
FlushTest >> testMatchesInGame [
	self 
		assert: (Flush matches: { '7' ofClubs . '8' ofClubs . '9' ofClubs . 'K' ofClubs . 'J' ofClubs } inGame: gameOf4);
		assert: (Flush matches: { '7' ofClubs . '8' ofClubs . '9' ofClubs . '10' ofClubs . 'A' ofClubs } inGame: gameOf5).
	self
		deny: (Flush matches: {} inGame: gameOf5);
		deny: (Flush matches: { 'A' ofClubs . '7' ofClubs . '9' ofClubs . '10' ofClubs } inGame: gameOf5);
		deny: (Flush matches: { 'A' ofClubs . '7' ofClubs . '8' ofDiamonds . '9' ofClubs . '10' ofHearts } inGame: gameOf5);
		deny: (Flush matches: { '7' ofClubs . '8' ofClubs . '9' ofClubs . '10' ofClubs . 'J' ofClubs } inGame: gameOf5)
]

{ #category : #test }
FlushTest >> testTiesWith [
	| upToAClubs upToAHearts upToAb upToJ upToJIncomplete |
	upToAClubs := CardsHand fromCards:{ '6' ofClubs . 'J' ofClubs . 'A' ofClubs . '10' ofClubs . '8' ofClubs } inGame: gameOf4.
	upToAHearts := CardsHand fromCards:{ '6' ofHearts . 'J' ofHearts . 'A' ofHearts . '10' ofHearts . '8' ofHearts } inGame: gameOf4.
	upToAb := CardsHand fromCards:{ 'J' ofClubs . 'A' ofClubs . '6' ofClubs . '10' ofClubs . '8' ofClubs } inGame: gameOf4.
	upToJ := CardsHand fromCards:{ '6' ofClubs . 'J' ofClubs . '7' ofClubs . '10' ofClubs . '8' ofClubs } inGame: gameOf4.
	upToJIncomplete := CardsHand fromCards:{ '6' ofClubs . 'J' ofClubs . '7' ofClubs . '10' ofClubs } inGame: gameOf4.
	self
		assert: (upToAClubs tiesWith: upToAClubs);
		assert: (upToAClubs tiesWith: upToAHearts);
		assert: (upToAHearts tiesWith: upToAb).
	self
		deny: (upToAClubs tiesWith: upToJ);
		deny: (upToJ tiesWith: upToJIncomplete)
]
