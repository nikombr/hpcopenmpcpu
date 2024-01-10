/* main.c - Poisson problem in 3D
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include "alloc3d.h"
#include "print.h"
#include "init.h"

#ifdef _JACOBI
#include "jacobi.h"
#endif

#ifdef _GAUSS_SEIDEL
#include "gauss_seidel.h"
#endif

#define N_DEFAULT 100


int
main(int argc, char *argv[]) {

    if (argc < 5 || argc > 6) {
        printf("Usage: %s N(int) iter_max(int) tolerance(double) start_T(double) [output_type(0, 3 or 4)]\n",argv[0]);
        return(1);
    }

    int 	N = N_DEFAULT;
    int 	iter_max = 1000;
    double	tolerance;
    double	start_T;
    int		output_type = 0;
    char	*output_prefix = "poisson_res";
    char        *output_ext    = "";
    char	output_filename[FILENAME_MAX];
    double 	***u = NULL;
    double 	***uold = NULL;
    double 	***f = NULL;


    /* get the parameters from the command line */
    N         = atoi(argv[1]);	// grid size
    iter_max  = atoi(argv[2]);  // max. no. of iterations
    tolerance = atof(argv[3]);  // tolerance
    start_T   = atof(argv[4]);  // start T for all inner grid points
    if (argc == 6) {
	    output_type = atoi(argv[5]);  // ouput type
    }
    
    // allocate memory
    if ( (u = malloc_3d(N+2, N+2, N+2)) == NULL ) {
        perror("array u: allocation failed");
        exit(-1);
    }
    if ( (f = malloc_3d(N+2, N+2, N+2)) == NULL ) {
        perror("array f: allocation failed");
        exit(-1);
    }
    if ( (uold = malloc_3d(N+2, N+2, N+2)) == NULL ) {
        perror("array uold: allocation failed");
        exit(-1);
    }

    // initialize and start and boundary conditions
    init(u, uold, f, N, start_T);

    // call iterator
    #ifdef _JACOBI
    jacobi(u, uold, f, N, iter_max, &tolerance);
    FILE *fp = fopen("results/output_x.txt", "w");
    if (fp!= NULL) {
        double delta = 2.0/(N+1);
    for (int i = 0; i < N+2; i++) {
        for (int j = 0; j < N+2; j++) {
            for (int k = 0; k < N+2; k++) {
                fprintf(fp,"\t%.2f ",uold[i][j][k]);

            }
            fprintf(fp,"\n");

        }
        fprintf(fp,"\n\n");
    }
    }
    fp = fopen("results/output_y.txt", "w");
    if (fp!= NULL) {
        double delta = 2.0/(N+1);
    for (int j = 0; j < N+2; j++) {
        for (int i = 0; i < N+2; i++) {
            for (int k = 0; k < N+2; k++) {
                fprintf(fp,"\t%.2f ",uold[i][j][k]);

            }
            fprintf(fp,"\n");

        }
        fprintf(fp,"\n\n");
    }
    }
    fp = fopen("results/output_z.txt", "w");
    if (fp!= NULL) {
        double delta = 2.0/(N+1);
    for (int k = 0; k < N+2; k++) {
        for (int j = 0; j < N+2; j++) {
            for (int i = 0; i < N+2; i++) {
                fprintf(fp,"\t%.2f ",uold[i][j][k]);

            }
            fprintf(fp,"\n");

        }
        fprintf(fp,"\n\n");
    }
    }

    #endif
    

    #ifdef _GAUSS_SEIDEL

    gauss_seidel(u, f, N, iter_max, &tolerance);
    
    #endif

    // dump  results if wanted 
    switch(output_type) {
	case 0:
	    // no output at all
	    break;
	case 3:
	    output_ext = ".bin";
	    sprintf(output_filename, "results/%s_%d%s", output_prefix, N, output_ext);
	    fprintf(stderr, "Write binary dump to %s: ", output_filename);
	    print_binary(output_filename, N, u);
	    break;
	case 4:
	    output_ext = ".vtk";
	    sprintf(output_filename, "results/%s_%d%s", output_prefix, N, output_ext);
	    fprintf(stderr, "Write VTK file to %s: ", output_filename);
	    print_vtk(output_filename, N, u);
	    break;
	default:
	    fprintf(stderr, "Non-supported output type!\n");
	    break;
    }

    // de-allocate memory
    free_3d(u);
    free_3d(f);

    return(0);
}
