from time import perf_counter #get time

def getWorkTime(str1, str2, NoProcesses):
    t1_start = perf_counter()
    for i in range(NoProcesses):
        levensRec(str1, str2)
        
    t1_stop = perf_counter()
    print("Elapsed time:", t1_stop-t1_start) 
    t2_start = perf_counter()
    for i in range(NoProcesses):
        levens(str1, str2)
    t2_stop = perf_counter()
    print("Elapsed time:", t2_stop-t2_start) 

    t3_start = perf_counter()
    for i in range(NoProcesses):
        levensAdj(str1, str2)
    t3_stop = perf_counter()
    print("Elapsed time:", t3_stop-t3_start) 

def levensAdj(str1,str2):
    length1, length2 = len(str1), len(str2)
    if (length1 < 2 or length2 < 2):
        return levens(str1, str2)

    if length1 > length2:
        str1, str2 = str2, str1
        length1, length2 = length2, length1
        
    prev_row = range(length1 + 1)
    curr_row = [1] + [0] * length1
    for i in range(1, length1 + 1):
        insert, delete, subsitution = prev_row[i] + 1, curr_row[i - 1] + 1, prev_row[i - 1]
        if str1[i - 1] != str2[0]:
            subsitution += 1
        curr_row[i] = min(insert, delete, subsitution)

    for i in range(2, length2 + 1):
        prev_prev_row = prev_row; prev_row = curr_row; curr_row = [i] + [0] * length1
        insert, delete, subsitution = prev_row[1] + 1, curr_row[0] + 1, prev_row[0]
        if (str1[0] != str2[i - 1]):
            subsitution += 1
        curr_row[1] = min(insert, delete, subsitution)

        for j in range(2, length1 + 1):
            insert, delete, subsitution = prev_row[j] + 1, curr_row[j - 1] + 1, prev_row[j - 1]                                         
            if (str1[j - 1] != str2[i - 1]):
                subsitution += 1
            if (str2[i - 1] == str1[j - 2] and str2[i - 2] == str1[j - 1]):
                transp = prev_prev_row[j - 2] + 1 
                curr_row[j] = min(insert, delete, subsitution, transp)
            else:
                curr_row[j] = min(insert, delete, subsitution)

    return curr_row[length1]

def levens(word1,word2):
    length1 ,length2 = len(word1), len(word2)
    if length1 > length2 :
        word1, word2 = word2, word1
        length1 ,length2 = length2, length1

    current_row = range(length1 + 1)
    for i in range(1,length2 + 1):
        previous_row,current_row = current_row,[i] + [0] * length1
        for j in range(1,length1 + 1):
            insert, delete, subsitution = previous_row[j] + 1,current_row[j-1] + 1,previous_row[j-1]
            if word1[j -1] != word2[i - 1]:
                subsitution += 1
            current_row[j] = min(insert, delete,subsitution)
    return current_row[length1]    

def levensRec(str1,str2):
    length1 =  len(str1)
    if(length1 == 0):
        return len(str2)

    length2 = len(str2)
    if(length2 == 0):
        return len(str1)

    if(str1[0] == str2[0]):
        cost = 0
    else:
        cost = 1

    return min((levensRec(str1[1:],str2) + 1),
               (levensRec(str1,str2[1:]) + 1),
               (levensRec(str1[1:],str2[1:]) + cost))
    

def getOutput(str1,str2):
    print('Recursion            : ',levensRec(str1,str2))
    print('Levenstain:          : ',levens(str1,str2))
    print('Adject_Transposition :',levensAdj(str1,str2))

    
def printOutput(str1,str2,NoProcesses):
    print('Result of Algorithm Levenstein')
    print('entered 2 words -> '+ str1 +',' + str2)

    print('\nNo of processes:')
    getOutput(str1,str2)

    print("\nWork Time:")
    getWorkTime(str1, str2, NoProcesses)

def main():
     NoProcesses = 100
     str1 = input('string 1 = ')
     str2 = input('string 2 = ')
     printOutput(str1,str2,NoProcesses)

     
if __name__ == '__main__':
    main()
