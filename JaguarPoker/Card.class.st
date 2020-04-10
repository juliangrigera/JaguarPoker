"
A french deck card.

Value is a string and suit is an instance of class Suit.
"
Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'value',
		'suit'
	],
	#category : #'JaguarPoker-Model'
}

{ #category : #'instance creation' }
Card class >> pokerDeck [
	^ ({'6' . '7' . '8' . '9' . '10' . 'J' . 'Q' . 'K' . 'A'}
		flatCollect: [ :value | 
			{Suit spades.
			Suit hearts.
			Suit clubs.
			Suit diamonds} collect: [ :suit | self value: value suit: suit ] ])
		asOrderedCollection
]

{ #category : #'instance creation' }
Card class >> smallPokerDeck [
	^ ({'7' . '8' . '9' . '10' . 'J' . 'Q' . 'K' . 'A'}
		flatCollect: [ :value | 
			{Suit spades.
			Suit hearts.
			Suit clubs.
			Suit diamonds} collect: [ :suit | self value: value suit: suit ] ])
		asOrderedCollection
]

{ #category : #'instance creation' }
Card class >> value: aString suit: aSuit [
	^ self new
		value: aString;
		suit: aSuit;
		yourself
]

{ #category : #accessing }
Card >> cssClassName [
	^ (self suit name , self value asString) asSymbol
]

{ #category : #printing }
Card >> printOn: aStream [
	aStream
		nextPutAll: self value;
		nextPutAll: ' of ';
		nextPutAll: self suit name
]

{ #category : #accessing }
Card >> suit [
	^ suit
]

{ #category : #accessing }
Card >> suit: aSuit [
	suit := aSuit
]

{ #category : #accessing }
Card >> value [
	^ value
]

{ #category : #accessing }
Card >> value: aString [
	value := aString
]
