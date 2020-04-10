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
	smallHand players do: [ :player | smallHand placeAnteFor: player ].
	smallHand deal.
	self deny: smallHand firstBetsRoundDone.
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
