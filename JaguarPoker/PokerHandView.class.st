"
I display a PokerHand 
"
Class {
	#name : #PokerHandView,
	#superclass : #WAComponent,
	#instVars : [
		'game',
		'selectedCards',
		'bid'
	],
	#category : #'JaguarPoker-Web'
}

{ #category : #'instance creation' }
PokerHandView class >> game: aPokerGame [
	^ self new
		game: aPokerGame;
		yourself
]

{ #category : #accessing }
PokerHandView >> bid [
	^ bid
]

{ #category : #accessing }
PokerHandView >> bid: anObject [
	bid := anObject
]

{ #category : #controlling }
PokerHandView >> callFirstBetFor: aPlayer [
	self hand callFirstBetFor: aPlayer.
	self bid: 0
]

{ #category : #controlling }
PokerHandView >> changeCardsTo: aPlayer [
	self hand change: self selectedCards to: aPlayer.
	self selectedCards: OrderedCollection new
]

{ #category : #accessing }
PokerHandView >> currentPlayer [
	^ self session player
]

{ #category : #controlling }
PokerHandView >> foldPlayer: aPlayer [
	self hand foldPlayer: aPlayer
]

{ #category : #accessing }
PokerHandView >> game [
	^ game
]

{ #category : #accessing }
PokerHandView >> game: anObject [
	game := anObject
]

{ #category : #accessing }
PokerHandView >> hand [
	^ self game currentPokerHand
]

{ #category : #initialization }
PokerHandView >> initialize [
	selectedCards := OrderedCollection new
]

{ #category : #testing }
PokerHandView >> isDealer [
	^ self hand dealer = self session player
]

{ #category : #testing }
PokerHandView >> isSpeaker [
	^ self hand speaker = self session player
]

{ #category : #controlling }
PokerHandView >> newHand [
	self selectedCards: OrderedCollection new.
	self game newHand
]

{ #category : #controlling }
PokerHandView >> passPlayer: aPlayer [
	self hand passPlayer: aPlayer
]

{ #category : #controlling }
PokerHandView >> placeAnteFor: aPlayer [
	self hand placeAnteFor: aPlayer
]

{ #category : #controlling }
PokerHandView >> placeFirstBet: aString for: aPlayer [
	self hand placeFirstBet: aString asNumber for: aPlayer.
	self bid: 0
]

{ #category : #controlling }
PokerHandView >> placeSecondBet: aString for: aPlayer [
	self hand placeSecondBet: aString asNumber for: aPlayer.
	self bid: 0
]

{ #category : #rendering }
PokerHandView >> renderCard: card on: html [
	| cardId |
	cardId := 'card' , card cssClassName.
	html checkbox
		id: cardId;
		callback: [ :value | 
			value
				ifTrue: [ self selectedCards add: card ] ].
	html label
		class: 'card-label';
		for: cardId;
		with: [ html image
				class: #card;
				style: 'width:70px';
				title: card cssClassName;
				url: PokerFileLibrary / (card cssClassName , 'Png') ]
]

{ #category : #rendering }
PokerHandView >> renderContentOn: html [
	html
		tbsContainerFluid: [ html
				heading: [ html
						text: 'Jaguarpoker';
						space;
						small: self hand state className ].
			self renderControlsOn: html.
			self renderPlayersOn: html.
			html
				tbsRow: [ html
						tbsColumn: [ html tbsWell
								script:
									(html jQuery this load
										html: [ :r | self renderPotOn: r ];
										interval: 2 seconds);
								with: [ self renderPotOn: html ] ]
							mediumSize: 7;
						tbsColumn: [ html tbsWell
								script:
									(html jQuery this load
										html: [ :r | self renderRemainingCardsOn: r ];
										interval: 2 seconds);
								with: [ self renderRemainingCardsOn: html ] ]
							mediumSize: 5 ] ]
]

{ #category : #rendering }
PokerHandView >> renderControlButton: aString callback: aBlock condition: aBoolean on: html [
	| controlButton |
	controlButton := html anchor class: 'btn btn-primary btn-lg'.
	aBoolean
		ifTrue: [ controlButton callback: aBlock ]
		ifFalse: [ controlButton class: 'disabled' ].
	controlButton with: aString
]

{ #category : #rendering }
PokerHandView >> renderControlsOn: html [
	html div
		script:
			(html jQuery this load
				html: [ :r | self renderControlsPanelOn: r ];
				interval: 2 seconds);
		with: [ self renderControlsPanelOn: html ]
]

{ #category : #rendering }
PokerHandView >> renderControlsPanelOn: html [
	self isDealer
		ifTrue: [ self
				renderControlButton: 'Repartir'
					callback: [ self hand deal ]
					condition: self hand canDeal
					on: html;
				renderControlButton: 'Habilitar Cambio de Cartas'
					callback: [ self hand enableCardsChange ]
					condition: self hand canChangeCards
					on: html;
				renderControlButton: 'Habilitar Apuesta Final'
					callback: [ self hand acceptBets ]
					condition: self hand canAcceptBets
					on: html;
				renderControlButton: 'Habilitar Mostrar Cartas'
					callback: [ self hand enableCardsShowing ]
					condition: self hand canShowCards
					on: html;
				renderControlButton: 'Otorgar Pozo'
					callback: [ self call: (GivePotView hand: self hand) ]
					condition: self hand canSharePot
					on: html.
			html anchor
				class: 'btn btn-success btn-lg';
				callback: [ self newHand ];
				with: 'Nueva Mano' ]
]

{ #category : #rendering }
PokerHandView >> renderCoveredCard: card on: html [
	html image
		class: #card;
		style: 'width:70px';
		url: PokerFileLibrary / #coveredCardPng
]

{ #category : #'rendering - player' }
PokerHandView >> renderDealerIndicatorFor: aPlayer on: html [
	aPlayer = self hand dealer
		ifTrue: [ html
				space;
				tbsBadge: 'reparte' ]
]

{ #category : #rendering }
PokerHandView >> renderDeckOn: html [
	html heading level4 with: 'Mazo'.
	self hand deck do: [ :card | self renderCoveredCard: card on: html ]
]

{ #category : #rendering }
PokerHandView >> renderDiscardedOn: html [
	html heading level4 with: 'Descarte'.
	self hand discarded do: [ :card | self renderCoveredCard: card on: html ]
]

{ #category : #'rendering - visitor' }
PokerHandView >> renderFoldButtonOn: html [
	^ html anchor
		class: 'btn btn-danger btn-sm';
		callback: [ self foldPlayer: self currentPlayer ];
		with: 'irse'
]

{ #category : #'rendering - player' }
PokerHandView >> renderFoldedIndicatorFor: aPlayer on: html [
	(self hand hasFolded: aPlayer)
		ifTrue: [ html
				space;
				span: ' se fue' ]
]

{ #category : #'rendering - player' }
PokerHandView >> renderIndicatorsFor: aPlayer on: html [
	html
		small: [ self
				renderDealerIndicatorFor: aPlayer on: html;
				renderFoldedIndicatorFor: aPlayer on: html;
				renderSpeakerIndicatorFor: aPlayer on: html ]
]

{ #category : #'rendering - player' }
PokerHandView >> renderOtherPlayer: player on: html [
	html form
		script:
			(html jQuery this load
				html: [ :r | self renderOtherPlayer: player panelOn: r ];
				interval: 2 seconds);
		with: [ self renderOtherPlayer: player panelOn: html ]
]

{ #category : #'rendering - player' }
PokerHandView >> renderOtherPlayer: player panelOn: html [
	html heading level4
		with: [ html text: player name.
			self renderIndicatorsFor: player on: html ].
	html div
		class: #folded if: (self hand hasFolded: player);
		with: [ player cards
				do: [ :card | 
					(player canShow: card)
						ifTrue: [ self renderCard: card on: html ]
						ifFalse: [ self renderCoveredCard: card on: html ] ] ].
	html paragraph: player chips printString , ' fichas'
]

{ #category : #'rendering - player' }
PokerHandView >> renderOwnPlayer: player on: html [
	| form |
	form := html form.
	form id: #ownPlayerPanel.
	self isSpeaker
		ifFalse: [ form
				script:
					(html jQuery this load
						html: [ :r | self renderOwnPlayer: player panelOn: r ];
						interval: 2 seconds) ].
	form with: [ self renderOwnPlayer: player panelOn: html ]
]

{ #category : #'rendering - player' }
PokerHandView >> renderOwnPlayer: player panelOn: html [
	html heading level4
		with: [ html text: player name.
			self renderIndicatorsFor: player on: html ].
	html div
		class: #folded if: (self hand hasFolded: player);
		with: [ player cards do: [ :card | self renderCard: card on: html ] ].
	html paragraph: player chips printString , ' fichas'.
	html paragraph: [ self renderPlayer: player controlsOn: html ]
]

{ #category : #'rendering - visitor' }
PokerHandView >> renderPassButtonOn: html [
	^ html anchor
		class: 'btn btn-warning btn-sm';
		callback: [ self passPlayer: self currentPlayer ];
		with: 'pasar'
]

{ #category : #'rendering - player' }
PokerHandView >> renderPlayer: aPlayer controlsOn: html [
	(self hand hasFolded: aPlayer)
		ifFalse: [ self hand accept: self with: html ]
]

{ #category : #'rendering - player' }
PokerHandView >> renderPlayer: player on: html [
	self session player = player
		ifTrue: [ self renderOwnPlayer: player on: html ]
		ifFalse: [ self renderOtherPlayer: player on: html ]
]

{ #category : #rendering }
PokerHandView >> renderPlayersOn: html [
	html
		tbsRow: [ self hand players
				do:
					[ :player | html tbsColumn: [ self renderPlayer: player on: html ] mediumSize: 2 ] ]
]

{ #category : #rendering }
PokerHandView >> renderPotOn: html [
	html heading level4 with: 'Pozo'.
	html paragraph: 'Total: ' , self hand potSize printString.
	self hand pot do: [ :bet | html paragraph: bet ]
]

{ #category : #rendering }
PokerHandView >> renderRemainingCardsOn: html [
	html
		tbsRow: [ self renderDeckOn: html ];
		tbsRow: [ self renderDiscardedOn: html ]
]

{ #category : #'rendering - visitor' }
PokerHandView >> renderSecondBetFormOn: html [
	| chipsToMatch |
	chipsToMatch := self hand chipsToCallSecondBetFor: self currentPlayer.
	html tbsRow
		class: #bettingOptions;
		with: [ html
				tbsColumn: [ html textInput
						tbsFormControl;
						class: 'input-sm';
						on: #bid of: self;
						placeholder: 'Apuesta' ]
				mediumSize: 4.
			html
				tbsColumn: [ html tbsSubmitButton
						class: 'btn btn-default btn-sm';
						callback: [ self placeSecondBet: self bid for: self currentPlayer ];
						with: 'apostar' ]
				mediumSize: 3.
			chipsToMatch > 0
				ifTrue: [ html
						tbsColumn: [ html anchor
								class: 'btn btn-default btn-sm';
								callback: [ self placeSecondBet: chipsToMatch for: self currentPlayer ];
								with: 'ver ' , chipsToMatch printString ]
						mediumSize: 3 ] ]
]

{ #category : #'rendering - visitor' }
PokerHandView >> renderShowCardsButtonOn: html [
	^ html tbsSubmitButton
		class: 'btn btn-success btn-sm';
		callback: [ self showCards ];
		with: 'mostrar cartas'
]

{ #category : #'rendering - player' }
PokerHandView >> renderSpeakerIndicatorFor: aPlayer on: html [
	aPlayer = self hand speaker
		ifTrue: [ html space.
			html tbsBadge: 'habla' ]
]

{ #category : #'rendering - visitor' }
PokerHandView >> renderStopRefreshScriptOn: html [
	html script: '$(''#ownPlayerPanel'').attr(''id'','''')'
]

{ #category : #accessing }
PokerHandView >> selectedCards [
	^ selectedCards
]

{ #category : #private }
PokerHandView >> selectedCards: someCards [
	selectedCards := someCards
]

{ #category : #controlling }
PokerHandView >> showCards [
	self currentPlayer showCards: self selectedCards.
	self selectedCards: OrderedCollection new.
	self hand rotateSpeaker
]

{ #category : #'rendering - visitor' }
PokerHandView >> visitBiddingHand: aBetState with: html [
	self isSpeaker
		ifTrue: [ self renderStopRefreshScriptOn: html.
			self renderSecondBetFormOn: html.
			html tbsRow
				class: #bettingOptions;
				class: #handControl;
				with: [ html tbsColumn
						mediumSize: 4;
						with: [ (self hand chipsToCallSecondBetFor: self currentPlayer) = 0
								ifTrue: [ self renderPassButtonOn: html ] ].
					html tbsColumn
						mediumSize: 4;
						with: [ html anchor
								class: 'btn btn-danger btn-sm';
								callback: [ self foldPlayer: self currentPlayer ];
								with: 'irse' ] ] ]
]

{ #category : #'rendering - visitor' }
PokerHandView >> visitChangingCardsHand: aHand with: html [
	self isSpeaker
		ifTrue: [ self renderStopRefreshScriptOn: html.
			html tbsSubmitButton
				class: 'btn btn-default btn-sm';
				callback: [ self changeCardsTo: self currentPlayer ];
				with: 'cambiar' ]
]

{ #category : #'rendering - visitor' }
PokerHandView >> visitDealtHand: aHand with: html [
	| chipsToMatch |
	chipsToMatch := self hand chipsToCallFirstBetFor: self currentPlayer.
	self isSpeaker
		ifTrue: [ self renderStopRefreshScriptOn: html.
			html tbsRow
				class: #bettingOptions;
				with: [ html
						tbsColumn: [ html textInput
								tbsFormControl;
								class: 'input-sm';
								on: #bid of: self;
								placeholder: 'Apuesta' ]
						mediumSize: 4.
					html
						tbsColumn: [ html tbsSubmitButton
								class: 'btn btn-default btn-sm';
								callback: [ self placeFirstBet: self bid for: self currentPlayer ];
								with: 'apostar' ]
						mediumSize: 3.
					chipsToMatch > 0
						ifTrue: [ html
								tbsColumn: [ html anchor
										class: 'btn btn-default btn-sm';
										callback: [ self placeFirstBet: chipsToMatch for: self currentPlayer ];
										with: 'ver ' , chipsToMatch printString ]
								mediumSize: 3 ] ].
			html tbsRow
				class: #bettingOptions;
				with: [ (self hand chipsToCallFirstBetFor: self currentPlayer) = 0
						ifTrue: [ html tbsColumn
								mediumSize: 4;
								class: #fold;
								with: [ html anchor
										class: 'btn btn-warning btn-sm';
										callback: [ self passPlayer: self currentPlayer ];
										with: 'pasar' ] ].
					html tbsColumn
						mediumSize: 4;
						class: #fold;
						with: [ html anchor
								class: 'btn btn-danger btn-sm';
								callback: [ self foldPlayer: self currentPlayer ];
								with: 'irse' ] ] ]
]

{ #category : #'rendering - visitor' }
PokerHandView >> visitFreshHand: aHand with: html [
	(self hand antePlacedFor: self currentPlayer)
		ifFalse: [ html tbsSubmitButton
				class: 'btn btn-default btn-sm';
				callback: [ self placeAnteFor: self currentPlayer ];
				with: 'poner luz' ]
]

{ #category : #'rendering - visitor' }
PokerHandView >> visitShowCardsHand: aShowCardsState with: html [
	self renderStopRefreshScriptOn: html.
	html tbsRow
		class: #bettingOptions;
		class: #handControl;
		with: [ html tbsColumn
				mediumSize: 4;
				with: [ self renderShowCardsButtonOn: html ] ]
]
