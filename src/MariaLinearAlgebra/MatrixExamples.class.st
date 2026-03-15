Class {
	#name : 'MatrixExamples',
	#superclass : 'Object',
	#category : 'MariaLinearAlgebra',
	#package : 'MariaLinearAlgebra'
}

{ #category : 'as yet unclassified' }
MatrixExamples >> additionExample [
	<gtExample>
	| a b c |
	a := Matrix
		fromArrays:
			#(#(1 2 3)
		    #(4 5 6)).
	b := Matrix
		fromArrays:
			#(#(9 8 7)
		  	#(6 5 4)).

	c := a + b.
	
	c withIndexDo: [ :each :i :j |
		self assert: each equals: 10.0
	].

	^ c
]

{ #category : 'as yet unclassified' }
MatrixExamples >> determinantExample [
	<gtExample>
	| cases |
	
	cases := Dictionary new.
	cases
		at: #(#(-2  3 -1)
		      #( 5 -1  4)
		      #( 4 -8  2))
		put: -6 ;
		at: #(#(4 1)
		      #(2 3))
		put: 10 .
	
	cases keysAndValuesDo: [ :arrays :expected |
		| det error matrix |
		matrix := Matrix fromArrays: arrays.
		det := matrix determinant.
		error := det - expected.
		self assert: error abs < 1e-6.
		cases at: arrays put: det.
	].
	
	^ cases
]

{ #category : 'as yet unclassified' }
MatrixExamples >> eyeExample [
	<gtExample>
	| eyeMatrix |
	eyeMatrix := Matrix eye: 3.
	
	eyeMatrix withIndexDo: [ :each :i :j |
		i = j ifTrue: [
			self assert: each equals: 1.0.
		] ifFalse: [
			self assert: each equals: 0.0.
		]
	].

	^ eyeMatrix
]

{ #category : 'as yet unclassified' }
MatrixExamples >> inverseExample [
	<gtExample>
	| a ia |
	a := Matrix
		fromArrays:
			#(#( 4  7  8 13)
			  #( 2 11 12  9)
			  #(10  5  6 14)
			  #(15 16 17 18)).

	ia := a inverse.

	"Inverse of inverse is the same matrix"
	(ia inverse - a)
		withIndexDo: [ :each :i :j |
			self assert: each abs < 1e-5.
		].
	
	^ ia
]

{ #category : 'as yet unclassified' }
MatrixExamples >> multiplicationExample [
	<gtExample>
	| a b expected result |

	a := Matrix
		fromArrays:
			#(#(6 4)
			  #(0 7)
			  #(5 1)).

	b := Matrix
		fromArrays:
			#(#(6 4 8)
			  #(2 7 9)).

	expected := Matrix
		fromArrays:
			#(#(44 52 84)
			  #(14 49 63)
			  #(32 27 49)).

	result := a * b.

	self assert: (result equals: expected).
	
	^ result

]

{ #category : 'as yet unclassified' }
MatrixExamples >> transposeExample [
	<gtExample>
	| a at |
	a := Matrix
		fromArrays:
			#(#(6 4)
			  #(0 7)
			  #(5 1)).

	at := Matrix
		fromArrays:
			#(#(6 0 5)
				#(4 7 1)).
	
	self assert: (at equals: a transposed).
	^ a transposed.
]
