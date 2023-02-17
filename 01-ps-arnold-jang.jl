#Dynamic Optimization
#PSET 1
#by: dean (tda27) and jihye (jjh749)


using Pkg
Pkg.add("CompEcon")

#part 1
#a profit max firm faces the following demand curve:
## P(q) = a-bq
#and a cost function:
## C(q) = cq

#solve the numerical optimal quantity with the following: 
function profit_max_q(a, c, mu, sigma, method, n)
    #If method is mc (Monte Carlo)
    if method == "mc" 
    #Draw from a normal distribution
        bq = rand(LogNormal(mu, sigma), n)
    #Compute profits
        Pq = a - bq
    # Expectation = mean(x)*volume
        return mean(Pq) 
    #If method is mc (Monte Carlo)
    elseif method == "quad"








#part 2
#solve the profit_max_q function with a set of values 


#solve with the Monte Carlo method


#solve with the Quadrature method
