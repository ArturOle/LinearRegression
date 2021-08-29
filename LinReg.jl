using Base: Float64, Int64
using Plots

pow_2(x::Any) = x*x 
pow_3(x::Any) = x*x*x


# Linear regression for one variable functions
function linreg(funk::Function, x_range::Vector{T} where T, plot::Bool=false) 
    # Vectors
    data = []
    x    = []

    # Sums
    sum_x::Float64 = 0
    sum_y::Float64 = 0
    
    # Coefficients
    beta_top = 0
    beta_bot = 0
    beta     = 0
    alfa     = 0

    # Means
    mean_x = 0
    mean_y = 0

    # Generating the data with the function
    for i in x_range[1]:x_range[2]:x_range[3]
        y = funk(i)
        sum_x += i
        sum_y += y
        append!(x, i)
        append!(data, y)
    end

    # Calculating means
    mean_y = sum_y/length(data)
    mean_x = sum_x/length(data)

    # Calculating the sums of numerator and denumerator seperatly
    for i in 1:length(x)
        beta_top += ((x[i]-mean_x)*(data[i]-mean_y))
        beta_bot += ((x[i]-mean_x)^2)
    end

    # Calculating coefficients
    beta = beta_top/beta_bot
    alfa = mean_y - mean_x*beta

    if plot
        # Presentation of the results
        println("α = " , alfa, "   β = ", beta )
        println("mean of x = ", mean_x, "    mean of y = ", mean_y)

        # Ploting the function and the linear regression line
        scatter(x, data)
        plot!([x[1], x[end]], [beta*x[1]+alfa, beta*x[end]+alfa])
    else
        return alfa, beta
    end
end


function linreg(x_range::Vector{T} where T, y_range::Vector{T} where T, plot::Bool)
    if length(x_range) == length(y_range)

        # Vectors
        data = y_range
        x    = x_range

        # Sums
        sum_x::Float64 = 0
        sum_y::Float64 = 0
        
        # Coefficients
        beta_top = 0
        beta_bot = 0
        beta     = 0
        alfa     = 0

        # Means
        mean_x = 0
        mean_y = 0

        # Calculating means
        mean_y = sum(y_range)/length(data)
        mean_x = sum(x_range)/length(data)

        # Calculating the sums of numerator and denumerator seperatly
        for i in 1:length(x)
            beta_top += ((x[i]-mean_x)*(data[i]-mean_y))
            beta_bot += ((x[i]-mean_x)^2)
        end

        # Calculating coefficients
        beta = beta_top/beta_bot
        alfa = mean_y - mean_x*beta

        if plot
            # Presentation of the results
            println("α = " , alfa, "   β = ", beta )
            println("mean of x = ", mean_x, "    mean of y = ", mean_y)

            # Ploting the function and the linear regression line
            scatter(x, data)
            plot!([x[1], x[end]], [beta*x[1]+alfa, beta*x[end]+alfa])
        else
            return alfa, beta
        end
    else
        println("x_range and y_range needs to be the same size. Check the \"Examples\" for more informations.")
    end
end

linreg([1, 3, 2, 5, 4, 6], [0.1, 0.2, 1.1, 0.5, 0.6, 0.8], true)