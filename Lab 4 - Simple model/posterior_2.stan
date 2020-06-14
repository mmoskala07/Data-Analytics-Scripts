data 
{
    int N;
    int input_deaths[N];
    vector[N] miles_flown;
}

parameters
{
    real beta;
}

transformed parameters 
{
    vector[N] lambda = miles_flown*beta;
}

model 
{
    beta ~ beta(5,30);
    input_deaths ~ poisson(lambda);
}

generated quantities {
    int deaths[N];
    for (year in 1:N) {
        deaths[year] = poisson_rng(lambda[year]);
    }

}