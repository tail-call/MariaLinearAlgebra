Class {
	#name : 'NumericalDerivative',
	#superclass : 'Object',
	#instVars : [
		'block',
		'step'
	],
	#category : 'MariaLinearAlgebra',
	#package : 'MariaLinearAlgebra'
}

{ #category : 'accessing' }
NumericalDerivative class >> ofBlock: aBlock [
	| derivative |
	derivative := self new.
	derivative setBlock: aBlock.
	^ derivative
]

{ #category : 'as yet unclassified' }
NumericalDerivative >> derivated [
	^ NumericalDerivative ofBlock: self.
]

{ #category : 'as yet unclassified' }
NumericalDerivative >> initialize [
	step := 1e-8.
]

{ #category : 'accessing' }
NumericalDerivative >> setBlock: newBlock [
	block := newBlock.
]

{ #category : 'as yet unclassified' }
NumericalDerivative >> value: aNumber [
	"Use Richardson extrapolation to compute derivative"
	| step1 step2 halfstep |
	halfstep := step / 2.0. "Ensure we are using floats"
	
	"Central difference: (f(x+h) - f(x-h)) / 2h"
	step1 := ((block value: aNumber + step) - (block value: aNumber - step)) / (2.0 * step).
	
	"Central difference with half step: (f(x+h/2) - f(x-h/2)) / h"
	step2 := ((block value: aNumber + halfstep) - (block value: aNumber - halfstep)) / step.
	
	^ (4.0 * step2 - step1) / 3.0
]
