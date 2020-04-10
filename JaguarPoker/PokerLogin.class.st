"
Login form for JaguarPoker
"
Class {
	#name : #PokerLogin,
	#superclass : #WAComponent,
	#instVars : [
		'gameCode',
		'playerName'
	],
	#category : #'JaguarPoker-Web'
}

{ #category : #accessing }
PokerLogin >> gameCode [
	^ gameCode
]

{ #category : #accessing }
PokerLogin >> gameCode: anObject [
	gameCode := anObject
]

{ #category : #controlling }
PokerLogin >> login [
	| player game |
	game := PokerGame gameWithCode: self gameCode.
	game
		ifNotNil: [ player := game playerNamedOrNew: self playerName.
			[ game addPlayer: player ]
				on: Error
				do: [ self answer: nil ].
			self answer: (GamingPlayer game: game player: player) ]
]

{ #category : #accessing }
PokerLogin >> playerName [
	^ playerName
]

{ #category : #accessing }
PokerLogin >> playerName: anObject [
	playerName := anObject
]

{ #category : #rendering }
PokerLogin >> renderContentOn: html [
	html
		tbsContainer: [ html heading: 'Jaguarpoker'.
			self renderLoginFormOn: html ]
]

{ #category : #rendering }
PokerLogin >> renderLoginFormOn: html [
	html
		tbsForm: [ html
				tbsFormGroup: [ html label
						for: 'playerName';
						class: 'sr-only';
						with: 'Nombre del Jugador'.
					html textInput
						tbsFormControl;
						id: 'playerName';
						on: #playerName of: self;
						placeholder: 'Tu nombre'.
					html space ].
			html
				tbsFormGroup: [ html label
						for: 'gameCode';
						class: 'sr-only';
						with: 'Código de Juego'.
					html passwordInput tbsFormControl
						id: 'gameCode';
						on: #gameCode of: self;
						placeholder: 'Código de juego'.
					html space ].
			html tbsSubmitButton
				class: 'btn btn-success btn-default';
				callback: [ self login ];
				with: 'Entrar' ]
]
