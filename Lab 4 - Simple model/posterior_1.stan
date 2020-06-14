data {
    int N; //Number of our samples from data
    int deaths[N]; //Our deaths per year from data
}

parameters{
    real<lower=0> lambda;
}

model {
    lambda ~ normal(692,250);
    deaths ~ poisson(lambda);
}

generated quantities {
    int deaths_predicted = poisson_rng(lambda);
}