Extension { #name : #Character }

{ #category : #'*JaguarPoker' }
Character >> ofClubs [
	^ Card value: self suit: Suit clubs
]

{ #category : #'*JaguarPoker' }
Character >> ofDiamonds [
	^ Card value: self suit: Suit diamonds
]

{ #category : #'*JaguarPoker' }
Character >> ofHearts [
	^ Card value: self suit: Suit hearts
]

{ #category : #'*JaguarPoker' }
Character >> ofSpades [
	^ Card value: self suit: Suit spades
]
