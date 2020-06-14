functions 
{
  // Function block
  
  vector calc_deltas(vector current_alpha_beta, vector values, real[] x_r, int[] x_i)      
  {    
      vector[2] deltas;
      int ALPHA = 1;
      int BETA = 2;

      // Calculate delta between continous density function level and 0 for 99% of CDF
      deltas[1] = gamma_cdf(values[1], current_alpha_beta[ALPHA], current_alpha_beta[BETA]) - 0.99;
      // Calculate delta between continous density function level and 0 for 1% of CDF
      deltas[2] = gamma_cdf(values[2], current_alpha_beta[ALPHA], current_alpha_beta[BETA]) - 0.01;
    
      return deltas;
  }
}

data 
{
  // Initial data block (passed from Python to PyStan)

  vector<lower=0>[2] gaussian_alpha_beta_guess; // Initial guess of alpha and beta parameters
  vector<lower=0>[2] gaussian_values; // Gaussian range where 98% probability needs to be
}

transformed data 
{
  // One - time execution block
  
  int ALPHA = 1;
  int BETA = 2;
  vector[2] gamma_parameters;
  
  real x_r[0];
  int x_i[0];

  // Find gamma parameters (alpha, beta) that ensures 98% probabilty from 5 to 10
  gamma_parameters = algebra_solver(calc_deltas, 
                                    gaussian_alpha_beta_guess, 
                                    gaussian_values,
                                    x_r,
                                    x_i,
                                    1e-10,
                                    1e-3,
                                    1e3);
}

generated quantities 
{
  // Post processing assignment (variables available from PyStan to Python)
  
  real alpha = gamma_parameters[ALPHA];
  real beta = gamma_parameters[BETA];
}