"
I implement a modulus operation by only using bit shifts and increments/decrements.

W.A. Susantha Wijesinghe, ""An Efficient Algorithm for Modulus Operation and Its Hardware Implementation in Prime Number Calculation"", AEU - International Journal of Electronics and Communications, Volume 191, 2025, 155657, ISSN 1434-8411, DOI: https://doi.org/10.1016/j.aeue.2024.155657

https://arxiv.org/html/2407.12541v2
"
Class {
	#name : 'AlignSubtractModulus',
	#superclass : 'Object',
	#category : 'MariaLinearAlgebra',
	#package : 'MariaLinearAlgebra'
}

{ #category : 'as yet unclassified' }
AlignSubtractModulus class >> integer: a mod: b [
	| dividend divisor shift state n |
	state := #align. "#align | #subtract"
	dividend := a.
	divisor := b.
	shift := 0.

	n := 63. "NB: SmallIntegers are 63-bit values on 64-bit machines.
	          A better approach would be to detect size of SmallInteger."
	
	[ true ]  whileTrue: [
		state = #align ifTrue: [
			(
			  (divisor <= dividend)
			  and: [
			  	(divisor bitAt: n) = 0
			    and: [shift < n]
			  ]
			) ifTrue: [
				divisor := divisor bitShift: 1.
				shift := shift + 1.
			] ifFalse: [
				state := #subtract.
			]
		].
		
		state = #subtract ifTrue: [
			(dividend >= divisor) ifTrue: [
				dividend := dividend - divisor.
			].
	    (shift = 0) ifTrue: [ ^ dividend ]. 
	    divisor := divisor bitShift: -1.
	    shift := shift - 1.
	    (shift >= n) ifTrue: [ ^ dividend ].
		].
	]
]

{ #category : 'as yet unclassified' }
AlignSubtractModulus class >> primeNumbersUpTo: a [
	"Algorithm 2 from the paper referenced in the comment."
	| n pCount sel2 |
	n := 1.
	pCount := 0.
	sel2 := false.
	^ Generator on: [ :g |
		[ n < a ] whileTrue: [
			(n = 2) ifTrue: [
				g yield: n.
				pCount := pCount + 1.
			] ifFalse: [
				| i |
				i := 3.
				[ :break |
					[ i <= n ] whileTrue: [
						(i = n) ifTrue: [
							g yield: n.
							pCount := pCount + 1.
							break value.
						] ifFalse: [
							| s |
							sel2 ifTrue: [
								s := self integer: n mod: 2.
								sel2 := true.
							] ifFalse: [
								s := self integer: n mod: i.
								(s = 0) ifTrue: [
									break value.
								].
							].
						].
						i := i + 2.
					].
				] valueWithExit.
			].
			n := n + 1.
		]
	].
	
]
