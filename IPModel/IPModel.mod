/*********************************************
 * OPL 12.9.0.0 Model
 * Author: m_e_r
 * Creation Date: 1 May 2020 at 21:24:38
 *********************************************/

 // problem size
 int n=...;
 
 tuple edge {
 	int i;
 	int j;
 }
 
 tuple time {
   	float k;
 }
 
 range students = 1..n;
 float points[students][students] = ...;
 
 //setof(edge) edges = {<i,j> | i,j in students : i!=j};
 setof(edge) edges = {<i,j> | i,j in students};
 
 float C[edges];
 
 ///////////////////////////////////
 range countOfStudents = 1..n-1;
 
 float times[countOfStudents] = ...;
 
 setof(time) setOfTimes = {<k> | k in countOfStudents};
 
 float T[setOfTimes];
 
 float x = 1;
 float y = 1;
 float z = 1;
 
 execute{
 	for (var e in edges){
 	  	C[e] = points[x][y];
 	  	if(y==n){
 	  	  x= x + 1;
 	  	  y=1;
 	  	}
 	  	else{
 	  	  y = y + 1;
 	  	}
 	}
 	
 	for (var t in setOfTimes){
 	  T[t] = times[z];
 	  z = z + 1;
 	}	 
 }
 
 //decision variable
 dvar boolean X[edges];
 dvar float+ u[2..n];
 
 // expression
 dexpr float TotalDistance = sum(e in edges) C[e]*X[e] + sum(t in setOfTimes) T[t];
 
 // Model
 minimize TotalDistance;
 subject to {
  	forall ( j in students){
  		flow_in:
  		sum ( i in students : i!=j) X[<i,j>] == 1;  	
  	}
  	
  	forall ( i in students){
  		flow_out:
  		sum ( j in students : j!=i) X[<i,j>] == 1;  	
  	}
  	
  	forall (i in students : i>1, j in students : j>1 && j!=i){
  		subtour:
  		u[i]-u[j]+(n-1)*X[<i,j>] <= n-2;  	
  	}
 }