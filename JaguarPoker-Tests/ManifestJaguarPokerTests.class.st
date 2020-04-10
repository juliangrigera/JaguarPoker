"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestJaguarPokerTests,
	#superclass : #PackageManifest,
	#category : #'JaguarPoker-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestJaguarPokerTests class >> ruleRBShouldntRaiseErrorRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'JaguarPoker-Tests')) #'2020-04-10T00:27:31.47059-03:00') )
]
