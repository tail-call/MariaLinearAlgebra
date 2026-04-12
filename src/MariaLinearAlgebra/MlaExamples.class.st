"
I hold examples for every class that would have too few examples to warrant its own examples class. It's kind of lazy, I know.
"
Class {
	#name : 'MlaExamples',
	#superclass : 'Object',
	#category : 'MariaLinearAlgebra',
	#package : 'MariaLinearAlgebra'
}

{ #category : 'as yet unclassified' }
MlaExamples >> decompositionExample [
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
MlaExamples >> normalDistributionExample [
	<gtExample>
	"XXX: This better be a live view of normal distribution"
	| nd values data lineChart |
	nd := NormalDistribution withMean: 0 standardDeviation: 1.
	values := (-300 to: 300) collect: [ :i |
		| x |
		x := (i / 100).
		x -> (nd probabilityDensity: x).
	].
	
	"I know you shouldn't test floats for strict
	 equality, but I'm so curious"
	self assert: (nd probabilityDensity: 0)
	     equals: 0.3989422804014327.
	self assert: (nd probabilityDensity: 1)
	     equals: 0.24197072451914337.
	
	data := GtPlotterDataGroup new
		values: values;
		background: Color purple.

	lineChart := GtPlotterLineChart new
		with: data;
		labelFormatX: #asString; "if we don't do this, things go awry"
		labelFormatY: #asString;
		valueX: #key;
		valueY: #value.
	
	^ nd -> lineChart
]

{ #category : 'as yet unclassified' }
MlaExamples >> solveLinearSystemExample [
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
