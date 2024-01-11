/* gauss_seidel.h - Poisson problem
 *
 */
#ifndef _GAUSS_SEIDEL_PAR_BAS_H
#define _GAUSS_SEIDEL_PAR_BAS_H

void gauss_seidel(double *** u, double *** f, int N, int iter_max, double* tolerance);

#endif
