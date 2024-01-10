
#include <math.h>
#include <string.h>
#include <stdio.h>
void init(double *** u, double *** uold, double *** f, int N, double start_T) {

    double delta = 2.0/(N+1);
    double fracdelta = (N+1)/2.0;
    memset(f[0][0],0,(N+2)*(N+2)*(N+2)*sizeof(double));
    memset(uold[0][0],start_T,(N+2)*(N+2)*(N+2)*sizeof(double));

    int ux = floor(0.625*fracdelta), uy = floor(0.5*fracdelta), lz = ceil(1.0/3.0*fracdelta), uz = floor(fracdelta);

    /*for (int i = 0; i < N+2; i++) {
        for (int j = 0; j < N+2; j++) {
            for (int k = 0; k < N+2; k++) { 
                if (j == 0) {
                    uold[i][j][k] = 0;
                    u[i][j][k] = 0;
                }
                else if (i == 0 || i == N+1 || j == N+1 || k == 0 || k == N+1) {
                    uold[i][j][k] = 20.0;
                    u[i][j][k] = 20.0;
                }
                else {
                    uold[i][j][k] = start_T;
                }
                
            }
        }
    }*/

    for (int i = 0; i < N+2; i++) {
        for (int j = 0; j < N+2; j++) {

            uold[0][j][i] = 20.0;
            uold[N+1][j][i] = 20.0;

            u[0][j][i] = 20.0;
            u[N+1][j][i] = 20.0;

            uold[i][0][j] = 0;
            uold[i][N+1][j] = 20.0;

            u[i][0][j] = 0;
            u[i][N+1][j] = 20.0;

            uold[i][j][0] = 20.0;
            uold[i][j][N+1] = 20.0;

            u[i][j][0] = 20.0;
            u[i][j][N+1] = 20.0;
        }
    }
    

    for (int i = 1; i <= ux; i++) {
        for (int j = 1; j <= uy; j++) {
            for (int k = lz; k <= uz; k++) {   
                f[i][j][k] = 200;
            }
        }
    }


}