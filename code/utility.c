

void swap_arrays(double*** A, double***B) {
    // Swap arrays by switching pointers
    double *tmp;
    tmp = A[0][0];
    A[0][0] = B[0][0];
    B[0][0] = tmp;
}

int check_convergence(double*** A, double***B, int N, double tolerance) {
    // Check convergence with Frobenius norm
    double sum = 0;
    double val;
    for (int i = 1; i < N+1; i++) {
        for (int j = 1; j < N+1; j++) {
            for (int k = 0; k < N; k++) {
                val = A[i][j][k] - B[i][j][k];
                sum += val*val;

            }
        }
    }

    return (sum < tolerance); 

}