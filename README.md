This package is where I teach myself:
- Smalltalk packages using the Glamorous Toolkit system
- Linear algebra and statistics (so the name of the package is misleading but we'll fix that *eventually*)

The package implements a Matrix class, a Lens2D internal storage for matrices for
fast row swaps/transpositions, and a LUDecomposition class for computing
the determinant and inverses, and for solving systems of linear equations

It also has a `NormaDistribution` class with the ability to query the probability
density function as well as sample from the distribution using the Box-Muller transform

To load this package:
1. Download a Glamorous Toolkit release from here: https://github.com/feenkcom/gtoolkit/releases
2. Open it
3. Locate the Trigram of Heaven (☰) icon in the top right and click it
4. In the menu, select the Git tool
5. In the Git tool, locate the plus (+) icon on the left panel, click it and then select "Clone a remote repository"
6. Paste the url of the repository (likely https://github.com/tail-call/MariaLinearAlgebra.git)

After the repository has been loaded, it will create the MariaLinearAlgebra package. From there, navigate to the Examples tab and try running examples

**Note on Pharo.** Pharo will also be able to load this, but examples will not work properly, they will choke on `assert:equals:` calls. Simply deleting assertions should help, I think? But this package is intended for Glamorous Toolkit