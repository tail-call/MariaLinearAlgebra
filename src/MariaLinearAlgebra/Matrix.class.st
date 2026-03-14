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

{ #category : 'initialization' }
Matrix class >> eye: size [
	| matrix |
	matrix := self new.
	matrix recreateWithRows: size columns: size.
	1 to: size do: [ :i |
		matrix atRow: i column: i put: 1
	].
	^ matrix
]

{ #category : 'as yet unclassified' }
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

{ #category : 'initialization' }
Matrix class >> rows: r columns: c [
	| matrix |
	matrix := self new.
	matrix recreateWithRows: r columns: c.
	^ matrix.
]

{ #category : 'as yet unclassified' }
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
Matrix >> + aMatrix [
	^ self collectElementWise: [ :a :b | a + b ] against: aMatrix
]

{ #category : 'as yet unclassified' }
Matrix >> - aMatrix [
	^ self collectElementWise: [ :a :b | a - b ] against: aMatrix
]

{ #category : 'accessing' }
Matrix >> atRow: i column: j [
	^ accessor atRow: i column: j
]

{ #category : 'updating' }
Matrix >> atRow: i column: j put: float [
	accessor atRow: i column: j put: float.
]

{ #category : 'as yet unclassified' }
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

{ #category : 'as yet unclassified' }
Matrix >> collect: block against: aMatrix [
]

{ #category : 'as yet unclassified' }
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

{ #category : 'as yet unclassified' }
Matrix >> height [
	^ height
]

{ #category : 'initialization' }
Matrix >> recreateWithRows: r columns: c [
	| internalArray |
	height := r.
	width := c.
	internalArray := Float32Array new: r * c.
	accessor := Lens2D
		lookingIntoFlat: internalArray
		rows: height
		columns: width.
	^ self
]

{ #category : 'as yet unclassified' }
Matrix >> rows [
	| rowItems |
	^ (1 to: height) collect: [ :i |
		rowItems := Float32Array new: width.
		1 to: width do: [ :j |
			rowItems at: j put: (self atRow: i column: j)
		].
		rowItems
	]
]

{ #category : 'as yet unclassified' }
Matrix >> swapRows: i and: j [ 
	accessor swapRows: i and: j.
]

{ #category : 'as yet unclassified' }
Matrix >> width [
	^ width
]

{ #category : 'as yet unclassified' }
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
