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
