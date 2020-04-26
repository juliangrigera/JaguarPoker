Class {
	#name : #FullHouseTest,
	#superclass : #CardsHandTest,
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #tests }
FullHouseTest >> testMatches [
	self 
		assert: (FullHouse matches: {'7' ofSpades . '7' ofClubs . '7' ofDiamonds . 'A' ofHearts . 'A' ofSpades}); 
		assert: (FullHouse matches: {'7' ofSpades . 'A' ofHearts . '7' ofClubs . '7' ofDiamonds . 'A' ofSpades}).
	self 
		deny: (FullHouse matches: {});
		deny: (FullHouse matches: {'7' ofSpades . 'A' ofHearts . '7' ofClubs . 'J' ofDiamonds . 'A' ofSpades});
		deny: (FullHouse matches: {'7' ofSpades . '7' ofHearts . '7' ofClubs . '7' ofDiamonds . 'A' ofSpades});
		deny: (FullHouse matches: {'7' ofSpades . '7' ofHearts . 'A' ofClubs . 'A' ofSpades})
]
