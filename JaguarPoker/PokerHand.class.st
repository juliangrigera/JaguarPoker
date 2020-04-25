"
A poker hand with a states flow.
Have a cards deck and a collection of players.
"
Class {
	#name : #PokerHand,
	#superclass : #Object,
	#instVars : [
		'players',
		'speaker',
		'activePlayers',
		'dealer',
		'deck',
		'discarded',
		'pot',
		'state',
		'lastRaiser',
		'allInPlayers',
		'log'
	],
	#category : #'JaguarPoker-Model'
}

{ #category : #examples }
PokerHand class >> players: somePlayers [
	^ self new
		players: somePlayers;
		dealer: somePlayers first;
		yourself
]

{ #category : #examples }
PokerHand class >> players: somePlayers dealer: aPlayer [
	^ self new
		players: somePlayers;
		dealer: aPlayer;
		yourself
]

{ #category : #examples }
PokerHand class >> testHand [
	^ PokerHand new
		addPlayer: (Player name: 'Santi');
		addPlayer: (Player name: 'Pera');
		addPlayer: (Player name: 'Nico');
		addPlayer: (Player name: 'Panda');
		addPlayer: (Player name: 'Julio');
		yourself
]

{ #category : #visitor }
PokerHand >> accept: aHost with: aParameter [
	self state accept: aHost with: aParameter
]

{ #category : #game }
PokerHand >> acceptBets [
	self activePlayers do: [ :player | player passed: false ].
	self state acceptBets
]

{ #category : #accessing }
PokerHand >> activePlayers [
	^ activePlayers
]

{ #category : #'game - bets' }
PokerHand >> addBet: aBet [
	self pot add: aBet
]

{ #category : #accessing }
PokerHand >> addPlayer: aPlayer [
	self players add: aPlayer.
	self activePlayers add: aPlayer
]

{ #category : #testing }
PokerHand >> allAntesPlaced [
	^ self players
		allSatisfy: [ :player | self pot anySatisfy: [ :bet | bet player = player ] ]
]

{ #category : #accessing }
PokerHand >> allInPlayers [
	^ allInPlayers
]

{ #category : #testing }
PokerHand >> antePlacedFor: aPlayer [
	^ self antes anySatisfy: [ :bet | bet player = aPlayer ]
]

{ #category : #accessing }
PokerHand >> antes [
	^ self pot select: #isAnte
]

{ #category : #'game - bets' }
PokerHand >> callFirstBetFor: aPlayer [
	self
		placeFirstBet: (self chipsToCallFirstBetFor: aPlayer)
		for: aPlayer
]

{ #category : #'game - bets' }
PokerHand >> callSecondBetFor: aPlayer [
	self
		placeSecondBet: (self chipsToCallSecondBetFor: aPlayer)
		for: aPlayer
]

{ #category : #game }
PokerHand >> canAcceptBets [
	^ self state canAcceptBets
]

{ #category : #testing }
PokerHand >> canChangeCards [
	^ self state canChangeCards
]

{ #category : #testing }
PokerHand >> canDeal [
	^ self state canDeal
]

{ #category : #game }
PokerHand >> canSharePot [
	^ self state canSharePot
]

{ #category : #testing }
PokerHand >> canShowCards [
	^ self state canShowCards
]

{ #category : #game }
PokerHand >> change: someCards to: aPlayer [
	aPlayer discard: someCards.
	self deal: someCards size to: aPlayer.
	self discarded addAll: someCards.
	self rotateSpeaker
]

{ #category : #testing }
PokerHand >> changesRoundDone [
	^ self activePlayers allSatisfy: #changedCards
]

{ #category : #'game - bets' }
PokerHand >> chipsToCallFirstBetFor: aPlayer [
	| topFirstBetter topFirstBet playersFirstBet |
	^ self firstBets
		ifEmpty: [ 0 ]
		ifNotEmpty: [ topFirstBetter := self activePlayers
				detectMax: [ :player | self totalFirstBetsFor: player ].
			topFirstBet := self totalFirstBetsFor: topFirstBetter.
			playersFirstBet := self firstBets
				detect: [ :bet | bet player = aPlayer ]
				ifFound: [ :bet | bet chipsCount ]
				ifNone: [ 0 ].
			topFirstBet - playersFirstBet min: aPlayer chipsCount ]
]

{ #category : #'game - bets' }
PokerHand >> chipsToCallSecondBetFor: aPlayer [
	| topSecondBet playersSecondBet |
	^ self secondBets
		ifEmpty: [ 0 ]
		ifNotEmpty: [ topSecondBet := (self secondBets detectMax: [ :bet | bet chipsCount ]) chipsCount.
			playersSecondBet := self secondBets
				detect: [ :bet | bet player = aPlayer ]
				ifFound: [ :bet | bet chipsCount ]
				ifNone: [ 0 ].
			topSecondBet - playersSecondBet ]
]

{ #category : #game }
PokerHand >> deal [
	self state deal
]

{ #category : #game }
PokerHand >> deal: cardsCount to: aPlayer [
	self deck size >= cardsCount
		ifTrue: [ aPlayer drawCards: (self draw: cardsCount) ]
		ifFalse: [ aPlayer drawCards: (self draw: self deck size).
			self
				useDiscardedAsDeck;
				shuffle.
			aPlayer drawCards: (self draw: 5 - aPlayer cardsCount) ]
]

{ #category : #accessing }
PokerHand >> dealer [
	^ dealer
]

{ #category : #accessing }
PokerHand >> dealer: anObject [
	dealer := anObject
]

{ #category : #accessing }
PokerHand >> deck [
	^ deck
		ifNil: [ deck := self playersCount > 4
				ifTrue: [ Card pokerDeck shuffled]
				ifFalse: [ Card smallPokerDeck shuffled] ]
]

{ #category : #accessing }
PokerHand >> discarded [
	^ discarded
]

{ #category : #private }
PokerHand >> doDeal [
	self players do: [ :player | self deal: 5 to: player ].
	self speaker: self leader
]

{ #category : #private }
PokerHand >> doRotateSpeaker [
	| nextSpeaker currentFolded |
	currentFolded := (self activePlayers includes: self speaker) not.
	nextSpeaker := currentFolded
		ifTrue: [ self firstActiveAfter: self speaker ]
		ifFalse: [ self activePlayers
				after: self speaker
				ifAbsent: [ self activePlayers first ] ].
	self speaker: nextSpeaker
]

{ #category : #game }
PokerHand >> draw: aNumber [
	^ self deck removeFirst: aNumber
]

{ #category : #game }
PokerHand >> enableCardsChange [
	self state enableCardsChange
]

{ #category : #game }
PokerHand >> enableCardsShowing [
	self state enableCardsShowing
]

{ #category : #private }
PokerHand >> firstActiveAfter: aPlayer [
	| index |
	index := self players indexOf: aPlayer.
	(0 to: self players size - 2)
		collect: [ :ix | 
			| candidateIndex candidate |
			candidateIndex := 1 + ((ix + index) % self players size).
			candidate := self players at: candidateIndex.
			(self activePlayers includes: candidate)
				ifTrue: [ ^ candidate ] ]
]

{ #category : #'game - bets' }
PokerHand >> firstBets [
	^ self pot select: #isFirstBet
]

{ #category : #testing }
PokerHand >> firstBetsAreEven [
	^ self activePlayers
		allSatisfy: [ :active | 
			| totalInPot |
			totalInPot := self totalInPotFor: active.
			self activePlayers
				allSatisfy:
					[ :other | (self totalInPotFor: other) >= totalInPot | (self isAllIn: other) ] ]
]

{ #category : #testing }
PokerHand >> firstBetsPlaced [
	^ self firstBets isNotEmpty
]

{ #category : #testing }
PokerHand >> firstBetsRoundDone [
	^ self firstBetsAreEven
		&
			((self activePlayers allSatisfy: #passed)
				|
					(self activePlayers
						allSatisfy: [ :player | self placedFirstBet: player ]))
]

{ #category : #game }
PokerHand >> foldPlayer: aPlayer [
	self activePlayers remove: aPlayer.
	self rotateSpeaker
]

{ #category : #testing }
PokerHand >> hasFolded: aPlayer [
	^ (self activePlayers includes: aPlayer) not
]

{ #category : #initializing }
PokerHand >> initialize [
	"Lazy initializations as well, see accessors (#deck)"

	players := OrderedCollection new.
	discarded := OrderedCollection new.
	allInPlayers := OrderedCollection new.
	pot := OrderedCollection new.
	state := FreshState hand: self.
	log := OrderedCollection new
]

{ #category : #testing }
PokerHand >> isAllIn: aPlayer [
	^ self allInPlayers includes: aPlayer
]

{ #category : #accessing }
PokerHand >> lastRaiser [
	^ lastRaiser
]

{ #category : #accessing }
PokerHand >> lastRaiser: anObject [
	lastRaiser := anObject
]

{ #category : #accessing }
PokerHand >> leader [
	^ self players after: dealer ifAbsent: self players first
]

{ #category : #accessing }
PokerHand >> log [
	^ log
]

{ #category : #accessing }
PokerHand >> log: aString [
	self log add: aString
]

{ #category : #game }
PokerHand >> markAsAllIn: aPlayer [
	self allInPlayers add: aPlayer
]

{ #category : #'game - bets' }
PokerHand >> partialPots [
	^ self allInPlayers
		collect: [ :player | PartialPot player: player hand: self ]
]

{ #category : #game }
PokerHand >> passPlayer: aPlayer [
	aPlayer pass.
	self rotateSpeaker
]

{ #category : #'game - bets' }
PokerHand >> placeAnteFor: aPlayer [
	self state placeAnteOf: 1 for: aPlayer
]

{ #category : #'game - bets' }
PokerHand >> placeFirstBet: anInteger for: aPlayer [
	self state placeFirstBet: anInteger for: aPlayer
]

{ #category : #'game - bets' }
PokerHand >> placeSecondBet: anInteger for: aPlayer [
	self state placeSecondBet: anInteger for: aPlayer
]

{ #category : #testing }
PokerHand >> placedFirstBet: player [
	^ self firstBets anySatisfy: [ :bet | bet player = player ]
]

{ #category : #testing }
PokerHand >> placedSecondBet: player [
	^ self secondBets anySatisfy: [ :bet | bet player = player ]
]

{ #category : #accessing }
PokerHand >> players [
	^ players
]

{ #category : #accessing }
PokerHand >> players: somePlayers [
	players := somePlayers.
	activePlayers := somePlayers copy
]

{ #category : #accessing }
PokerHand >> playersCount [
	^ self players size
]

{ #category : #accessing }
PokerHand >> pot [
	^ pot
]

{ #category : #accessing }
PokerHand >> pot: anObject [
	pot := anObject
]

{ #category : #'game - bets' }
PokerHand >> potSize [
	^ self pot sumNumbers: #chipsCount
]

{ #category : #'game - bets' }
PokerHand >> raiseFirstBet: anInteger for: aPlayer [
	self state raiseFirstBet: anInteger for: aPlayer
]

{ #category : #'game - bets' }
PokerHand >> raiseSecondBet: anInteger for: aPlayer [
	self state raiseSecondBet: anInteger for: aPlayer
]

{ #category : #initializing }
PokerHand >> resetPot [
	pot := OrderedCollection new
]

{ #category : #private }
PokerHand >> resetSpeaker [
	self
		speaker: self dealer;
		rotateSpeaker
]

{ #category : #private }
PokerHand >> rotateSpeaker [
	self state rotateSpeaker
]

{ #category : #accessing }
PokerHand >> secondBets [
	^ self pot select: #isSecondBet
]

{ #category : #testing }
PokerHand >> secondBetsAreEven [
	^ self activePlayers
		allSatisfy: [ :active | 
			| totalInPot |
			totalInPot := self totalInPotFor: active.
			self activePlayers
				allSatisfy:
					[ :other | (self totalInPotFor: other) >= totalInPot | (self isAllIn: other) ] ]
]

{ #category : #testing }
PokerHand >> secondBetsPlaced [
	^ self secondBets isNotEmpty
]

{ #category : #testing }
PokerHand >> secondBetsRoundDone [
	^ self secondBetsAreEven
		&
			((self activePlayers allSatisfy: #passed)
				|
					(self activePlayers
						allSatisfy: [ :player | self placedSecondBet: player ]))
]

{ #category : #game }
PokerHand >> shuffle [
	self deck shuffle
]

{ #category : #accessing }
PokerHand >> speaker [
	^ speaker
]

{ #category : #accessing }
PokerHand >> speaker: anObject [
	speaker := anObject
]

{ #category : #accessing }
PokerHand >> state [
	^ state
]

{ #category : #accessing }
PokerHand >> state: anObject [
	state := anObject
]

{ #category : #'game - bets' }
PokerHand >> totalFirstBetsFor: aPlayer [
	^ (self firstBets select: [ :bet | bet player = aPlayer ])
		sumNumbers: #chipsCount
]

{ #category : #'game - bets' }
PokerHand >> totalInPotFor: aPlayer [
	^ (self pot select: [ :bet | bet player = aPlayer ])
		sumNumbers: #chipsCount
]

{ #category : #game }
PokerHand >> useDiscardedAsDeck [
	deck addAll: self discarded.
	self discarded removeAll
]
