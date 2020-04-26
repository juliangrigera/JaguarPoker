"
A PairTest is a test class for testing the behavior of Pair
"
Class {
	#name : #PairTest,
	#superclass : #CardsHandTest,
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #test }
PairTest >> testMatches [
	| pair threeOfaKind justAPair pairAndCard notAPair shortOfAPair twoPairs fullHouse |
	pair := {'7' ofSpades . '7' ofClubs . 'J' ofClubs . 'Q' ofDiamonds . 'A' ofSpades}.
	justAPair := {'7' ofSpades . '7' ofClubs}.
	pairAndCard := {'7' ofSpades . '7' ofClubs . 'A' ofDiamonds}.
	threeOfaKind := {'7' ofSpades . '7' ofClubs . 'J' ofClubs . '7' ofDiamonds . 'A' ofSpades}.
	notAPair := {'7' ofSpades . '9' ofClubs . 'J' ofClubs . '10' ofDiamonds . 'A' ofSpades}.
	shortOfAPair := {'7' ofSpades . '9' ofClubs }.
	twoPairs := {'7' ofSpades . '9' ofClubs . '7' ofClubs . '9' ofDiamonds . 'A' ofSpades}.
	fullHouse := {'7' ofSpades . '9' ofClubs . '7' ofClubs . '9' ofDiamonds . '9' ofSpades}.
	self 
		assert: (Pair matches: pair); 
		assert: (Pair matches: justAPair); 
		assert: (Pair matches: pairAndCard).
	self 
		deny: (Pair matches: {});
		deny: (Pair matches: threeOfaKind);
		deny: (Pair matches: notAPair);
		deny: (Pair matches: shortOfAPair);
		deny: (Pair matches: twoPairs);
		deny: (Pair matches: fullHouse).
]
