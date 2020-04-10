Class {
	#name : #GivePotView,
	#superclass : #WAComponent,
	#instVars : [
		'hand',
		'shares'
	],
	#category : #'JaguarPoker-Web'
}

{ #category : #'instance creation' }
GivePotView class >> hand: aPokerHand [
	^ self new
		hand: aPokerHand;
		yourself
]

{ #category : #controlling }
GivePotView >> givePot [
	| pot |
	pot := self hand potSize.
	self shares
		keysAndValuesDo: [ :player :share | 
			| integerShare |
			integerShare := (self hand potSize * share asNumber / 100) floor.
			player getChips: integerShare.
			pot := pot - integerShare ].
	self hand dealer getChips: pot.
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
	super initialize.
	shares := Dictionary new
]

{ #category : #rendering }
GivePotView >> renderContentOn: html [
	html
		tbsContainer: [ html
				tbsForm: [ self hand activePlayers
						do: [ :player | self renderPlayer: player percentageInputOn: html ].
					html tbsSubmitButton
						class: 'btn btn-success btn-lg';
						callback: [ self givePot ];
						with: 'Repartir' ] ]
]

{ #category : #rendering }
GivePotView >> renderPlayer: player percentageInputOn: html [
	html
		tbsFormGroup: [ html label
				for: player name asValidSelector;
				with: player name.
			html textInput
				tbsFormControl;
				id: player name asValidSelector;
				callback: [ :share | share ifNotNil: [ self shares at: player put: share ] ];
				placeholder: '% del pozo' ]
]

{ #category : #accessing }
GivePotView >> shares [
	^ shares
]

{ #category : #accessing }
GivePotView >> shares: anObject [
	shares := anObject
]
