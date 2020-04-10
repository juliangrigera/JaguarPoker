"
I display the ""waiting for other players"" screen
"
Class {
	#name : #PokerWaitingRoomView,
	#superclass : #WAComponent,
	#instVars : [
		'game'
	],
	#category : #'JaguarPoker-Web'
}

{ #category : #'instance creation' }
PokerWaitingRoomView class >> game: aPokerGame [
	^ self new
		game: aPokerGame;
		yourself
]

{ #category : #controlling }
PokerWaitingRoomView >> attemptToStart [
	self answer
]

{ #category : #accessing }
PokerWaitingRoomView >> game [
	^ game
]

{ #category : #accessing }
PokerWaitingRoomView >> game: anObject [
	game := anObject
]

{ #category : #rendering }
PokerWaitingRoomView >> renderContentOn: html [
	html
		tbsContainer: [ html heading: 'Poker für Alles'.
			html heading level3 with: 'Esperando juntar 4'.
			html heading level4 with: 'Hasta ahora tenemos a:'.
			self game players
				do: [ :player | 
					html
						paragraph: [ html text: player name.
							player = self session player
								ifTrue: [ html text: ' << este sos vos.' ] ] ].
			html anchor
				class: 'btn btn-large btn-success';
				callback: [ self attemptToStart ];
				with: 'Empezar' ]
]
