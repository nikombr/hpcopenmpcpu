/* jacobi.c - Poisson problem in 3d
 * 
 */
#include <math.h>
#include "utility.h"
#include <stdio.h>

#define _CONVERGENCE

void
jacobi(double *** u, double *** uold, double *** f, int N, int iter_max, double* tolerance) {
    
    double delta = 2.0/(N+1);
    double delta2 = delta*delta;
    double frac = 1.0/6.0;
    double val;
    double sum;

    for (int n = 0; n < iter_max; n++) {
        for (int i = 1; i < N+1; i++) {
            for (int j = 1; j < N+1; j++) {
                for (int k = 1; k < N+1; k++) {
                    u[i][j][k] = frac*(uold[i-1][j][k] + uold[i+1][j][k] + uold[i][j-1][k] + uold[i][j+1][k] + uold[i][j][k-1] + uold[i][j][k+1] + delta2*f[i][j][k]);

                }
            }
        }
        #ifdef _CONVERGENCE
        // Check convergence with Frobenius norm
        sum = 0.0;
        for (int i = 1; i < N+1; i++) {
            for (int j = 1; j < N+1; j++) {
                for (int k = 1; k < N+1; k++) {
                    val = u[i][j][k] - uold[i][j][k];
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
        #endif

        // Swap addresses
        double ***tmp;
        tmp = u;
        u = uold;
        uold = tmp;

    }

    *tolerance = sum;

    return;

}
