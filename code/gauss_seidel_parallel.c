/* gauss_seidel.c - Poisson problem in 3d
 *
 */
#include <math.h>
#include <stdio.h>
#include <omp.h>


void
gauss_seidel_parallel(double *** u, double *** f, int N, int iter_max, double* tolerance) {
    
    double delta = 2.0/(N+1), delta2 = delta*delta, frac = 1.0/6.0;
    double val, uold, sum = *tolerance + 1;
    int n = 0;
    double start = omp_get_wtime();
    while (n < iter_max && sum > *tolerance) {
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
        // Next iteration
        n++;
    }
    double stop = omp_get_wtime() - start;
    *tolerance = sum;
    printf("%d %d %.5e %.5f\n",N,n,*tolerance,stop);
    return;

}
