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
AlignSubtractModulus class >> a: a b: b [
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
			divisor := divisor bitShift: -1.
			shift := shift - 1.
			((dividend < divisor) or: [shift = 0 or: [shift >= n]]) ifTrue: [
				^ dividend
			].
		].
	]
]
