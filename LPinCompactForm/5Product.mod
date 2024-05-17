/*********************************************
 * OPL 22.1.1.0 Model
 * Author: mis
 * Creation Date: 17 mai 2024 at 14:50:43
 *********************************************/

int NProd = ...;

range Products = 1..NProd; 

int p [Products] = ...;
int t [Products] = ...;
int m [Products] = ...;
int D [Products] = ...;

int AvailTime = ...; 
int AvailMat = ...;
	
dvar float+ x[Products];


maximize sum(i in Products) (p[i]*x[i]);


subject to {
  
  sum(i in Products) t[i]*x[i] <= AvailTime;
  
  sum(i in Products) m[i]*x[i] <= AvailMat;
  
  forall(i in Products) x[i] <= D[i] ; 
  
  x[1] + x[5] <= x[3] ;
   
}