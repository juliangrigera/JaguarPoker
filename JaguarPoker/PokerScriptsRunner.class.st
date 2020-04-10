Class {
	#name : #PokerScriptsRunner,
	#superclass : #Object,
	#category : #'JaguarPoker-Utils'
}

{ #category : #api }
PokerScriptsRunner >> startServer [
	ZnZincServerAdaptor startOn: 8080
]
