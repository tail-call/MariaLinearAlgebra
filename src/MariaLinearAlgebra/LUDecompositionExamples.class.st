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
