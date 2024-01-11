# Makefile :)
#
TARGET_SEQ_J  		= sequential_j		# Jacobi sequential
TARGET_SEQ_GS 		= sequential_gs		# Gauss-Seidel sequential
TARGET_PAR_BAS_J  	= par_bas_j			# Jacobi parallel baseline
TARGET_PAR_BAS_GS 	= par_bas_gs		# Gauss-Seidel parallel basline
TARGET_PAR_J  		= parallel_j		# Jacobi parallel
TARGET_PAR_GS 		= parallel_gs		# Gauss-Seidel parallel

SOURCES	= main.c print.c alloc3d.c init.c 
OBJECTS	= print.o alloc3d.o init.o 

MAIN_SEQ_J		= main_seq_j.o
MAIN_SEQ_GS 	= main_seq_gs.o
MAIN_PAR_BAS_J	= main_par_bas_j.o
MAIN_PAR_BAS_GS = main_par_bas_gs.o
MAIN_PAR_J		= main_par_j.o
MAIN_PAR_GS 	= main_par_gs.o

OBJS_SEQ_J		= $(MAIN_SEQ_J) 		jacobi.o
OBJS_SEQ_GS		= $(MAIN_SEQ_GS) 		gauss_seidel.o
OBJS_PAR_BAS_J	= $(MAIN_PAR_BAS_J) 	jacobi_par_bas.o
OBJS_PAR_BAS_GS	= $(MAIN_PAR_BAS_GS) 	gauss_seidel_par_bas.o
OBJS_PAR_J		= $(MAIN_PAR_J) 		jacobi_parallel.o
OBJS_PAR_GS		= $(MAIN_PAR_GS) 		gauss_seidel_parallel.o

# options and settings for the GCC compilers
#
CC	= gcc
DEFS	= 
OPT	= -g -O3 -fopenmp
IPO	= 
ISA	= 
CHIP	= 
ARCH	= 
PARA	= 
CFLAGS	= $(DEFS) $(ARCH) $(OPT) $(ISA) $(CHIP) $(IPO) $(PARA) $(XOPTS)
LDFLAGS = -lm 

all: $(TARGET_SEQ_J) $(TARGET_SEQ_GS) $(TARGET_PAR_BAS_J) $(TARGET_PAR_BAS_GS) $(TARGET_PAR_J) $(TARGET_PAR_GS) 

$(TARGET_SEQ_J): $(OBJECTS) $(OBJS_SEQ_J)
	$(CC) -o $@ $(CFLAGS) $(OBJS_SEQ_J) $(OBJECTS) $(LDFLAGS)

$(TARGET_SEQ_GS): $(OBJECTS) $(OBJS_SEQ_GS)
	$(CC) -o $@ $(CFLAGS) $(OBJS_SEQ_GS) $(OBJECTS) $(LDFLAGS)

$(TARGET_PAR_BAS_J): $(OBJECTS) $(OBJS_PAR_BAS_J)
	$(CC) -o $@ $(CFLAGS) $(OBJS_PAR_BAS_J) $(OBJECTS) $(LDFLAGS)

$(TARGET_PAR_BAS_GS): $(OBJECTS) $(OBJS_PAR_BAS_GS)
	$(CC) -o $@ $(CFLAGS) $(OBJS_PAR_BAS_GS) $(OBJECTS) $(LDFLAGS)

$(TARGET_PAR_J): $(OBJECTS) $(OBJS_PAR_J)
	$(CC) -o $@ $(CFLAGS) $(OBJS_PAR_J) $(OBJECTS) $(LDFLAGS)

$(TARGET_PAR_GS): $(OBJECTS) $(OBJS_PAR_GS)
	$(CC) -o $@ $(CFLAGS) $(OBJS_PAR_GS) $(OBJECTS) $(LDFLAGS)

$(MAIN_SEQ_J):
	$(CC) -o $@ -D_JACOBI $(CFLAGS) -c main.c 

$(MAIN_SEQ_GS):
	$(CC) -o $@ -D_GAUSS_SEIDEL $(CFLAGS) -c main.c

$(MAIN_PAR_BAS_J):
	$(CC) -o $@ -D_JACOBI_PAR_BAS $(CFLAGS) -c main.c 

$(MAIN_PAR_BAS_GS):
	$(CC) -o $@ -D_GAUSS_SEIDEL_PAR_BAS $(CFLAGS) -c main.c

$(MAIN_PAR_J):
	$(CC) -o $@ -D_JACOBI_PAR $(CFLAGS) -c main.c 

$(MAIN_PAR_GS):
	$(CC) -o $@ -D_GAUSS_SEIDEL_PAR $(CFLAGS) -c main.c 

clean:
	@/bin/rm -f core *.o *~

realclean: clean
	@/bin/rm -f $(TARGET_SEQ_J)  $(TARGET_SEQ_GS) $(TARGET_PAR_BAS_J)  $(TARGET_PAR_BAS_GS) $(TARGET_PAR_J)  $(TARGET_PAR_GS)

# DO NOT DELETE

main_seq_j.o: 		main.c print.h jacobi.h init.h 
main_seq_gs.o: 		main.c print.h gauss_seidel.h init.h 
main_par_bas_j.o: 	main.c print.h jacobi_par_bas.h init.h 
main_par_bas_gs.o: 	main.c print.h gauss_seidel_par_bas.h init.h 
main_par_j.o: 		main.c print.h jacobi_parallel.h init.h 
main_par_gs.o: 		main.c print.h gauss_seidel_parallel.h init.h 
print.o: print.h
