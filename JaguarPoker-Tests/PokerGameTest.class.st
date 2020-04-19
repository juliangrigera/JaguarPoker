"
A PokerGameTest is a test class for testing the behavior of PokerGame
"
Class {
	#name : #PokerGameTest,
	#superclass : #TestCase,
	#instVars : [
		'santi',
		'pera',
		'nico',
		'panda',
		'julio',
		'game',
		'players',
		'nacho',
		'wainer'
	],
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #running }
PokerGameTest >> setUp [
	santi := Player name: 'Santi'.
	pera := Player name: 'Pera'.
	nico := Player name: 'Nico'.
	nacho := Player name: 'Nacho'.
	wainer := Player name: 'Wainer'.
	panda := Player name: 'Panda'.
	julio := Player name: 'Julio'.
	players := {santi.
	pera.
	nico.
	panda.
	julio}.
	game := PokerGame players:
		players asOrderedCollection
]

{ #category : #test }
PokerGameTest >> testNewHand [
	|game2 passedHand hand5|
	players := { santi . nacho . pera . wainer . panda } asOrderedCollection.
	game2 := (PokerGame players: players) dealer: pera; yourself.
	game2 newHand.
	passedHand := game2 currentPokerHand.
	passedHand placeAnteFor: santi; placeAnteFor: pera; placeAnteFor: wainer; placeAnteFor: nacho; placeAnteFor: panda.
	self assert: passedHand potSize equals: 5.
	passedHand deal.
	{ wainer . panda . santi . nacho . pera} do: [ :passer | passedHand passPlayer: passer ].
	game2 newHand.
	hand5 := game2 currentPokerHand.
	hand5 placeAnteFor: santi; placeAnteFor: nacho; placeAnteFor: wainer; placeAnteFor: panda; placeAnteFor: pera.
	self assert: hand5 potSize equals: 15
]

{ #category : #test }
PokerGameTest >> testRotateDealer [
	self assert: game dealer equals: nil.
	game start.
	self assert: game dealer equals: players first.
	game rotateDealer.
	self assert: game dealer equals: players second.
	4 timesRepeat: [ game rotateDealer ].
	self assert: game dealer equals: players first
]
