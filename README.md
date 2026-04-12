<img width="1484" height="846" alt="A screenshot of a plot of normal distribution" src="https://github.com/user-attachments/assets/aae4f6a0-3e7c-4fe3-b630-8ff72ff34e60" />

# MLAlgebra

This package is where I teach myself:
- Smalltalk packages using the Glamorous Toolkit system
- Linear algebra, calculus, and statistics (so the name of the package is misleading but we'll fix that *eventually*)

Below is the description of what's inside
## Linear Algebra

`Matrix` class, a `Lens2D` internal storage for matrices for fast row swaps/transpositions, and a `LUDecomposition` class for computing
the determinants and inverses, and for solving systems of linear equations
## NormalDistribution
- Query the probability density function
- Sample from the distribution using the Box-Muller transform
- Estimate log-likelihood of a sample
## Optimization

These allow you to perform very basic maximum likelihood estimation:

- `NumericalDerivative`: uses Richardson extrapolation for, um, increased accuracy
- `SecantMethod`: finds roots of a function. When applied on `NumericalDerivative`, can be used for optimization
## Loading the package

1. Download a Glamorous Toolkit release from here: https://github.com/feenkcom/gtoolkit/releases
2. Open it
3. Locate the Trigram of Heaven (☰) icon in the top right and click it
4. In the menu, select the Git tool
5. In the Git tool, locate the plus (+) icon on the left panel, click it and then select "Clone a remote repository"
6. Paste the url of the repository (likely https://github.com/tail-call/MariaLinearAlgebra.git)

After the repository has been loaded, it will create the MariaLinearAlgebra package. From there, navigate to the Examples tab and try running examples
## Note on Pharo
Pharo will also be able to load this, but examples will not work properly, they will choke on `assert:equals:` calls. Simply deleting assertions should help, I think? But this package is intended for Glamorous Toolkit
