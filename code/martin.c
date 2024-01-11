/* gauss_seidel.c - Poisson problem in 3d
 *
 */
#include <math.h>
#include <stdio.h>
#ifdef _OPENMP
   #include <omp.h>
#else
   #define omp_get_thread_num() 0
   #define omp_get_wtime() 0.0;
#endif

#define _CONVERGENCE

void
gauss_seidel_parallel_base(double *** u, double *** f, int N, int iter_max, double* tolerance) {
    
    double delta = 2.0/(N+1), delta2 = delta*delta, frac = 1.0/6.0;
    double val, uold, sum = *tolerance + 1;
    int n = 0;
    //parallel stuff
    int nt = omp_get_max_threads();
    printf("\n Detected max number of threads %d \n",nt);
    double start = omp_get_wtime();
    int i,j,k;
    //end parallel stuff
    while (n < iter_max && sum > *tolerance) {
        sum = 0.0;
        #pragma omp parallel for ordered(2) default(none) shared(N,u,frac,delta2,f) private(val,uold,i,j,k) schedule(static,1) reduction(+:sum) //reduction(+:sum)
        for (i = 1; i < N+1; i++) {
            for (j = 1; j < N+1; j++) {
                //#pragma omp ordered depend(sink:i-1,j-1) depend(sink:i-1,j) depend(sink:i-1,j+1) depend(sink:u,j-1)
                #pragma omp ordered depend(sink:i-1,j) depend(sink:i,j-1)
                for (k = 1; k < N+1; k++) {
                    // Save last
                    uold = u[i][j][k];
                    // Do iteration
                    u[i][j][k] = frac*(u[i-1][j][k] + u[i+1][j][k] + u[i][j-1][k] + u[i][j+1][k] + u[i][j][k-1] + u[i][j][k+1] + delta2*f[i][j][k]);
                    // Check convergence with Frobenius norm
                    val = u[i][j][k] - uold;
                    sum += val*val;
                }
                #pragma omp ordered depend(source)
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