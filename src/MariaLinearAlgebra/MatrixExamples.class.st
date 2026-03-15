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
