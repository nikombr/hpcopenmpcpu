/* jacobi.h - Poisson problem 
 *
 * $Id: jacobi.h,v 1.1 2006/09/28 10:12:58 bd Exp bd $
 */

#ifndef _JACOBI_PAR_BAS_H
#define _JACOBI_PAR_BAS_H

int jacobi_par_base(double *** u, double *** uold, double *** f, int N, int iter_max, double *tolerance);

#endif
