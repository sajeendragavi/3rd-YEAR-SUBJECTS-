#Helambage Gavindu Sajeendra 
#iu 7-56
#Rk_01

from time import perf_counter

def getProcessTime(N):
    t1_start = perf_counter()
    sieve_of_eratosthenes(N)
    t1_stop = perf_counter()
    print("Elapsed time to eratosthene:",t1_stop - t1_start)

    t2_start = perf_counter()
    normal_method(N)
    t2_stop = perf_counter()
    print("Elapsed time normal :",t2_stop - t2_start)
    
def normal_method(N):
    print('using Normal Algorithm->')
    for k in range(0,N):
        flag = 0
        if k > 1:
            for i in range(2,k):
                if(k % i) == 0:
                    flag = 1
                    break
            if(flag == 0):
               print(k)
        

def sieve_of_eratosthenes(n):
    print('using Eratosthene Algorithm->')
    is_prime = [True]*(n-1) #create array 
    p = 2 # 2 as first prime number

    while True:
        multiplier = 2
        multiple = p * multiplier # (2p,3p,4p,,,)

        while multiple <= n:
            is_prime[multiple- 2] = False
            multiplier += 1
            multiple = p * multiplier

        for i,prime in enumerate(is_prime):
            if prime and i+2>p:
                p = i + 2
                break

        else:
            break

    for i,prime in enumerate(is_prime):
        if prime:
            print (i+2)
            
    #print('Total time : %0.5f' %(end_time-start_time))

def getoutput(N):
    getProcessTime(N)

def main():
    N = int(input('Enter the quantity of natural numbers:'))     
    getoutput(N)
    
if __name__ == '__main__':
    main()



        
            


        


