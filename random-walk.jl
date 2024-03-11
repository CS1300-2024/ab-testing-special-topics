using Plots # for plotting trajectory
using Distributions # for fitting a normal distribution

function dynamics!(params) # ! notation tells us that arguments will be modified
   (x_change_per_step, num_steps, num_points) = params

   x = zeros(num_points) # array to store x positions after the random walks
   
    for i in 1:num_points
    # determine the direction of the step
    # set starting point to x
    x[i] = 0.0

    # simulate the random walk
    for _ in 1:num_steps
        if rand() < 0.5
            # go left, negative
            dx = -x_change_per_step
            x[i] += dx
        else
            # go right, positive
            dx = x_change_per_step
            x[i] += dx
        end
    end
   end


    μ = sum(x) / length(x)
    σ = sqrt(sum((x .- μ).^2) / length(x))
    normal = Normal(μ, σ)


   println("μ: $μ, σ: $σ, n: $(length(x))")

   return x
end

function plot_frequencies(x)

    # make a map each positions to it's Frequency
    freqs = Dict()
    for xi in x
        if haskey(freqs, xi)
            freqs[xi] += 1
        else
            freqs[xi] = 1
        end
    end

    num_points = length(x)
    plt = scatter(
        collect(keys(freqs)), collect(values(freqs)), 
        label="Frequency", xlabel="Position", ylabel="Frequency", 
        title="Freq of Positions ($num_points points)",
        msw=0, color=:green, legend=false)
    return plt
end

function plot_histogram(x)
    # make a histogram of the random walk
    num_points = length(x)
    plt = histogram(x, xlabel="Position", 
    ylabel="Frequency", legend=false,
    title="Histogram of Random Walk")
    return plt
end

function fit_normal(x)
    # fit a normal distribution to the random walk
    μ = sum(x) / length(x)
    σ = sqrt(sum((x .- μ).^2) / length(x))
    normal = Normal(μ, σ)

    # get the pdf's over the min and max values found
    x_min = minimum(x)
    x_max = maximum(x)
    bigger = max(abs(x_min), abs(x_max)) # center the plot
    x_range = range(-bigger, bigger, length=100)
    pdf_vals = pdf.(normal, x_range)

    # plot the normal distribution
    return plot(x_range, pdf_vals, lw=2, color=:red, title="Normal Fit", legend=false)
end

function demo_1(num_points=1000)
    # simulation parameters
    x_change_per_step = 1.0 # step size
    num_steps = 100 # number of steps in the random walk
    params = (x_change_per_step, num_steps, num_points)
    x = dynamics!(params) # run the random walk

    # plot only the frequencies
    p = plot_frequencies(x)
    savefig(p, "figs/rw-demo1.png")
end

function demo_3()
    # simulation parameters
    x_change_per_step = 1.0 # step size
    num_steps = 100 # number of steps in the random walk

    # run the random walk with a smaller number of points
    num_points = 15 # number of random walks
    params = (x_change_per_step, num_steps, num_points)
    x_1 = dynamics!(params) # run the random walk

    # run a second random walk with 1000 points
    num_points = 100
    params = (x_change_per_step, num_steps, num_points)
    x_2 = dynamics!(params) # run the random walk

    # run a third random walk with 10000 points
    num_points = 10000
    params = (x_change_per_step, num_steps, num_points)
    x_3 = dynamics!(params) # run the random walk

    # plot the results
    p0_1 = plot_frequencies(x_1)
    p1_1 = plot_histogram(x_1)
    p2_1 = fit_normal(x_1)

    p0_2 = plot_frequencies(x_2)
    p1_2 = plot_histogram(x_2)
    p2_2 = fit_normal(x_2)

    p0_3 = plot_frequencies(x_3)
    p1_3 = plot_histogram(x_3)
    p2_3 = fit_normal(x_3)

    p = plot(
        p0_1, p1_1, p2_1,
        p0_2, p1_2, p2_2,
        p0_3, p1_3, p2_3,
        layout=(3, 3),
        size=(1000, 1000),
        )

    savefig(p, "figs/rw-demo3.png")
end

println("Starting Random Speed Simulations...\n")

# demo_1(1000000) # plot a frequncy plot of param n points
demo_3()

println("\nRandom Walk Simulations Complete!")
