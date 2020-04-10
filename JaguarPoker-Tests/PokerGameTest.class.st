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
		'players'
	],
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #running }
PokerGameTest >> setUp [
	santi := Player name: 'Santi'.
	pera := Player name: 'Pera'.
	nico := Player name: 'Nico'.
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
PokerGameTest >> testRotateDealer [
	self assert: game dealer equals: nil.
	game start.
	self assert: game dealer equals: players first.
	game rotateDealer.
	self assert: game dealer equals: players second.
	4 timesRepeat: [ game rotateDealer ].
	self assert: game dealer equals: players first
]
