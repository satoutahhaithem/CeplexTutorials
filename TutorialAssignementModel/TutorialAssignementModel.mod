/*********************************************
 * OPL 22.1.1.0 Model
 * Author: mis
 * Creation Date: 17 mai 2024 at 16:54:02
 *********************************************/
 int NJobs = ...;
 int NMachines = ... ;
 
 range Jobs = 1..NJobs;
 range Machines = 1..NMachines ;
 
int c[Jobs][Machines] =...;

dvar float+ x[Jobs][Machines];

minimize sum(i in Jobs,j in Machines)c[i][j]*x[i][j];
subject to {
  forall(j in Machines) sum(i in Jobs)x[i][j]==1;
  forall(i in Jobs) sum (j in Machines)x[i][j]==1;
   
}