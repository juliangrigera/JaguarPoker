"
Base class for all card hands tests
"
Class {
	#name : #CardsHandTest,
	#superclass : #TestCase,
	#instVars : [
		'gameOf4',
		'gameOf5',
		'pair'
	],
	#category : #'JaguarPoker-Tests-Model'
}

{ #category : #running }
CardsHandTest >> setUp [
	| santi pera nico nacho julio |
	santi := Player name: 'Santi'.
	pera := Player name: 'Pera'.
	nico := Player name: 'Nico'.
	nacho := Player name: 'Nacho'.
	julio := Player name: 'Julio'.
	gameOf4 := (PokerGame players: { santi . nacho . pera . nico  } asOrderedCollection) dealer: pera; yourself.
	gameOf5 := (PokerGame players: { santi . nacho . pera . nico . julio } asOrderedCollection) dealer: pera; yourself.
	pair := CardsHand fromCards: { 'A' ofClubs . 'A' ofHearts . 'J' ofClubs . 'K' ofHearts . '6' ofClubs } inGame: gameOf5
]
