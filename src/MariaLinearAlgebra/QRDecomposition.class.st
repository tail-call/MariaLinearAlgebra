Class {
	#name : 'QRDecomposition',
	#superclass : 'Object',
	#instVars : [
		'orthogonalBasis',
		'originalMatrix'
	],
	#category : 'MariaLinearAlgebra',
	#package : 'MariaLinearAlgebra'
}

{ #category : 'as yet unclassified' }
QRDecomposition class >> decompose: aMatrix [
	| decomposition es columns |
	decomposition := self new.
	columns := aMatrix columns.
	
	es := Array new: columns size.

	1 to: columns size do: [ :i |
		| col u e |
		col := columns at: i.
	
		u := col.
		1 to: (i - 1) do: [ :ei |
			e := es at: ei.
			u := u - (e *@ (col *! e)).
		].
	
		e := u /@ u spectralNorm.
		es at: i put: e.
	].
	
	decomposition
		setOriginalMatrix: aMatrix;
		setOrthogonalBasis: es.
	
	^ decomposition
]

{ #category : 'as yet unclassified' }
QRDecomposition >> orthogonalBasis [
	^ orthogonalBasis
]

{ #category : 'as yet unclassified' }
QRDecomposition >> q [
	^ Matrix fromColumnVectors: orthogonalBasis.
]

{ #category : 'accessing' }
QRDecomposition >> r [
	| columns size rMatrix |
	columns := originalMatrix columns.
	size := columns size.
	
	rMatrix := Matrix rows: size columns: size.
	
	1 to: size do: [ :i |
		i to: size do: [ :j |
			rMatrix atRow: i column: j put: (
				(columns at: j) *! (orthogonalBasis at: i)
			)
		].
	].
	
	^ rMatrix
]

{ #category : 'as yet unclassified' }
QRDecomposition >> setOriginalMatrix: aMatrix [
	originalMatrix := aMatrix.
]

{ #category : 'as yet unclassified' }
QRDecomposition >> setOrthogonalBasis: anArray [
	orthogonalBasis := anArray.
]
