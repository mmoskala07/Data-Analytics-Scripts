data
{
    int N;
    real miles_flown[N];
}

generated quantities
{
    // The average intensity is 0.126 to let's choose distribution that gives us values between 0 and 1
    // The Beta distribution will make a job here, let's choose alpha=2, beta=10
    real beta = beta_rng(5, 30);
    int deaths[N];
    for(year in 1:N)
    {
        deaths[year] = poisson_rng(miles_flown[year] * beta);
    }
}