# -*- coding: utf-8 -*-
"""
Created on Thu May  7 03:01:37 2020

@author: m_e_r
"""
import pandas as pd
import time;


def findOptimalPath(excelData, setS, index, N , optimalValue, optimalSolution , ListedTimeData, current = 10000 ): # index = start node, N = nodeCount
    
    target = -1
    current = 10000
    if len(setS) == 1:
        optimalValue = optimalValue + excelData[index][0]
        # print("index: ", index)
        optimalValue = optimalValue + ListedTimeData[0][index-1]
        print("Optimal path: ", optimalSolution)
        print("Optimal Value: ",optimalValue)
        return
    
    for i in setS:
        # print("i is now: ", i)
        # print("current: ",current)
        # print("excel: ",excelData[index][i])
        if current >= excelData[index][i]:
            target = i
            current = excelData[index][i]
    
    optimalValue = optimalValue + excelData[index][target]
    optimalSolution.append(target + 1)
    # print("optimal value: ", optimalValue)
    # print("optimal path: ", optimalSolution)
    # print("going to: ", target)
    # print("on: ", index)
    # print("before pop: ",setS)
    setS.remove(index)
    # print("after pop: ",setS)
    
    
    if index == 0:
        optimalValue = optimalValue
    else:
        #print("sadsad: ", ListedTimeData[0])
        # print("index: ", index)
        optimalValue = optimalValue + ListedTimeData[0][index-1]
    
    # print("////////////////")
    findOptimalPath(excelData, setS, target , n, optimalValue ,optimalSolution, ListedTimeData)
    


if __name__ == "__main__":
    
    n = 75

    n = n + 1 
    
    nodesFile = 'StudentsN75.xlsx'
    rawFile = pd.ExcelFile(nodesFile)
    #print(rawFile.sheet_names)
    #print(type(rawFile))
    nodesDf = rawFile.parse('Sheet1', header = 0, index_col=0)
    
    print(nodesDf)
    listedExcelData = nodesDf.values.tolist()
    
    timesFile = 'StudentWorkTimes.xlsx'
    rawTimeFile = pd.ExcelFile(timesFile)
    #print(rawTimeFile.sheet_names)
    #print(type(rawTimeFile))
    timesDf = rawTimeFile.parse('Sheet1', header = 0, index_col=0)
    
    print(timesDf)
    ListedTimeData = timesDf.values.tolist()
    #print(ListedTimeData)
    
    
    students = []

    for i in range(n):
        students.append(i)
    
    # print(len(students))
    # print(students)
    
    start = 0
    optimalValue = 0
    optimalSolution = []
    
    timeStart = time.time()
    findOptimalPath(listedExcelData, students, start, n, optimalValue ,optimalSolution, ListedTimeData)
    timeEnd = time.time()
    
    print("Elapsed Time: ", timeEnd - timeStart)
  