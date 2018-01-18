#
SOURCES = mpi-ring1.c 
MPICC = mpicc
CC = cc
NPROCS = 4
# adjust the following based upon local environment. 
HOSTFILE = cloudhosts
NETWORK = 10.1.76.0/24
MPIRUN_FLAGS = --map-by node --mca btl self,tcp --mca btl_tcp_if_include $(NETWORK) 
DEBUG = 

default: mpi-ring1

mpi-ring1: mpi-ring1.c cs160String.o 
	$(MPICC) -o mpi-ring1 mpi-ring1.c cs160String.o -lm

cs160String.o : cs160String.c cs160String.h
	$(CC) -c cs160String.c
	
run: mpi-ring1
	mpirun --np $(NPROCS) --hostfile $(HOSTFILE) $(MPIRUN_FLAGS) mpi-ring1 $(DEBUG) 


%.o : %.c
	$(MPICC) -c $<
% : %.o
	$(MPICC) -o $@ $< -lm

