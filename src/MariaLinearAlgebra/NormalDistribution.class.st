Class {
	#name : 'NormalDistribution',
	#superclass : 'Object',
	#instVars : [
		'mean',
		'dispersion',
		'rng'
	],
	#category : 'MariaLinearAlgebra',
	#package : 'MariaLinearAlgebra'
}

{ #category : 'as yet unclassified' }
NormalDistribution class >> withMean: m dispersion: d [
	^ (self new) mean: m dispersion: d.
]

{ #category : 'as yet unclassified' }
NormalDistribution >> initialize [
	rng := Random new.
]

{ #category : 'as yet unclassified' }
NormalDistribution >> mean: m dispersion: d [
	mean := m.
	dispersion := d.
	^ self
]

{ #category : 'as yet unclassified' }
NormalDistribution >> sampleTwo [
	| u1  u2 mag z0 z1 |
	u1 := rng next.
	u2 := rng next.
	mag := dispersion * (-2.0 * u1 log) sqrt.
	z0 := mag * (2 * Float pi * u2) cos + mean.
	z1 := mag * (2 * Float pi * u2) sin + mean.
	^ z0 -> z1
]
