#Dynamic Optimization
#PSET 1
#by: dean (tda27) and jihye (jjh749)

#import Pkg
using Pkg
Pkg.add("Distributions")
Pkg.add("QuadGK") # use  Gauss-Kronrod quadrature
Pkg.add("Optim")
Pkg.add("CompEcon")
Pkg.add("FastGaussQuadrature")
import Random
Random.seed!(1234)


#---------------------------------------------------------#
#Problem 1
#---------------------------------------------------------#

#part 1
#a profit max firm faces the following demand curve:
## P(q) = a-bq
#and a cost function:
## C(q) = cq

using Distributions, QuadGK, Optim, FastGaussQuadrature

function profit_max_q(a, c, mu, sigma, method, n)
    bdist = LogNormal(mu, sigma)
    qdist = x -> (a - x) / mean(bdist)
    profit(q) = (a - mean(bdist)*q)*q - c*q


    if method == "mc"
        # Monte Carlo integration
        q_vals = qdist.(rand(bdist, n))
        profits = profit.(q_vals)
        optimal_q =  q_vals[argmax(profits)]
    elseif method == "quad"
        # Gaussian quadrature integration
        integrand(q) = (a - c - q * mean(bdist)) * q
        optimal_q, _ = quadgk(integrand, 0, a / mean(bdist))
    else
        error("Invalid method choice. Choose 'mc' or 'quad'.")
    end

    return optimal_q
end

#part 2
#solve the profit_max_q function with a set of values 
# 1. solve with the Monte Carlo method
profit_max_q(500, 20, 5, 0.1,"mc", 10000)

# 2. solve with the Quadrature method
profit_max_q(500, 20, 5, 0.1,"quad", 10000)

#part 3
#Make sure your code is type-stable by using the code introspection macros (e.g. @code_llvm, @code_warntype, @trace)

#---------------------------------------------------------#
#Problem 2: Monte Carlo Integration
#---------------------------------------------------------#

function monte_carlo_pi(n::Int)
    inside_circle = 0
    for i in 1:n
        x, y = rand(-1:1, 2)
        if x^2 + y^2 <= 1
            inside_circle += 1
        end
    end
    return 4 * inside_circle / n
end

monte_carlo_pi(10^9)



#---------------------------------------------------------#
#Problem 3: Shell scripting
#---------------------------------------------------------#

#Tried to run all of the following and many more for the script and failed to get it to run
#the shell file is in this repo called hw1_q3_script.sh

#run(`sh hw1_q3_script.sh`)
#run(`sh hw1_q3_script.sh`)
#sh ./hw1_q3_script.sh
#run(`./hw1_q3_script.sh`)