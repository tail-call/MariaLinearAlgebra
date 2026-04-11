Class {
	#name : 'NormalDistribution',
	#superclass : 'Object',
	#instVars : [
		'mean',
		'rng',
		'standardDeviation'
	],
	#category : 'MariaLinearAlgebra',
	#package : 'MariaLinearAlgebra'
}

{ #category : 'as yet unclassified' }
NormalDistribution class >> withMean: m standardDeviation: d [
	^ (self new) mean: m standardDeviation: d.
]

{ #category : 'as yet unclassified' }
NormalDistribution >> initialize [
	rng := Random new.
]

{ #category : 'as yet unclassified' }
NormalDistribution >> mean: m standardDeviation: d [
	mean := m.
	standardDeviation := d.
	^ self
]

{ #category : 'as yet unclassified' }
NormalDistribution >> probabilityDensity: x [
	^ (1 / (standardDeviation * (2 * Float pi) sqrt))
		*
		((-1/2*(((x - mean)/standardDeviation)**2)) exp)
]

{ #category : 'as yet unclassified' }
NormalDistribution >> sampleTwo [
	"Box-Muller transform."
	| u1  u2 mag z0 z1 |
	u1 := rng next.
	u2 := rng next.
	mag := standardDeviation * (-2.0 * u1 log) sqrt.
	z0 := mag * (2 * Float pi * u2) cos + mean.
	z1 := mag * (2 * Float pi * u2) sin + mean.
	^ z0 -> z1
]
