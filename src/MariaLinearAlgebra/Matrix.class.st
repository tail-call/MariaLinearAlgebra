"
I am a linear homomorphism of vector spaces.
"
Class {
	#name : 'Matrix',
	#superclass : 'Object',
	#instVars : [
		'accessor',
		'width',
		'height'
	],
	#category : 'MariaLinearAlgebra',
	#package : 'MariaLinearAlgebra'
}

{ #category : 'as yet unclassified' }
Matrix class >> columnVector: items [
	| height matrix |
	height := items size.
	matrix := self rows: height columns: 1.
	items withIndexDo: [ :each :i |
		matrix atRow: i column: 1 put: each
	].
	^ matrix
]

{ #category : 'initialization' }
Matrix class >> eye: size [
	"Creates a unit matrix, that is, a square matrix that has ones on the main diagonal and zeroes everywhere else. Multiplying any matrix M by a unit matrix gives you a matrix that is equal to M, so a unit matrix acts like a 1 in multiplication. As for the name of the method (eye:), it's been lifted from NumPy library where it does the same thing. But why 'eye'? Likely because the standard notations for unit matrices (E or I), respectively, 1) resemble the first letter of Eye; 2) read the same as 'eye' (conf. eye and I). Or because a unit matrix resembles a snake eye."
	| matrix |
	matrix := self new.
	matrix recreateWithRows: size columns: size.
	1 to: size do: [ :i |
		matrix atRow: i column: i put: 1
	].
	^ matrix
]

{ #category : 'initialization' }
Matrix class >> fromArrays: rowsArray [
	| height width newMatrix |
	self assert: rowsArray isNotEmpty.
	
	height := rowsArray size.
	width := rowsArray first size.
	newMatrix := self rows: height columns: width.
	
	1 to: height do: [ :i |
		| row |
		row := rowsArray at: i.
		
		"All rows must be of same width."
		self assert: row size = width.
		
		1 to: width do: [ :j |
			newMatrix atRow: i column: j put: (row at: j)
		].
	].
	
	^ newMatrix
]

{ #category : 'as yet unclassified' }
Matrix class >> fromColumnVectors: anArray [
	| newMatrix height width aVector |
	height := anArray first height.
	width := anArray size.

	self assert: (
		anArray allSatisfy: [ :aVector |
			(aVector width = 1) and: [ aVector height = height ]
		]
	).

	newMatrix := self rows: height columns: width.
	
	1 to: width do: [ :j |
		aVector := anArray at: j.
		1 to: height do: [ :i |
			newMatrix atRow: i column: j put: (
				aVector atRow: i column: 1
			)
		].
	].

	^ newMatrix
]

{ #category : 'initialization' }
Matrix class >> rows: r columns: c [
	| matrix |
	c = 1 ifTrue: [
		matrix := ColumnVector new.
	] ifFalse: [
		matrix := self new.
	].
	matrix recreateWithRows: r columns: c.
	^ matrix.
]

{ #category : 'operators' }
Matrix >> * aMatrix [ 
	| newMatrix newWidth newHeight |

	self assert: width equals: aMatrix height.
	
	newWidth := aMatrix width.
	newHeight := height.
	newMatrix := Matrix
		rows: newHeight
		columns: newWidth.

	1 to: newHeight do: [ :newI |
		1 to: newWidth do: [ :newJ |
			| cellValue |
			cellValue := 0.
			
			"Compute cell value as a linear combination"
			1 to: width do: [ :j |
				cellValue := cellValue + ((
					self atRow: newI column: j
				) * (
					aMatrix atRow: j column: newJ
				)).
			].
			
			newMatrix atRow: newI column: newJ put: cellValue.
		].
	].
	^ newMatrix
]

{ #category : 'as yet unclassified' }
Matrix >> *@ aNumber [
	"Multiply by a scalar"
	^ self collect: [ :x | x * aNumber ]
]

{ #category : 'operators' }
Matrix >> + aMatrix [
	^ self collectElementWise: [ :a :b | a + b ] against: aMatrix
]

{ #category : 'operators' }
Matrix >> - aMatrix [
	^ self collectElementWise: [ :a :b | a - b ] against: aMatrix
]

{ #category : 'as yet unclassified' }
Matrix >> /@ aNumber [
	"Divide by a scalar"
	^ self collect: [ :x | x / aNumber ]
]

{ #category : 'accessing' }
Matrix >> atRow: i column: j [
	^ accessor atRow: i column: j
]

{ #category : 'as yet unclassified' }
Matrix >> atRow: i column: j decreaseBy: dx [
	self atRow: i column: j updateBy: [ :x |
		x - dx
	].
]

{ #category : 'as yet unclassified' }
Matrix >> atRow: i column: j divideBy: factor [
	self atRow: i column: j updateBy: [ :x |
		x / factor
	].
]

{ #category : 'updating' }
Matrix >> atRow: i column: j put: float [
	accessor atRow: i column: j put: float.
]

{ #category : 'updating' }
Matrix >> atRow: i column: j updateBy: block [
	| currentValue |
	currentValue := self atRow: i column: j.
	self atRow: i column: j put: (
		block value: currentValue
	).
	
]

{ #category : 'mapping' }
Matrix >> collect: block [
	| newMatrix value |
	newMatrix := Matrix rows: height columns: width.
	newMatrix withIndexDo: [:each :i :j |
		value := block value: (self atRow: i column: j).
		newMatrix
			atRow: i
			column: j
			put: value.
	].
	^ newMatrix.
]

{ #category : 'mapping' }
Matrix >> collect: block against: aMatrix [
]

{ #category : 'mapping' }
Matrix >> collectElementWise: block against: aMatrix [
	| newMatrix |
	self assert: width equals: aMatrix width.
	self assert: height equals: aMatrix height.
	newMatrix := Matrix rows: height columns: width.
	1 to: height do: [ :i |
		1 to: width do: [ :j |
			newMatrix atRow: i column: j put: (
				block
					value: (self atRow: i column: j)
					value: (aMatrix atRow: i column: j)
			)
		].
	].
	^ newMatrix
]

{ #category : 'accessing' }
Matrix >> columns [
	^ (1 to: width) collect: [ :i |
		| aVector |
		aVector := ColumnVector rows: height.
		1 to: height do: [ :j |
			aVector atRow: j column: 1 put: (
				self atRow: j column: i
			)
		].
		aVector
	]
		
]

{ #category : 'as yet unclassified' }
Matrix >> determinant [
	(width = 2 and: [ height = 2 ]) ifTrue: [
		^ (
			(self atRow: 1 column:1) * (self atRow: 2 column:2)
		) - (
			(self atRow: 1 column:2) * (self atRow: 2 column:1)
		)
	].
	^ (LUDecomposition decompose: self) determinant
]

{ #category : 'accessing' }
Matrix >> eigenvalues [
	(width = 2 and: [ height = 2 ]) ifTrue: [
		| tr det drt |
		tr := self matrixTrace.
		det := self determinant.
		drt := (tr ** 2 - (4 * det)) sqrt.
		^ { (tr + drt) / 2 . (tr - drt) / 2 }
	] ifFalse: [
		NotYetImplemented signal: 'Eigenvalues for matrices larger than 2x2 cannot be computed yet'
	]
]

{ #category : 'as yet unclassified' }
Matrix >> equals: aMatrix [
	self withIndexDo: [ :each :i :j |
		(
			self atRow: i column: j
		) = (
			aMatrix atRow: i column: j
		) ifFalse: [
			^ false
		]
	].
	^ true
	
]

{ #category : 'as yet unclassified' }
Matrix >> gtItemsFor: aView [
	<gtView>
	| list |
	list := aView columnedList.
	list
		title: 'Items';
		priority: 50;
		items: [ self rows ].
	1 to: width do: [ :j |
		list
			column: 'X'
			text: [ :eachItem :eachIndex |
				(eachItem at: j)
					asRopedText
					foreground: Color gray
			]
			width: 45.
	].
	"TODO updateWhen: MatrixItemUpdated in: self announcer"
	^ list
]

{ #category : 'accessing' }
Matrix >> height [
	^ height
]

{ #category : 'as yet unclassified' }
Matrix >> inverse [
	^ (LUDecomposition decompose: self) inverse.
]

{ #category : 'copying' }
Matrix >> materialize [
	"Recreates a copy of matrix with different storage. Used to decouple values of matrix if its contents are to be shared."
	| newMatrix |
	newMatrix := Matrix rows: height columns: width.
	self withIndexDo: [ :each :i :j |
		newMatrix atRow: i column: j put: each
	].
	^ newMatrix
]

{ #category : 'accessing' }
Matrix >> matrixTrace [
	"Note that #trace method is doing something else so we do not override it"
	self assert: width equals: height.
	^ (1 to: width) inject: 0 into: [ :acc :each |
		acc + (self atRow: each column: each)
	]
]

{ #category : 'initialization' }
Matrix >> recreateWithRows: r columns: c [
	| internalArray |
	height := r.
	width := c.
	internalArray := Float64Array new: r * c.
	accessor := Lens2D
		lookingIntoFlat: internalArray
		rows: height
		columns: width.
	^ self
]

{ #category : 'accessing' }
Matrix >> rows [
	"XXX Would be cool if this returned an array of RowVectors
	 but we don't have them yet"
	^ (1 to: height) collect: [ :i |
		| rowItems |
		rowItems := Float32Array new: width.
		1 to: width do: [ :j |
			rowItems at: j put: (self atRow: i column: j)
		].
		rowItems
	]
]

{ #category : 'updating' }
Matrix >> swapRows: i and: j [ 
	accessor swapRows: i and: j.
]

{ #category : 'as yet unclassified' }
Matrix >> transpose [
	| tmp |
	accessor transpose.
	tmp := width.
	width := height.
	height := tmp.
]

{ #category : 'as yet unclassified' }
Matrix >> transposed [
	| newMatrix |
	newMatrix := self materialize.
	newMatrix transpose.
	^ newMatrix
]

{ #category : 'accessing' }
Matrix >> width [
	^ width
]

{ #category : 'iterating' }
Matrix >> withIndexDo: elementAndIndicesBlock [
	| each |
	1 to: height do: [ :i |
		1 to: width do: [ :j |
			each := self atRow: i column: j.
			elementAndIndicesBlock
				value: each
				value: i
				value: j.
		]
	].
]
