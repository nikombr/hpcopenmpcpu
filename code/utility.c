

void swap_arrays(double*** A, double***B) {
    // Swap arrays by switching pointers
    double *tmp;
    tmp = A[0][0];
    A[0][0] = B[0][0];
    B[0][0] = tmp;
}