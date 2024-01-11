/* jacobi.h - Poisson problem 
 *
 * $Id: jacobi.h,v 1.1 2006/09/28 10:12:58 bd Exp bd $
 */

#ifndef _JACOBI_PAR_H
#define _JACOBI_PAR_H

int jacobi_parallel(double *** u, double *** uold, double *** f, int N, int iter_max, double *tolerance);

#endif
