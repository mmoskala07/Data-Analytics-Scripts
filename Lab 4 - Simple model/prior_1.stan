generated quantities
{
    real lambda = normal_rng(692, 250);
    int deaths = poisson_rng(lambda);
}