Extension { #name : #String }

{ #category : #'*JaguarPoker' }
String >> ofClubs [
	^ Card value: self suit: Suit clubs
]

{ #category : #'*JaguarPoker' }
String >> ofDiamonds [
	^ Card value: self suit: Suit diamonds
]

{ #category : #'*JaguarPoker' }
String >> ofHearts [
	^ Card value: self suit: Suit hearts
]

{ #category : #'*JaguarPoker' }
String >> ofSpades [
	^ Card value: self suit: Suit spades
]
