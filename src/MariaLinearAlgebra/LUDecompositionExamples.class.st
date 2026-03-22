Class {
	#name : 'LUDecompositionExamples',
	#superclass : 'Object',
	#category : 'MariaLinearAlgebra',
	#package : 'MariaLinearAlgebra'
}

{ #category : 'as yet unclassified' }
LUDecompositionExamples >> decompositionExample [
	<gtExample>
	| a decomp zeroes |
	a := Matrix
		fromArrays:
			#(#(-2  3 -1)
			  #( 5 -1  4)
			  #( 4 -8  2)).
	decomp := LUDecomposition decompose: a.

	"PA = LU"
	zeroes := (
		(decomp permutationMatrix) * a)
		- ((decomp lower) * (decomp upper)
	).
	"Therefore PA - LU = matrix of zeroes (or very small values)"
	zeroes withIndexDo: [ :each :i :j |
		self assert: each abs < 1e-7.
	].
	^ zeroes
]

{ #category : 'as yet unclassified' }
LUDecompositionExamples >> solveLinearSystemExample [
	<gtExample>
	| cases |
	cases := Dictionary new.
	cases
		at: #(#(-1 5)
				  #( 2 5))
		put: #(4 -2) ;
		at: #(#( 1  2 -1)
				  #( 3  5 -1)
				  #(-2 -1 -2))
		put: #(6 2 4) ;
		at: #(#(1  1  1)
				  #(2 -5  0)
				  #(0  5 -1))
		put: #(0 6 -3) .
	
	cases keysAndValuesDo: [ :arrays :expected |
		| solution error matrix |
		matrix := Matrix fromArrays: arrays.
		solution := Matrix columnVector: (
			(LUDecomposition decompose: matrix) solveFor: expected
		).
		error := (matrix * solution) - (Matrix columnVector: expected).
		error withIndexDo: [ :each :i :j |
			self assert: each abs < 1e-6
		].
	
		cases at: arrays put: solution.
	].
	^ cases
]
