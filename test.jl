include("LinReg.jl")

# Linear Regression test
result_alfa, result_beta = linreg(sin, [1.,1.,10.])
if abs(result_alfa - 0.367) > 0.1 || abs(result_beta - 0.04) > 0.1
    println("Error, function gives wrong results")
end
