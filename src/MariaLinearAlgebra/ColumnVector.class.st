Class {
	#name : 'ColumnVector',
	#superclass : 'Matrix',
	#category : 'MariaLinearAlgebra',
	#package : 'MariaLinearAlgebra'
}

{ #category : 'accessing' }
ColumnVector class >> fromArray: anArray [
	^ self fromArrays: (anArray collect: [ :each | { each } ])
]

{ #category : 'as yet unclassified' }
ColumnVector class >> rows: h [
	^ self rows: h columns: 1
]

{ #category : 'as yet unclassified' }
ColumnVector >> *! aColumnVector [
	"Scalar product of two column vectors"
	^ ((self transposed * aColumnVector) atRow: 1 column: 1)
]

{ #category : 'as yet unclassified' }
ColumnVector >> columns [
	"Specialization of Matrix's columns"
	^ { self }
]

{ #category : 'as yet unclassified' }
ColumnVector >> spectralNorm [
	^ ((1 to: height) inject: 0 into: [ :acc :j |
		(self atRow: j column: 1) ** 2 + acc
	]) sqrt
	
]
