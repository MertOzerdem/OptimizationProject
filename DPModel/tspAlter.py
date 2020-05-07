import pandas as pd
import time;

optimalSolution = []   

def tsp(graph, v, currPos, n, count, cost, ListedTimeData): 
  
    if (count == n and graph[currPos][0]):
        
        studyCost = 0
        for i in range(n-1):
            studyCost = studyCost + ListedTimeData[0][i]
        
        optimalSolution.append(cost + graph[currPos][0] + studyCost)
            
        return
  
    for i in range(n): 
        if (v[i] == False and graph[currPos][i]): 
              
            # Mark as visited 
            v[i] = True
            #print("pos: ",ListedTimeData[0][currPos]);
            tsp(graph, v, i, n, count + 1,  
                cost + graph[currPos][i], ListedTimeData) 
              
            # Mark ith node as unvisited 
            v[i] = False
  
if __name__ == '__main__': 
    
    # Student Node Counts
    n = 5 
    # Add professor
    n = n + 1
    ## Get data from excel for nodes
    nodesFile = 'StudentsN5.xlsx'
    rawFile = pd.ExcelFile(nodesFile)
    print(rawFile.sheet_names)
    print(type(rawFile))
    nodesDf = rawFile.parse('Sheet1', header = 0, index_col=0)
    
    print(nodesDf)
    listedExcelData = nodesDf.values.tolist()
    print(listedExcelData)
    
    ## Get student completion times
    timesFile = 'StudentWorkTimes.xlsx'
    rawTimeFile = pd.ExcelFile(timesFile)
    print(rawTimeFile.sheet_names)
    print(type(rawTimeFile))
    timesDf = rawTimeFile.parse('Sheet1', header = 0, index_col=0)
    
    print(timesDf)
    ListedTimeData = timesDf.values.tolist()
    print(ListedTimeData)
    
    # Boolean array to check if a node has been visited or not 
    v = [False for i in range(n)] 
      
    # Mark professor as visited since its first node
    v[0] = True
    
    timeStart = time.time()
    # Find the minimum weight Hamiltonian Cycle 
    tsp(listedExcelData, v, 0, n, 1, 0, ListedTimeData)
    timeEnd = time.time()
    
    # studyCost = 0
    # for i in range(n):
    #     studyCost = studyCost + ListedTimeData[0][i]
   
    print('optimal Solution: ', min(optimalSolution))
    print("Elapsed Time: ",timeEnd-timeStart)
    
    
    
    