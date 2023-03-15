data {
	int<lower=0> K;
}

parameters {
	real alpha;
	real beta1;
	real beta2;
	real<lower=0> sigma;
}

model
{
	for (i in 1:K) {
		r0[i] ~ dbin(p0[i], n0[i]);
		r1[i] ~ dbin(p1[i], n1[i]);
		logit(p0[i]) = mu[i];
		logit(p1[i]) = mu[i] + logPsi[i];
		logPsi[i] = alpha + beta1 * year[i] + beta2 * (year[i] * year[i] - 22) + b[i];
		b[i] ~ dnorm(0, tau);
		mu[i] ~ dnorm(0.0, 1.0E-6);
	}
	alpha ~ dnorm(0.0, 1.0E-6);
	beta1 ~ dnorm(0.0, 1.0E-6);
	beta2 ~ dnorm(0.0, 1.0E-6);
	tau ~ dgamma(1.0E-3, 1.0E-3);
	sigma = 1 / sqrt(tau);
}
