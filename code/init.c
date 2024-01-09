


void init(double *** uold, double *** f, int N, double start_T) {

    double delta = 2.0/N;
    memset(f[0][0],0,(N+2)*(N+2)*(N+2)*sizeof(double))

    int ux = 1, uy = 1, lz = 1, uz = 1;

    for (int i = 0; i < N+2; i++) {
        for (int j = 0; j < N+2; j++) {
            for (int k = 0; k < N+2; k++) { 
                if (i == 0) {
                    uold[i][j][k] = 0;
                }
                else if (i == N+1 || j == 0 || j == N+1 || k == 0 || k == N+1) {
                    uold[i][j][k] = 20;
                }
                else {
                    uold[i][j][k] = start_T;
                }
                
            }
        }
    }

    for (int i = 0; i < ux; i++) {
        for (int j = 0; j < uy; j++) {
            for (int k = lz; k < uz; k++) {   
                f[i][j][k] = 200;
            }
        }
    }


}