from grids import Domain, Grid
from poisson import MultiGridSolver
import numpy as np

def g(x, y, z):
    """ Some example function used here to produce the boundary conditions """
    tol = 10**(-4)
    if (np.abs(y-1)<tol or np.abs(x-1)<tol or np.abs(x+1)<tol  or np.abs(z-1)<tol or np.abs(z+1)<tol ):
        return 20
    if (np.abs(y+1)<tol ):
        return 0
  

def f(x, y, z):
    """ Some example function used here to produce the right hand side field """
    if (x >= -1 and x <= -3/8 and y >= -1 and y <= -1/2 and z >=-2/3 and z <= 0):
        return -200
    return 0

def example():
    """ This function demonstrates the usage of the poisson module and some of its classes """

    #
    # Make the grid on which to solve the Poisson equation
    #

    domain = Domain(center=(0,0,0), edges=(2,2,2))
    grid = Grid(domain, shape=(11,11,11))

    #
    # Prepare the boundary conditions
    #

    bc = {}
    for index in grid.boundary:
        x, y, z = grid.loc(index)
        #print(x,y,z)
        bc[index] = g(x, y, z)

    #
    # Prepare the field with the right-hand-side of the Poisson equation.
    #

    rhs = grid.field_from_function(f)

        # rhs is of type Field, which has two properties: grid and values, the
        # latter being a numpy ndarray holding the field values at the grid
        # points

    #
    # Now solve the Poisson equation \Delta u = rhs
    #

    solver = MultiGridSolver(rhs, bc, atol=1.0E-6)

    solver.solve()
    u = solver.solution()  # u is of type Field

    # print solution

    for index in u.grid.indices():
        (x, y, z), u_val = u[index]
        print("{:10.2f}{:10.2f}{:10.2f}{:12.6f}".format(x, y, z, u_val))

    try:
        solver.solve()
        u = solver.solution()  # u is of type Field

        # print solution

        for index in u.grid.indices():
            (x, y, z), u_val = u[index]
            print("{:10.2f}{:10.2f}{:10.2f}{:12.6f}".format(x, y, z, u_val))

    except Exception as e:
        print("No convergence")

example()