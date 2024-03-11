# ab-testing-special-topics
The simulations used to give intuition and understanding into the reasoning behind why the normal and chi^2 curves are declarative for AB tests through an example of the random walk and random speed problems.

## Random Walk
Notice how the random walks frequency graph created a normal distribution, which became "more normal" with more points on the walk. 
This frequency plot represents the (un-normalized) pdf of finding a points, so we can quanitivaly define how probable it is to find a walk at a certain distance.

Relating to AB testing, we can view the t-score as this particle doing a "random walk", with the p-value as the probability of finding a walk at that distance. By converting the average to a t-score, you have effectively normalized the walk, and can use the normal distribution to find the p-value.

When you argue that "if the p-value is less than 0.05, then the null hypothesis is rejected", you are saying that "if the probability of finding a sample in this position is less than .05 and I found it (in your sampleA vs sampleB calculations), then it's highly unlinkely this path is a coicidence and the null hypothesis can be rejected." 

## Random Speeds
Notice how the distribution of random speeds and enegeries frequency graph is not normal - it's mostly normal but skewed with a longer right tail. This is because speed has no direction (as it's the magnitude of velocity), so the distrubtion is no longer normal.

While the velocity for each dimension in our system (x, y, z) has a normal distribution, the sum of the squares of them results in this non-symmetic, non-normal frequncy map, the chi distribution (not squared yet). Now chi^2 relates the energies of the system (speed^2), which is directly proportional the generalized chaos in the system (entropy). 

Chi^2 is used to test the null hypothesis of "no difference" among categorical variables in AB testing because it measures generalized, non-directional chaos among all dimensions of the system. If your distrubtions from the dimensions are similar, it should converge to be highly-chaotic & high-energy, as stated by the second law of thermodynamics. By contrast, if your underlying distrubtions create an immensely low-chaotic (i.e. low-energy state), then it's highly likely these underlying distrubtions are different. 

Relating to AB testing, when you argue that, for chi^2, "if the p-value is less than 0.05, then the null hypothesis is rejected", you are saying that "if the probability of finding these distriubtions at an entropy this low and I found it (in your sampleA vs sampleB calculations), then it's highly unlinkely this state is a coincidence (violates the second law of thermodynamics) and the null hypothesis can be rejected (i.e. these distributions are not the same)." 

In theory, for performing a hypothesis test with categorical variables, we take each dimension to be the difference between the normal distrubtions (of differences in observed-expected) of the samples. This encapsulates the difference between the distrubtions into a normal curve, which we combine into the chi^2 curve (visuals helps this explanation, see video).

## Video of Special Topic Hour
TODO: add video after the hours
