"
Simple online 5-Card Poker game
Tests
"
Class {
	#name : #ManifestJaguarPokerTests,
	#superclass : #PackageManifest,
	#category : #'JaguarPoker-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestJaguarPokerTests class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'JaguarPoker-Tests')) #'2020-04-10T11:42:21.775548-03:00') )
]

{ #category : #'code-critics' }
ManifestJaguarPokerTests class >> ruleRBShouldntRaiseErrorRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'JaguarPoker-Tests')) #'2020-04-10T00:27:31.47059-03:00') )
]
