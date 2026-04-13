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
ColumnVector >> spectralNorm [
	^ ((1 to: height) inject: 0 into: [ :acc :i |
		(self atRow: i column: 1) ** 2 + acc
	]) sqrt
	
]
