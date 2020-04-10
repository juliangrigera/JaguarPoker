"
French cards suit
"
Class {
	#name : #Suit,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#classInstVars : [
		'Suits'
	],
	#category : #'JaguarPoker-Model'
}

{ #category : #'instance creation' }
Suit class >> clubs [
	^ Suits at: #clubs
]

{ #category : #'instance creation' }
Suit class >> diamonds [
	^ Suits at: #diamonds
]

{ #category : #'instance creation' }
Suit class >> hearts [
	^ Suits at: #hearts
]

{ #category : #'class initialization' }
Suit class >> initialize [
	Suits := {(#spades -> (self new name: 'Spades')).
	(#diamonds -> (self new name: 'Diamonds')).
	(#hearts -> (self new name: 'Hearts')).
	(#clubs -> (self new name: 'Clubs'))} asDictionary
]

{ #category : #'instance creation' }
Suit class >> spades [
	^ Suits at: #spades
]

{ #category : #accessing }
Suit >> name [
	^ name
]

{ #category : #accessing }
Suit >> name: anObject [
	name := anObject
]
