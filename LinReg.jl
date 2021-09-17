using Base: Float64, Int64
using Dates
using Plots

pow_2(x::Any) = x*x 
pow_3(x::Any) = x*x*x


# Linear regression for one variable functions
function linreg(funk::Function, x_range::Vector{T} where T, plot::Bool=false) 
    # Vectors
    y = []
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

    # Generating the(y with the function
    for i in x_range[1]:x_range[2]:x_range[3]
        y = funk(i)
        sum_x += i
        sum_y += y
        append!(x, i)
        append!(y, y)
    end

    # Calculating means
    mean_y = sum_y/length(y)
    mean_x = sum_x/length(y)

    # Calculating the sums of numerator and denumerator seperatly
    for i in 1:length(x)
        beta_top += ((x[i]-mean_x)*(y[i]-mean_y))
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
        scatter(x, y)
        plot!([x[1], x[end]], [beta*x[1]+alfa, beta*x[end]+alfa])
    else
        return alfa, beta
    end
end


function linreg(x_range::Vector{T} where T, y_range::Vector{T} where T, plot::Bool)
    if length(x_range) == length(y_range)

        # Vectors
        y = y_range
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
        mean_y = sum(y_range)/length(y)
        mean_x = sum(x_range)/length(y)

        # Calculating the sums of numerator and denumerator seperatly
        for i in 1:length(x)
            beta_top += ((x[i]-mean_x)*(y[i]-mean_y))
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
            scatter(x, y)
            plot!([x[1], x[end]], [beta*x[1]+alfa, beta*x[end]+alfa])
        else
            return alfa, beta
        end
    else
        println("x_range and y_range needs to be the same size. Check the \"Examples\" for more informations.")
    end
end

function linreg(only_dates::Vector{Date}, y_range::Vector{T} where T, plot::Bool)

    # Vectors
    y = y_range
    x, dates = map_dates(only_dates)
    # dates = [ Dates.format(z, "yyyy-mm-dd") for z in dates ]
    println(x)

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
    mean_y = sum(y)/length(y)
    mean_x = sum(x)/length(y)

    # Calculating the sums of numerator and denumerator seperatly
    for i in 1:length(x)
        beta_top += ((x[i]-mean_x)*(y[i]-mean_y))
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
        scatter(x, y, xticks=Dates.value.(dates))
        plot!([x[1], x[end]], [beta*x[1]+alfa, beta*x[end]+alfa])
    else
        return alfa, beta
    end
end


function map_dates(dates::Vector{Date})
    mapped_dates = []
    indexes      = []
    new_index    = 0
    for date in dates
        if date in mapped_dates
            push!(indexes, findfirst(x->x==date, mapped_dates))
        else
            push!(mapped_dates, date)
            push!(indexes, new_index)
            new_index += 1
        end
    end
    return indexes, mapped_dates
end

linreg(
    [
        Date(2004,1,20), Date(2004,3,23), Date(2004,1,20), 
        Date(2004,7,11), Date(2004,7,11), Date(2004,6,10)
    ], 
    
    [
        0.1, 0.2, 1.1, 
        0.5, 0.6, 0.8
    ], 
    
    true
)