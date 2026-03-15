"
I am a LU-decomposition of a matrix. Largely taken from here: https://en.wikipedia.org/wiki/LU_decomposition#C_code_example
"
Class {
	#name : 'LUDecomposition',
	#superclass : 'Object',
	#instVars : [
		'lmepu',
		'permutation',
		'swaps'
	],
	#category : 'MariaLinearAlgebra',
	#package : 'MariaLinearAlgebra'
}

{ #category : 'as yet unclassified' }
LUDecomposition class >> decompose: aMatrix [
	"lmepu contains a copy of both matrices L-E and U as A=(L-E)+U such that P*A=L*U."
	
	"The permutation matrix is not stored as a matrix, but in an integer vector P of size N  containing column indexes where the permutation matrix has 1."
	
	"The `swaps` variable (S) is the number of row exchanges needed for determinant computation, det(P)=(-1)^S"
			 
	| lmepu n tol p swaps |
	lmepu := aMatrix materialize.
	n := lmepu width.
	
	tol := 0.01.
	
	p := (1 to: n) collect: [ :i | i ].
	swaps := 0.
	
	1 to: n do: [ :i |
		| maxA imax |
		maxA := 0.0.
		imax := i.
		
		i to: n do: [ :k |
			| absA |
			absA := (lmepu atRow: k column: i) abs.
			(absA > maxA) ifTrue: [
				maxA := absA.
				imax := k.
			]
		].
		
		(maxA < tol) ifTrue: [
			self error: 'matrix is degenerate'
		].
		
		(imax ~= i) ifTrue: [
			| j |
			"pivoting P"
			j := p at: i.
			p at: i put: (p at: imax).
			p at: imax put: j.
			
			"pivoting rows of A"
			lmepu swapRows: i and: imax.
			
			"counting pivots for determinant"
			swaps := swaps + 1.
		].
	
		(i + 1) to: n do: [ :j |
			lmepu atRow: j column: i put: (
				(lmepu atRow: j column: i) / (lmepu atRow: i column: i)
			).
			
			(i + 1) to: n do: [ :k |
				lmepu atRow: j column: k put: (
					(lmepu atRow: j column: k) - (
						(lmepu atRow: j column: i)
						*
						(lmepu atRow: i column: k)
					)
				).
			].
		].
	].
	
	^ self new setLmepu: lmepu permutation: p swaps: swaps.
]

{ #category : 'as yet unclassified' }
LUDecomposition >> determinant [
	| det sign |
	"Computes the determinant of the matrix that was LU decomposed"
	
	det := lmepu atRow: 1 column: 1.
	
	2 to: lmepu width do: [ :i |
		det := det * (lmepu atRow: i column: i).
	].
	
	sign := swaps % 2.
	^ sign = 0 ifTrue: [ det ] ifFalse: [ det negated ].
]

{ #category : 'as yet unclassified' }
LUDecomposition >> lower [
	| matrix size |
	size := lmepu height.
	matrix := Matrix rows: size columns: size.
	2 to: size do: [ :i |
		1 to: i - 1 do: [ :j |
			matrix atRow: i column: j put: (lmepu atRow: i column: j)
		].
	].
	^ matrix + (Matrix eye: size)
]

{ #category : 'as yet unclassified' }
LUDecomposition >> permutationMatrix [
	| matrix size |
	size := lmepu height.
	matrix := Matrix rows: size columns: size.
	1 to: size do: [ :i |
		matrix atRow: i column: (permutation at: i) put: 1
	].
	^ matrix
]

{ #category : 'as yet unclassified' }
LUDecomposition >> setLmepu: newLmepu permutation: newPermutation [
	lmepu := newLmepu.
	permutation := newPermutation.
	^ self
]

{ #category : 'as yet unclassified' }
LUDecomposition >> setLmepu: newLmepu permutation: newPermutation swaps: newSwaps [
	lmepu := newLmepu.
	permutation := newPermutation.
	swaps := newSwaps.
	^ self
]

{ #category : 'as yet unclassified' }
LUDecomposition >> upper [
	| matrix size |
	size := lmepu height.
	matrix := Matrix rows: size columns: size.
	1 to: size do: [ :i |
		i to: size do: [ :j |
			matrix atRow: i column: j put: (lmepu atRow: i column: j)
		].
	].
	^ matrix.
]
