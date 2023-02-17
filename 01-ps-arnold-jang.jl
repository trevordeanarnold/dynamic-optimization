#Dynamic Optimization
#PSET 1
#by: dean (tda27) and jihye (jjh749)

using Pkg
Pkg.add("CompEcon")

#---------------------------------------------------------#
#Problem 1
#---------------------------------------------------------#

#part 1
#a profit max firm faces the following demand curve:
## P(q) = a-bq
#and a cost function:
## C(q) = cq

#solve the numerical optimal quantity with the following: 
function profit_max_q(a, c, mu, sigma, method, n)
    #If method is mc (Monte Carlo)
    if method == "mc" 
    #Draw from a log normal distribution
        b = rand(LogNormal(mu, sigma), n)
    #Compute profits
        P = a - b
    # Expectation = mean(x)*volume
        return mean(P) 
    #If method is mc (Monte Carlo)
    elseif method == "quad"




        function profit_max_q(a, c, mu, sigma, method, n)
            if method == "mc"
                # Generate n random draws from a lognormal distribution
                draws = rand(LogNormal(mu, sigma), n)
                # Compute profits for each draw
                prices = a - draws
                quantities = min(prices / (2c), draws / 2)
                profits = quantities .* (prices - c * quantities)
                # Estimate the expected profit as the mean of the profits
                return mean(profits)
            elseif method == "quad"
                # Define the integrand function for computing the expected profit
                integrand(x) = begin
                    q = min((a - exp(x)) / (2c), exp(x) / 2)
                    (a - exp(x)) * q - c * q^2 * exp(x) * pdf(LogNormal(mu, sigma), x)
                end
                # Compute the expected profit using quadrature integration
                nodes, weights = qnwnorm(n, mu, sigma^2)
                return quad(integrand, -Inf, Inf, nodes, weights)
            else
                error("Invalid method: $method")
            end
        end
               

#part 2
#solve the profit_max_q function with a set of values 


#solve with the Monte Carlo method


#solve with the Quadrature method



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
