data{
    int N; //the number of observations
    real Y[N]; //the response
    real m_0x[N];
    real m_1x[N];
    real A[N]; //the model matrix
    real p[N];
}
parameters{
    real tao; //the regression parameters
  real<lower=0> sigma; //the standard deviation
  vector[N] pm1;
  vector[N] pm0;
}
transformed parameters {
  real linpred[N];
  for (j in 1:N)
    linpred[j] = (A[j]-p[j])*tao+p[j]*pm1[j]+(1-p[j])*pm0[j];
}
model{
    tao ~ normal(0,10); 
  pm1 ~ normal(m_1x,10);
  pm0 ~ normal(m_0x,10);
  Y ~ normal(linpred,sigma);
  sigma ~ cauchy(0,5);
}
