/* gauss_seidel.c - Poisson problem in 3d
 *
 */
#include <math.h>
#include "utility.h"
#include <stdio.h>

#define _CONVERGENCE

void
gauss_seidel(double *** u, double *** f, int N, int iter_max, double* tolerance) {
    
    double delta = 2.0/(N+1);
    double delta2 = delta*delta;
    double frac = 1.0/6.0;
    double val, sum, uold;

    for (int n = 0; n < iter_max; n++) {
        sum = 0.0;
        for (int i = 1; i < N+1; i++) {
            for (int j = 1; j < N+1; j++) {
                for (int k = 1; k < N+1; k++) {
                    // Save last
                    uold = u[i][j][k];
                    // Do iteration
                    u[i][j][k] = frac*(u[i-1][j][k] + u[i+1][j][k] + u[i][j-1][k] + u[i][j+1][k] + u[i][j][k-1] + u[i][j][k+1] + delta2*f[i][j][k]);
                    // Check convergence with Frobenius norm
                    val = u[i][j][k] - uold;
                    sum += val*val;
                }
            }
        }
        // If convergence is reached, terminate
        if (sum < *tolerance) {
            *tolerance = sum;
            printf("It converged after %d iterations!\n",n);
            return;
        }

    }

    *tolerance = sum;

    return;

}
