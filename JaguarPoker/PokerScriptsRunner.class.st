Class {
	#name : #PokerScriptsRunner,
	#superclass : #Object,
	#category : #'JaguarPoker-Utils'
}

{ #category : #api }
PokerScriptsRunner >> deploymentPort [
	^ 8099
]

{ #category : #api }
PokerScriptsRunner >> prepareForDeployment [
	self
		removeDevelopmentTools;
		setDeploymentUrl;
		setupServer
]

{ #category : #api }
PokerScriptsRunner >> removeDevelopmentToolbar [
	#(poker)
		do: [ :applicationName | 
			| configuration |
			configuration := (WADispatcher default handlerAt: applicationName) configuration.
			configuration
				takeValue: {}
				forAttribute: (configuration attributeAt: #rootDecorationClasses) ]
]

{ #category : #api }
PokerScriptsRunner >> removeDevelopmentTools [
	self
		unregisterDevelopmentApplications;
		removeDevelopmentToolbar;
		turnOffDebugging
]

{ #category : #initialization }
PokerScriptsRunner >> setDeploymentUrl [
	(WAAdmin defaultDispatcher handlerAt: #poker)
		preferenceAt: #resourceBaseUrl
		put: 'http://jaguarpoker.tk'
]

{ #category : #api }
PokerScriptsRunner >> setupServer [
	ZnZincServerAdaptor
		stop;
		startOn: self deploymentPort
]

{ #category : #api }
PokerScriptsRunner >> startServer [
	ZnZincServerAdaptor startOn: 8080
]

{ #category : #api }
PokerScriptsRunner >> turnOffDebugging [
	(WAAdmin defaultDispatcher handlerAt: #poker)
		exceptionHandler: WAHtmlErrorHandler
]

{ #category : #api }
PokerScriptsRunner >> unregisterDevelopmentApplications [
	| requiredHandlersNames allHandlers |
	allHandlers := WADispatcher default handlers.
	requiredHandlersNames := #('files' 'poker').
	allHandlers
		keysAndValuesDo: [ :handlerName :handler | 
			(requiredHandlersNames includes: handlerName)
				ifFalse: [ WADispatcher default unregister: handler ] ]
]
