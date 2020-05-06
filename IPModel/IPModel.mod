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
 //range countOfStudents = 1..5;
 
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
  		enter:
  		sum ( i in students : i!=j) X[<i,j>] == 1;  	
  	}
  	
  	forall ( i in students){
  		exit:
  		sum ( j in students : j!=i) X[<i,j>] == 1;  	
  	}
  	
  	forall (i in students : i>1, j in students : j>1 && j!=i){
  		subtour:
  		u[i]-u[j]+(n-1)*X[<i,j>] <= n-2;  	
  	}
 }
 
 
 {edge} tempEdges= {<1,1>};
 execute{
   //writeln(typeof(tempEdges));
   for (var x in edges){
     tempEdges.add(x.i, x.j)
   }
   
   //writeln(X[tempEdges.get(1,4)]);
   
   function recursivePathFinder(X,N,index){
     var result = "";
     for(var i=1; i < N+1; i++){
       
       if (X[tempEdges.get(index,1)] == 1){
         //write("-", index);
         result = result + "-" + index;
         write(result);
         writeln("-1");
         return;
       }
       else if(X[tempEdges.get(index,i)] == 1){
         result = result + "-" + index;
         write(result);
         recursivePathFinder(X,N,i);
       }
     }
     
     return;
   }
   
   recursivePathFinder(X,n,1);
   writeln("Optimal Solution: ", TotalDistance);
 }