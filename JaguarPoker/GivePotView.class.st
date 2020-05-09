"
Simple view for sharing the pot
"
Class {
	#name : #GivePotView,
	#superclass : #WAComponent,
	#instVars : [
		'hand',
		'shares',
		'chips',
		'winners'
	],
	#category : #'JaguarPoker-Web'
}

{ #category : #'instance creation' }
GivePotView class >> hand: aPokerHand [
	^ self new
		hand: aPokerHand;
		yourself
]

{ #category : #'instance creation' }
GivePotView class >> hand: aPokerHand winners: somePlayers [
	^ self new
		hand: aPokerHand;
		winners: somePlayers;
		yourself
]

{ #category : #accessing }
GivePotView >> chips [
	^ chips
]

{ #category : #accessing }
GivePotView >> chips: anObject [
	chips := anObject
]

{ #category : #controlling }
GivePotView >> givePot [
	| pot |
	pot := self hand potSize.
	self chips
		keysAndValuesDo: [ :player :share | 
			share
				ifNotNil: [ player getChips: share.
					pot := pot - share ] ].
	self hand resetPot.
	self answer
]

{ #category : #accessing }
GivePotView >> hand [
	^ hand
]

{ #category : #accessing }
GivePotView >> hand: aPokerHand [
	hand := aPokerHand
]

{ #category : #initialization }
GivePotView >> initialize [
	"Check additional initialization in #winners:"
	super initialize.
	shares := Dictionary new.
	chips := Dictionary new
]

{ #category : #accessing }
GivePotView >> maxPotFor: player [
	^ self hand partialPots
		detect: [ :partialPot | partialPot player = player ]
		ifFound: [ :pot | pot chipsCount ]
		ifNone: [ self hand potSize ]
]

{ #category : #rendering }
GivePotView >> renderCard: card on: html [
	html image
		class: #card;
		style: 'width:70px';
		title: card cssClassName;
		url: PokerFileLibrary / (card cssClassName , 'Png')
]

{ #category : #rendering }
GivePotView >> renderContentOn: html [
	html
		tbsContainerFluid: [ html heading: 'Repartir Pozo'.
			html heading level3
				with: [ html
						text: self hand potSize;
						space;
						text: #fichas ].
			html
				tbsForm: [ self renderPlayersOn: html.
					html tbsSubmitButton
						class: 'btn btn-success btn-lg';
						callback: [ self givePot ];
						with: 'Otorgar' ] ]
]

{ #category : #rendering }
GivePotView >> renderPlayer: player cardsOn: html [
	html
		paragraph: [ player visibleCards do: [ :card | self renderCard: card on: html ] ]
]

{ #category : #rendering }
GivePotView >> renderPlayer: player chipsInputOn: html [
	html
		tbsFormGroup: [ self
				renderPlayer: player nameOn: html;
				renderPlayer: player chipsTextInputOn: html;
				renderPlayer: player giveAllButonOn: html;
				renderPlayer: player cardsOn: html ]
]

{ #category : #rendering }
GivePotView >> renderPlayer: player chipsTextInputOn: html [
	html textInput
		tbsFormControl;
		id: player name asValidSelector;
		callback: [ :playerChips | 
			playerChips ~= '' & playerChips isNotNil
				ifTrue: [ self chips at: player put: playerChips asNumber ] ];
		placeholder: 'fichas'
]

{ #category : #rendering }
GivePotView >> renderPlayer: player giveAllButonOn: html [
	| maxPotSize |
	maxPotSize := self maxPotFor: player.
	html anchor
		class: 'btn btn-default btn-sm';
		onClick: ((html jQuery id: player name asValidSelector) value: maxPotSize);
		with: 'Otorgar ' , maxPotSize printString
]

{ #category : #rendering }
GivePotView >> renderPlayer: player nameOn: html [
	html heading level3 with: player name
]

{ #category : #rendering }
GivePotView >> renderPlayersOn: html [
	html
		tbsRow: [ self hand activePlayers 
				do: [ :player | 
					html
						tbsColumn: [ self renderPlayer: player chipsInputOn: html ]
						mediumSize: 2 ] ]
]

{ #category : #accessing }
GivePotView >> shares [
	^ shares
]

{ #category : #accessing }
GivePotView >> shares: anObject [
	shares := anObject
]

{ #category : #accessing }
GivePotView >> winners [
	^ winners
]

{ #category : #accessing }
GivePotView >> winners: somePlayers [
	winners := somePlayers.
	winners
		do: [ :winner | self chips at: winner put: (self maxPotFor: winner) ]
]
