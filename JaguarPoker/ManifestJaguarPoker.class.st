"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
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
