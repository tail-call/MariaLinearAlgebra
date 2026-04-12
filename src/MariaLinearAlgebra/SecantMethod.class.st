Class {
	#name : 'SecantMethod',
	#superclass : 'Object',
	#instVars : [
		'x0',
		'x1',
		'block'
	],
	#category : 'MariaLinearAlgebra',
	#package : 'MariaLinearAlgebra'
}

{ #category : 'accessing' }
SecantMethod class >> forBlock: aBlock x0: x0 x1: x1 [
	| instance |
	instance := self new.
	instance setBlock: aBlock; setX0: x0; setX1: x1.
	^ instance
	
]

{ #category : 'accessing' }
SecantMethod class >> solveFor: der x0: x0 x1: x1 [
	| eps x2 |
	eps := 1e-6.
	x2 := x1 - (
		((der value: x1) * (x1 - x0))
		/
		((der value: x1) - (der value: x0))
	)
]

{ #category : 'as yet unclassified' }
SecantMethod >> printString [
	^ 'SecantMethod forBlock: ' , block printString , ' x0: ' , x0 printString, ' x1: ', x1 printString
]

{ #category : 'as yet unclassified' }
SecantMethod >> setBlock: aBlock [
	block := aBlock.
]

{ #category : 'as yet unclassified' }
SecantMethod >> setX0: aNumber [
	x0 := aNumber.
]

{ #category : 'as yet unclassified' }
SecantMethod >> setX1: aNumber [
	x1 := aNumber.
]

{ #category : 'as yet unclassified' }
SecantMethod >> solution [
	^ x1
]

{ #category : 'accessing' }
SecantMethod >> step [
	| x2 |
	x0 = x1 ifTrue: [
		^ self
	].
	x2 := x1 - (
		((block value: x1) * (x1 - x0))
		/
		((block value: x1) - (block value: x0))
	).
	x0 := x1.
	x1 := x2.
	^ self
]
