"
Simple online 5-Card Poker game
"
Class {
	#name : #ManifestJaguarPoker,
	#superclass : #PackageManifest,
	#category : #'JaguarPoker-Manifest'
}

{ #category : #'code-critics' }
ManifestJaguarPoker class >> ruleRBGuardingClauseRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#JaguarPoker)) #'2020-04-09T19:23:36.291451-03:00') )
]

{ #category : #'code-critics' }
ManifestJaguarPoker class >> ruleRBModifiesCollectionRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#JaguarPoker)) #'2020-04-30T12:40:20.580449-03:00') )
]
