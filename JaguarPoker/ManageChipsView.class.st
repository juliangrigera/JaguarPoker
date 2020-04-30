"
A simple editor to manage all players' chips
Just in case :)
"
Class {
	#name : #ManageChipsView,
	#superclass : #WAComponent,
	#instVars : [
		'hand',
		'shares'
	],
	#category : #'JaguarPoker-Web'
}

{ #category : #'instance creation' }
ManageChipsView class >> hand: aPokerHand [
	^ self new
		hand: aPokerHand;
		yourself
]

{ #category : #controlling }
ManageChipsView >> givePot [
	self answer
]

{ #category : #accessing }
ManageChipsView >> hand [
	^ hand
]

{ #category : #accessing }
ManageChipsView >> hand: aPokerHand [
	hand := aPokerHand
]

{ #category : #rendering }
ManageChipsView >> renderContentOn: html [
	html
		tbsContainer: [ html
				tbsForm: [ self hand players
						do: [ :player | self renderPlayer: player chipsInputOn: html ].
					html tbsSubmitButton
						class: 'btn btn-success btn-lg';
						callback: [ self givePot ];
						with: 'Repartir' ] ]
]

{ #category : #rendering }
ManageChipsView >> renderPlayer: player chipsInputOn: html [
	html
		tbsFormGroup: [ html label
				for: player name asValidSelector;
				with: player name.
			html numberInput
				tbsFormControl;
				id: player name asValidSelector;
				value: player chips;
				callback: [ :chips | player chips: chips asNumber ];
				placeholder: 'fichas' ]
]
