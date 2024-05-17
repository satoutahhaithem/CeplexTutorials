/*********************************************
 * OPL 22.1.1.0 Model
 * Author: mis
 * Creation Date: 17 mai 2024 at 11:24:53
 *********************************************/

dvar float+ x1;
dvar float+ x2;


maximize 5*x1+4*x2; 


subject to 
{
  
  6*x1+4*x2 <=24;
  
  x1+2*x2 <=6;
  
  -x1+x2 <=1;
  
  x2 <= 2;
  
  
}




