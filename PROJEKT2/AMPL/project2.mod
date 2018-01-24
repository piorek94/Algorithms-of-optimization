param t0;						#start time
param tf;						#end time
param N;						#number of samples
param Initial_point;			#initial point for all var
param x10;						#x1(0)
param x20;						#x2(0)
param D = (tf-t0)/N;			#Delta
set SAMPLES = 0 .. (N-1) by 1;	#set of samples

# decision variables
var x1{SAMPLES}:=Initial_point;
var x2{SAMPLES}:=Initial_point;
var u{SAMPLES}:=Initial_point;

#objective function
minimize Cost_Fun:
	sum{k in SAMPLES} D*( ( x1[k] )^2 + ( x2[k] )^2 + 0.005 * ( u[k] )^2 );
	
# equality constraint for state x1(0)
subject to State_X10:
	x1[0] = x10;
# equality constraint for state x2(0)	
subject to State_X20:
	x2[0] = x20;	
# equality constraints for state x1(k+1)	
subject to State_X1_Ceq {k in 0..(N-2)}:
	x1[k+1] - x1[k] - D * x2[k] = 0;
# equality constraints for state x2(k+1)	
subject to State_X2_Ceq {k in 0..(N-2)}:	
	x2[k+1] - x2[k] - D * (u[k] - x2[k]) = 0;

# nonlinear inequality constraints for state x2(k)	
subject to State_X2_C{k in SAMPLES}:
	x2[k] - (8*( D*k - 0.5 )^2 - 0.5) <= 0;