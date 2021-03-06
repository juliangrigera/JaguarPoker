"
A PokerHandTest is a test class for testing the behavior of PokerHand
"
Class {
	#name : #PokerHandTest,
	#superclass : #TestCase,
	#instVars : [
		'santi',
		'pera',
		'nico',
		'panda',
		'julio',
		'hand',
		'smallHand',
		'fede',
		'nacho',
		'mono',
		'wainer'
	],
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #running }
PokerHandTest >> setUp [
	santi := Player name: 'Santi'.
	pera := Player name: 'Pera'.
	nico := Player name: 'Nico'.
	panda := Player name: 'Panda'.
	julio := Player name: 'Julio'.
	hand := PokerHand players: {santi . pera . nico . panda . julio} asOrderedCollection.
	fede := Player name: 'Fede'.
	nacho := Player name: 'Nacho'.
	wainer := Player name: 'Wainter'.
	mono := Player name: 'Mono'.
	smallHand := PokerHand players: {fede . nacho . wainer . mono} asOrderedCollection.
]

{ #category : #test }
PokerHandTest >> testChipsToCallFirstBetFor [
	"Order is: santi . pera . nico . panda . julio"

	hand players do: [ :player | hand placeAnteFor: player ].
	hand deal.
	hand placeFirstBet: 5 for: pera.
	self assert: (hand chipsToCallFirstBetFor: pera) equals: 0.
	{santi . nico. panda. julio} do:
			[ :player | self assert: (hand chipsToCallFirstBetFor: player) equals: 5 ].
	hand placeFirstBet: 5 for: nico.
	self assert: (hand chipsToCallFirstBetFor: nico) equals: 0.
	{santi . panda. julio} do:
			[ :player | self assert: (hand chipsToCallFirstBetFor: player) equals: 5 ].
	hand placeFirstBet: 3 for: panda.
	self assert: (hand chipsToCallFirstBetFor: panda) equals: 2.
	self assert: (hand chipsToCallFirstBetFor: nico) equals: 0.
	{santi . julio} do:
			[ :player | self assert: (hand chipsToCallFirstBetFor: player) equals: 5 ].
	
]

{ #category : #test }
PokerHandTest >> testDeal [
	self should: [ hand deal ] raise: Error.
	hand players do: [ :player | hand placeAnteFor: player ].
	hand deal.
	hand players
		do: [ :player | self assert: player cards size equals: 5 ].
	self assert: hand deck size equals: 11.
	self should: [ smallHand deal ] raise: Error.
	smallHand players do: [ :player | smallHand placeAnteFor: player ].
	smallHand deal.
	smallHand players
		do: [ :player | self assert: player cards size equals: 5 ].
	self assert: smallHand deck size equals: 12
]

{ #category : #test }
PokerHandTest >> testEnableCardsChange [
	"Smallhand order is: fede > nacho > wainer > mono"

	"Hand order is: santi > pera > nico > panda > julio"

	smallHand players do: [ :player | smallHand placeAnteFor: player ].
	smallHand deal.
	self should: [ smallHand enableCardsChange ] raise: Error.
	smallHand
		placeFirstBet: 4 for: nacho;
		foldPlayer: wainer;
		foldPlayer: mono;
		placeFirstBet: 4 for: fede.
	self shouldnt: [ smallHand enableCardsChange ] raise: Error.
	hand players do: [ :player | hand placeAnteFor: player ].
	hand deal.
	hand
		passPlayer: pera;
		passPlayer: nico;
		placeFirstBet: 5 for: panda;
		placeFirstBet: 7 for: julio;
		foldPlayer: santi.
	self should: [ hand enableCardsChange ] raise: Error.
	hand
		placeFirstBet: 7 for: pera;
		foldPlayer: nico.
	self should: [ hand enableCardsChange ] raise: Error.
	hand placeFirstBet: 2 for: panda.
	self shouldnt: [ hand enableCardsChange ] raise: Error.
]

{ #category : #test }
PokerHandTest >> testFirstBetsRoundDone [
	"Smallhand order is: fede > nacho > wainer > mono"
	smallHand players do: [ :player | smallHand placeAnteFor: player ].
	smallHand deal.
	self deny: smallHand firstBetsRoundDone.
	smallHand passPlayer: nacho.
	self deny: smallHand firstBetsRoundDone.
	smallHand placeFirstBet: 10 for: wainer.
	self deny: smallHand firstBetsRoundDone.
	smallHand foldPlayer: mono.
	self deny: smallHand firstBetsRoundDone.
	smallHand raiseFirstBet: 5 for: fede.
	self deny: smallHand firstBetsRoundDone.
	smallHand callFirstBetFor: nacho.
	self deny: smallHand firstBetsRoundDone.
	smallHand callFirstBetFor: wainer.
	self assert: smallHand firstBetsRoundDone.
]

{ #category : #test }
PokerHandTest >> testFirstBetsRoundDone2 [
	"Smallhand order is: fede > nacho > wainer > mono"

	smallHand players do: [ :player | player chips: 100 ].
	nacho chips: 10.
	smallHand players do: [ :player | smallHand placeAnteFor: player ].
	smallHand deal.
	smallHand
		placeFirstBet: 5 for: nacho;
		callFirstBetFor: wainer;
		raiseFirstBet: 10 for: mono;
		callFirstBetFor: fede.
	self deny: smallHand firstBetsRoundDone.
	smallHand callFirstBetFor: nacho.
	self assert: nacho chipsCount equals: 0.
	self deny: smallHand firstBetsRoundDone.
	smallHand callFirstBetFor: wainer.
	self assert: smallHand firstBetsRoundDone.
]

{ #category : #test }
PokerHandTest >> testFirstBetsRoundDone3 [
	"Smallhand order is: fede > nacho > wainer > mono"

	smallHand players do: [ :player | player chips: 100 ].
	smallHand players do: [ :player | smallHand placeAnteFor: player ].
	smallHand deal.
	smallHand
		placeFirstBet: 20 for: nacho;
		raiseFirstBet: 3 for: wainer;
		callFirstBetFor: mono;
		callFirstBetFor: fede;
		raiseFirstBet: 76 for: nacho.
	self assert: (smallHand chipsToCallFirstBetFor: wainer) equals: 76.
	self assert: (smallHand chipsToCallFirstBetFor: fede) equals: 76.
	self deny: smallHand firstBetsRoundDone.
	smallHand
		callFirstBetFor: wainer;
		callFirstBetFor: mono;
		callFirstBetFor: fede.
	self assert: smallHand firstBetsRoundDone
]

{ #category : #test }
PokerHandTest >> testFirstBetsRoundDone4 [
	"Smallhand order is: fede > nacho > wainer > mono"

	fede chips: 100. nacho chips: 5. wainer chips: 9. mono chips: 100.
	smallHand players do: [ :player | smallHand placeAnteFor: player ].
	smallHand deal.
	smallHand
		placeFirstBet: 2 for: fede;
		raiseFirstBet: 2 for: nacho;
		callFirstBetFor: wainer;
		raiseFirstBet: 15 for: mono;
		callFirstBetFor: fede;
		callFirstBetFor: wainer.
	self assert: (smallHand totalFirstBetsFor: fede) equals: 19.
	self assert: (smallHand totalFirstBetsFor: nacho) equals: 4.
	self assert: (smallHand totalFirstBetsFor: wainer) equals: 8.
	self assert: (smallHand totalFirstBetsFor: mono) equals: 19.
	self assert: smallHand firstBetsRoundDone 
]

{ #category : #test }
PokerHandTest >> testFirstBetsRoundDone5 [
	|game passedHand hand5 players|
	players := { santi . nacho . pera . wainer . panda } asOrderedCollection.
	game := (PokerGame players: players) dealer: pera; yourself.
	game newHand.
	passedHand := game currentPokerHand.
	passedHand placeAnteFor: santi; placeAnteFor: pera; placeAnteFor: wainer; placeAnteFor: nacho; placeAnteFor: panda.
	passedHand deal.
	{ wainer . panda . santi . nacho . pera} do: [ :passer | passedHand passPlayer: passer ].
	game newHand.
	hand5 := game currentPokerHand.
	hand5 placeAnteFor: santi; placeAnteFor: nacho; placeAnteFor: wainer; placeAnteFor: panda; placeAnteFor: pera.
	self assert: hand5 potSize equals: 15
	
]

{ #category : #test }
PokerHandTest >> testFirstBetsRoundDone6 [
	"Smallhand order is: fede > nacho > wainer > mono"

	smallHand players do: [ :player | player chips: 100. smallHand placeAnteFor: player ].
	smallHand deal.
	smallHand
		passPlayer: nacho;
		placeFirstBet: 4 for: wainer;
		callFirstBetFor: mono;
		foldPlayer: fede;
		raiseFirstBet: 2 for: nacho;
		callFirstBetFor: wainer;
		raiseFirstBet: 4 for: mono;
		callFirstBetFor: nacho;
		callFirstBetFor: wainer.
	self assert: smallHand firstBetsRoundDone
]

{ #category : #test }
PokerHandTest >> testRotateSpeaker [
	"Smallhand order is: fede > nacho > wainer > mono"

	smallHand players do: [ :player | smallHand placeAnteFor: player ].
	self assert: smallHand speaker equals: nil.
	smallHand deal.
	self assert: smallHand speaker equals: nacho.
	smallHand passPlayer: nacho.
	self assert: smallHand speaker equals: wainer.
	smallHand
		placeFirstBet: 3 for: wainer;
		placeFirstBet: 3 for: mono.
	self assert: smallHand speaker equals: fede.
	smallHand placeFirstBet: 3 for: fede.
	self assert: smallHand speaker equals: nacho.
	smallHand foldPlayer: nacho.
	self assert: smallHand speaker equals: nil.
	smallHand enableCardsChange.
	self assert: smallHand speaker equals: wainer.
	smallHand
		change: {} to: wainer;
		change: {} to: mono;
		change: {} to: fede.
	smallHand acceptBets.
	smallHand
		placeSecondBet: 10 for: wainer;
		placeSecondBet: 10 for: mono.
	self assert: smallHand speaker equals: fede.
	smallHand placeSecondBet: 10 for: fede.
	self assert: smallHand speaker equals: nil.
]

{ #category : #test }
PokerHandTest >> testRotateSpeaker2 [
	"Smallhand order is: fede > nacho > wainer > mono"

	smallHand players do: [ :player | smallHand placeAnteFor: player ].
	self assert: smallHand speaker equals: nil.
	smallHand deal.
	self assert: smallHand speaker equals: nacho.
	smallHand passPlayer: nacho.
	self assert: smallHand speaker equals: wainer.
	smallHand
		placeFirstBet: 3 for: wainer;
		placeFirstBet: 3 for: mono.
	self assert: smallHand speaker equals: fede.
	smallHand placeFirstBet: 3 for: fede.
	self assert: smallHand speaker equals: nacho.
	smallHand foldPlayer: nacho.
	self assert: smallHand speaker equals: nil.
	smallHand enableCardsChange.
	self assert: smallHand speaker equals: wainer.
	smallHand
		change: {} to: wainer;
		change: {} to: mono;
		change: {} to: fede.
	smallHand acceptBets.
	smallHand
		passPlayer: wainer;
		passPlayer: mono.
	self assert: smallHand speaker equals: fede.
	smallHand placeSecondBet: 10 for: fede.
	self assert: smallHand speaker equals: wainer.
]

{ #category : #test }
PokerHandTest >> testRotateSpeaker3 [
	"Smallhand order is: fede > nacho > wainer > mono"

	smallHand players do: [ :player | smallHand placeAnteFor: player ].
	self assert: smallHand speaker equals: nil.
	smallHand deal.
	self assert: smallHand speaker equals: nacho.
	smallHand passPlayer: nacho.
	self assert: smallHand speaker equals: wainer.
	smallHand
		placeFirstBet: 3 for: wainer;
		placeFirstBet: 3 for: mono.
	self assert: smallHand speaker equals: fede.
	smallHand placeFirstBet: 3 for: fede.
	self assert: smallHand speaker equals: nacho.
	smallHand foldPlayer: nacho.
	self assert: smallHand speaker equals: nil.
	smallHand enableCardsChange.
	self assert: smallHand speaker equals: wainer.
	smallHand
		change: {} to: wainer;
		change: {} to: mono;
		change: {} to: fede.
	smallHand acceptBets.
	smallHand
		passPlayer: wainer;
		passPlayer: mono.
	self assert: smallHand speaker equals: fede.
	smallHand passPlayer: fede.
	self assert: smallHand speaker equals: nil.
]

{ #category : #test }
PokerHandTest >> testRotateSpeaker4 [
	"Smallhand order is: fede > nacho > wainer > mono"

	smallHand players do: [ :player | smallHand placeAnteFor: player ].
	self assert: smallHand speaker equals: nil.
	smallHand deal.
	self assert: smallHand speaker equals: nacho.
	smallHand passPlayer: nacho.
	self assert: smallHand speaker equals: wainer.
	smallHand
		placeFirstBet: 3 for: wainer;
		placeFirstBet: 3 for: mono.
	self assert: smallHand speaker equals: fede.
	smallHand placeFirstBet: 3 for: fede.
	self assert: smallHand speaker equals: nacho.
	smallHand placeFirstBet: 3 for: nacho.
	self assert: smallHand speaker equals: nil.
	smallHand enableCardsChange.
	self assert: smallHand speaker equals: nacho.
	smallHand
		change: (nacho cards first: 3) to: nacho;
		change: (wainer cards first: 2) to: wainer;
		change: {} to: mono;
		change: {} to: fede.
	smallHand acceptBets.
	smallHand
		passPlayer: wainer;
		placeSecondBet: 20 for: mono.
	self assert: smallHand speaker equals: fede.
	smallHand placeSecondBet: 20 for: fede.
	self assert: smallHand speaker equals: nacho.
	smallHand foldPlayer: nacho.
	self assert: smallHand speaker equals: wainer.
]

{ #category : #test }
PokerHandTest >> testRotateSpeaker5 [
	| hand5 players |
	players := {julio.nacho.santi.fede.panda} asOrderedCollection.
	nacho chips: 16.
	hand5 := PokerHand players: players dealer: nacho.
	hand5
		placeAnteFor: julio;
		placeAnteFor: fede;
		placeAnteFor: panda;
		placeAnteFor: nacho;
		placeAnteFor: santi.
	hand5 deal.
	hand5
		passPlayer: santi;
		placeFirstBet: 12 for: fede;
		callFirstBetFor: panda;
		callFirstBetFor: julio;
		raiseFirstBet: 3 for: nacho;
		callFirstBetFor: santi;
		callFirstBetFor: fede;
		callFirstBetFor: panda;
		callFirstBetFor: julio.
	self assert: hand5 firstBetsRoundDone.
	hand5 enableCardsChange.
	self assert: hand5 speaker equals: santi.
	players
		do: [ :player | hand5 change: (player cards first: 2) to: player ].
	hand5 acceptBets.
	self assert: hand5 speaker equals: santi
]

{ #category : #test }
PokerHandTest >> testSecondBetsRoundDone [
	"Smallhand order is: fede > nacho > wainer > mono"

	smallHand players do: [ :player | player chips: 100 ].
	smallHand players do: [ :player | smallHand placeAnteFor: player ].
	smallHand deal.
	smallHand
		placeFirstBet: 20 for: nacho;
		callFirstBetFor: wainer;
		callFirstBetFor: mono;
		callFirstBetFor: fede.
	self assert: smallHand firstBetsRoundDone.
	self deny: smallHand secondBetsRoundDone.
	smallHand enableCardsChange.
	smallHand players do: [ :player | smallHand change: {} to: player ].
	smallHand acceptBets.
	smallHand
		placeSecondBet: 20 for: nacho;
		placeSecondBet: 20 for: wainer;
		raiseSecondBet: 30 for: mono.
	self deny: smallHand secondBetsRoundDone.
	smallHand
		placeSecondBet: 50 for: fede;
		placeSecondBet: 30 for: nacho;
		placeSecondBet: 30 for: wainer.
	self assert: smallHand secondBetsRoundDone
]

{ #category : #test }
PokerHandTest >> testSecondBetsRoundDone2 [
	"Smallhand order is: fede > nacho > wainer > mono"

	smallHand players do: [ :player | player chips: 100 ].
	smallHand players do: [ :player | smallHand placeAnteFor: player ].
	smallHand deal.
	smallHand
		placeFirstBet: 20 for: nacho;
		callFirstBetFor: wainer;
		callFirstBetFor: mono;
		callFirstBetFor: fede.
	self assert: smallHand firstBetsRoundDone.
	self deny: smallHand secondBetsRoundDone.
	smallHand enableCardsChange.
	smallHand players do: [ :player | smallHand change: {} to: player ].
	smallHand acceptBets.
	smallHand
		placeSecondBet: 20 for: nacho;
		foldPlayer: wainer;
		raiseSecondBet: 30 for: mono.
	self deny: smallHand secondBetsRoundDone.
	smallHand
		placeSecondBet: 50 for: fede;
		placeSecondBet: 30 for: nacho.
	self assert: smallHand secondBetsRoundDone
]

{ #category : #test }
PokerHandTest >> testSecondBetsRoundDone3 [
	| hand4 players |
	players := {julio . pera . fede . wainer} asOrderedCollection.
	hand4 := PokerHand players: players dealer: fede.
	hand4 placeAnteFor: pera; placeAnteFor: julio; placeAnteFor: fede; placeAnteFor: wainer.
	hand4 deal.
	hand4 passPlayer: wainer; placeFirstBet: 8 for: julio; callFirstBetFor: pera; callFirstBetFor: fede; callFirstBetFor: wainer.
	self assert: hand4 firstBetsRoundDone.
	hand4 enableCardsChange.
	players do: [ :player | hand4 change: {  } to: player ].
	hand4 acceptBets.
	self deny: hand4 secondBetsRoundDone.
	hand4 passPlayer: julio.
	self deny: hand4 secondBetsRoundDone.
	hand4 passPlayer: pera.
	self deny: hand4 secondBetsRoundDone.
	hand4 passPlayer: fede.
	self deny: hand4 secondBetsRoundDone.
	hand4 passPlayer: wainer.
	self assert: hand4 secondBetsRoundDone.
]

{ #category : #test }
PokerHandTest >> testSecondBetsRoundDone4 [
	| hand4 players |
	players := {julio . pera . fede . wainer} asOrderedCollection.
	hand4 := PokerHand players: players dealer: fede.
	hand4 placeAnteFor: pera; placeAnteFor: julio; placeAnteFor: fede; placeAnteFor: wainer.
	hand4 deal.
	hand4 passPlayer: wainer; passPlayer: julio; passPlayer: pera; placeFirstBet: 10 for: fede; callFirstBetFor: wainer.
	hand4 foldPlayer: julio; foldPlayer: pera.
	self assert: hand4 firstBetsRoundDone.
	hand4 enableCardsChange.
	hand4 activePlayers do: [ :player | hand4 change: (player cards first:3) to: player ].
	hand4 acceptBets.
	self deny: hand4 secondBetsRoundDone.
	hand4 passPlayer: fede.
	self deny: hand4 secondBetsRoundDone.
	hand4 placeSecondBet: 20 for: wainer; callSecondBetFor: fede.
	self assert: hand4 secondBetsRoundDone.
]

{ #category : #test }
PokerHandTest >> testSecondBetsRoundDone5 [
	| hand5 players |
	players := {julio.	nacho.	santi.	fede.panda} asOrderedCollection.
	nacho chips: 16. 
	hand5 := PokerHand players: players dealer: nacho.
	hand5
		placeAnteFor: julio;
		placeAnteFor: fede;
		placeAnteFor: panda;
		placeAnteFor: nacho;
		placeAnteFor: santi.
	hand5 deal.
	hand5
		passPlayer: santi;
		placeFirstBet: 12 for: fede;
		callFirstBetFor: panda;
		callFirstBetFor: julio;
		raiseFirstBet: 3 for: nacho;
		callFirstBetFor: santi;
		callFirstBetFor: fede;
		callFirstBetFor: panda;
		callFirstBetFor: julio.
	self assert: hand5 firstBetsRoundDone.
	hand5 enableCardsChange. 
	self assert: hand5 speaker equals: santi.
	players do: [ :player | hand5 change: (player cards first: 2) to: player  ].
	hand5 acceptBets.
	self assert: hand5 speaker equals: santi.
	hand5
		passPlayer: santi;
		placeSecondBet: 15 for: fede;
		callSecondBetFor: panda;
		foldPlayer: julio.
	self assert: hand5 speaker equals: santi.
	hand5 foldPlayer: santi.
	self assert: hand5 secondBetsRoundDone 

]
