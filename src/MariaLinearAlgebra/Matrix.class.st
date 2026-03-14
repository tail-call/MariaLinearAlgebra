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

{ #category : 'initialization' }
Matrix class >> rows: r columns: c [
	| matrix |
	matrix := self new.
	matrix recreateWithRows: r columns: c.
	^ matrix.
]

{ #category : 'as yet unclassified' }
Matrix >> + aMatrix [
	| newMatrix |
	self assert: width equals: aMatrix width.
	self assert: height equals: aMatrix height.
	newMatrix := Matrix rows: height columns: width.
	1 to: height do: [ :i |
		1 to: width do: [ :j |
			newMatrix atRow: i column: j put: (
				(self atRow: i column: j)
				+
				(aMatrix atRow: i column: j) 
			)
		].
	].
	^ newMatrix
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
