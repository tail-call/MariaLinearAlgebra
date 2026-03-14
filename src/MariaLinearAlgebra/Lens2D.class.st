Class {
	#name : 'Lens2D',
	#superclass : 'Object',
	#instVars : [
		'rowsRange',
		'columnsRange',
		'readBlock',
		'writeBlock'
	],
	#category : 'MariaLinearAlgebra',
	#package : 'MariaLinearAlgebra'
}

{ #category : 'as yet unclassified' }
Lens2D class >> lookingIntoFlat: flatCollection rows: rows columns: columns [
	^ self
		new
		setRowsRange: (1 to: rows)
		columnsRange: (1 to: columns)
		readBlock: [ :i :j |
			flatCollection
				at: (i - 1) * columns + j
		]
		writeBlock: [ :i :j :value |
			flatCollection
				at: (i - 1) * columns + j
				put: value
		]
]

{ #category : 'as yet unclassified' }
Lens2D >> atRow: i column: j [
	self validateRow: i column: j.
	^ readBlock value: i value: j.
]

{ #category : 'as yet unclassified' }
Lens2D >> atRow: i column: j put: value [
	self validateRow: i column: j.
	writeBlock value: i value: j value: value.
]

{ #category : 'as yet unclassified' }
Lens2D >> setRowsRange: rRange columnsRange: cRange readBlock: rBlock writeBlock: wBlock [
	rowsRange := rRange.
	columnsRange := cRange.
	readBlock := rBlock.
	writeBlock := wBlock.
	^ self
]

{ #category : 'as yet unclassified' }
Lens2D >> validateRow: i column: j [
	i > (rowsRange stop) ifTrue: [
		self error: 'i is too big'
	].
	j > (columnsRange stop) ifTrue: [
		self error: 'j is too big'
	].
	i < (rowsRange first) ifTrue: [
		self error: 'i is too small'
	].
	j < (columnsRange first) ifTrue: [
		self error: 'j is too small'
	].
]
