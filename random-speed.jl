using Plots
using Distributions

num_velocities = 1000

println("Starting Random Speed Simualtions...\n")

function make_random_velocity()
    # pull 3 nums randomly from normal distribution
    N = Normal(0, 1)
    return (rand(N), rand(N), rand(N))
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


# make velocities
velocities = [make_random_velocity() for _ in 1:num_velocities]

# plot these velocities on 1d plots
px = histogram([v[1] for v in velocities], bins=30, title="X Velocity")
py = histogram([v[2] for v in velocities], bins=30, title="Y Velocity")
pz = histogram([v[3] for v in velocities], bins=30, title="Z Velocity")

# print the mean and standard deviation of each velocity distribution
println("X->\tμ:$(mean([v[1] for v in velocities])), σ:$(std([v[1] for v in velocities])), n:$(length([v[1] for v in velocities]))")
println("Y->\tμ:$(mean([v[2] for v in velocities])), σ:$(std([v[2] for v in velocities])), n:$(length([v[2] for v in velocities]))")
println("Z->\tμ:$(mean([v[3] for v in velocities])), σ:$(std([v[3] for v in velocities])), n:$(length([v[3] for v in velocities]))")

p = plot(px, py, pz, layout=(3, 1), size=(800, 800))
savefig(p, "figs/rs-1dvels.png")

# plot these velocities in 3d space
p = Plots.scatter(
    [v[1] for v in velocities], 
    [v[2] for v in velocities], 
    [v[3] for v in velocities], 
    title="Velocities")
savefig(p, "figs/rs-3dvels.png")

# plot their speeds
speeds = [sqrt(v[1]^2 + v[2]^2 + v[3]^2) for v in velocities]
p = histogram(
    speeds, title="Randomly Generated Speeds (n=$num_velocities)", 
    legend=false, xlabel="Speed", ylabel="Frequency")
savefig(p, "figs/rs-speeds.png")
# print the mean and standard deviation of the speed distribution
println("\nSpeed->\tμ:$(mean(speeds)), σ:$(std(speeds)), n:$(length(speeds))")


println("\nRandom Speed Simualtions Complete!")