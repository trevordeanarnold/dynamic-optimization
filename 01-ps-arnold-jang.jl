#Dynamic Optimization
#PSET 1
#by: dean (tda27) and jihye (jjh749)

#import Pkg
using Pkg
Pkg.add("Distributions")
Pkg.add("QuadGK") # use  Gauss-Kronrod quadrature
Pkg.add("Optim")
Pkg.add("CompEcon")

#---------------------------------------------------------#
#Problem 1
#---------------------------------------------------------#

#part 1
#a profit max firm faces the following demand curve:
## P(q) = a-bq
#and a cost function:
## C(q) = cq

import Pkg; Pkg.add("Distributions")
import Pkg; Pkg.add("QuadGK")
import Pkg; Pkg.add("Optim")
import Random
Random.seed!(1234)

using Distributions, QuadGK, Optim

function profit_max_q(a, c, mu, sigma, method, n)
    # Define demand function
    function P(q)
        b_dist = LogNormal(mu, sigma)
        b = rand(b_dist)
        return a - b*q
    end

    # Define profit function
    function profit(q)
        rev = P(q)*q
        cost = c*q
        return rev - cost
    end

    # Define expected profit function
    function expected_profit(q)
        b_dist = LogNormal(mu, sigma)
        b_pdf(x) = pdf(b_dist, x)
        b_cdf(x) = cdf(b_dist, x)
        rev = quadgk(x -> P(x)*x*b_pdf(x), -Inf, q)[1] + (a - P(q))*q* b_cdf(q)
        cost = c*q
        return rev - cost
    end

    if method == "mc"
        # Monte Carlo integration
        q_vals = rand(LogNormal(mu, sigma), n)
        profits = [profit(q) for q in q_vals]
        optimal_q = q_vals[argmax(profits)]
    elseif method == "quad"
        # Gaussian quadrature integration
        result = optimize(expected_profit, 0.0, 1000)
        optimal_q = result.minimizer
    else
        error("Invalid method choice. Choose 'mc' or 'quad'.")
    end

    return optimal_q
end

#part 2
#solve the profit_max_q function with a set of values 
# 1. solve with the Monte Carlo method
profit_max_q(500, 20, 5, 0.1,"mc", 1000)

# 2. solve with the Quadrature method
profit_max_q(500, 20, 5, 0.1,"quad", 1000)

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

monte_carlo_pi(10^4)
