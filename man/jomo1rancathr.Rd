\name{jomo1rancathr}
\alias{jomo1rancathr}

\title{
JM Imputation of clustered data with categorical variables with cluster-specific covariance matrices
}
\description{
Impute a clustered dataset with categorical variables as outcome. A joint multivariate model for partially observed data is assumed and imputations are generated through the use of a Gibbs sampler where a different covariance matrix is sampled within each cluster. Fully observed categorical covariates may be considered as covariates as well, but they have to be included as dummy variables.
}
\usage{
jomo1rancathr( Y.cat, Y.numcat, X=NULL, Z=NULL, clus, beta.start=NULL, 
u.start=NULL, l1cov.start=NULL, l2cov.start=NULL, l1cov.prior=NULL, 
l2cov.prior=NULL, nburn=1000, nbetween=1000, nimp=5, a=NULL,
a.prior=NULL, meth="random", output=1, out.iter=10)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
 \item{Y.cat}{
A data frame, or matrix, with categorical (or binary) responses of the joint imputation model. Rows correspond to different observations, while columns are different variables. Missing values are coded as NA.
}
  \item{Y.numcat}{
A vector with the number of categories in each categorical (or binary) variable.
}
  \item{X}{
A data frame, or matrix, with covariates of the joint imputation model. Rows correspond to different observations, while columns are different variables. Missing values are not allowed in these variables. In case we want an intercept, a column of 1 is needed. The default is a column of 1.
}
  \item{Z}{
A data frame, or matrix, for covariates associated to random effects in the joint imputation model. Rows correspond to different observations, while columns are different variables. Missing values are not allowed in these variables. In case we want an intercept, a column of 1 is needed. The default is a column of 1.
}
  \item{clus}{
A data frame, or matrix, containing the cluster indicator for each observation. 
}
  \item{beta.start}{
Starting value for beta, the vector(s) of fixed effects. Rows index different covariates and columns index different outcomes. For each n-category variable we define n-1 latent normals. The default is a matrix of zeros.
}
  \item{u.start}{
A matrix where different rows are the starting values within each cluster for the random effects estimates u. The default is a matrix of zeros.
}
  \item{l1cov.start}{
Starting value for the covariance matrices, stacked one above the other. Dimension of each square matrix is equal to the number of outcomes (continuous plus latent normals) in the imputation model. The default is the identity matrix for each cluster.
}
  \item{l2cov.start}{
Starting value for the level 2 covariance matrix. Dimension of this square matrix is equal to the number of outcomes (continuous plus latent normals) in the imputation model times the number of random effects. The default is an identity matrix.
}
   \item{l1cov.prior}{
Scale matrix for the inverse-Wishart prior for the covariance matrices. The default is the identity matrix.
}
  \item{l2cov.prior}{
Scale matrix for the inverse-Wishart prior for the level 2 covariance matrix. The default is the identity matrix.
}
   \item{nburn}{
Number of burn in iterations. Default is 1000.
}
  \item{nbetween}{
Number of iterations between two successive imputations. Default is 1000.
}
  \item{nimp}{
Number of Imputations. Default is 5.
}
  \item{a}{
Starting value for the degrees of freedom of the inverse Wishart distribution of the cluster-specific covariance matrices. Default is 50+D, with D being the dimension of the covariance matrices.
}
  \item{a.prior}{
Hyperparameter (Degrees of freedom) of the chi square prior distribution for the degrees of freedom of the inverse Wishart distribution for the cluster-specific covariance matrices. Default is D, with D being the dimension of the covariance matrices.
}

  \item{meth}{
When set to "fixed", a flat prior is put on the study-specific covariance matrices and each matrix is updated separately with a different MH-step.
When set to "random", we are assuming that all the covariance matrices are draws from an inverse-Wishart distribution, whose parameter values are updated with 2 steps similar to the ones presented in the case of continuous data only for function jomo1ranconhr.
}

 \item{output}{
When set to any value different from 1 (default), no output is shown on screen at the end of the process.
}
\item{out.iter}{
When set to K, every K iterations a dot is printed on screen. Default is 10. 
}

}
\details{
The Gibbs sampler algorithm used is obtained is a mixture of the ones described in chapter 5 and 9 of Carpenter and Kenward (2013). We update the covariance matrices element-wise with a Metropolis-Hastings step. When meth="fixed", we use a flat prior for rhe matrices, while with meth="random" we use an inverse-Wishar tprior and we assume that all the covariance matrices are drawn from an inverse Wishart distribution. We update values of a and A, degrees of freedom and scale matrix of the inverse Wishart distribution from which all the covariance matrices are sampled, from the proper conditional distributions. A flat prior is considered for beta.   Binary or continuous covariates in the imputation model may be considered without any problem, but when considering a categorical covariate it has to be included with dummy variables (binary indicators) only. 
}
\value{
On screen, the posterior mean of the fixed effects estimates and of the covariance matrix are shown. The only argument returned is the imputed dataset in long format. Column "Imputation" indexes the imputations. Imputation number 0 are the original data.
}
\references{
Carpenter J.R., Kenward M.G., (2013), Multiple Imputation and its Application. Chapter 9, Wiley, ISBN: 978-0-470-74052-1.

Yucel R.M., (2011), Random-covariances and mixed-effects models for imputing multivariate multilevel continuous data, Statistical Modelling, 11 (4), 351-370, DOI: 10.1177/1471082X100110040.

}

\examples{

# we define the inputs
# nimp, nburn and nbetween are smaller than they should. This is
#just because of CRAN policies on the examples.

Y.cat=cldata[,c("social"), drop=FALSE]
Y.numcat=matrix(4,1,1)
X=data.frame(rep(1,1000),cldata[,c("sex")])
colnames(X)<-c("const", "sex")
Z<-data.frame(rep(1,1000))
clus<-cldata[,c("city")]
beta.start<-matrix(0,2,3)
u.start<-matrix(0,10,3)
l1cov.start<-matrix(diag(1,3),30,3,2)
l2cov.start<-diag(1,3)
l1cov.prior=diag(1,3);
l2cov.prior=diag(1,3);
a=5
nburn=as.integer(100);
nbetween=as.integer(100);
nimp=as.integer(4);

#Finally we run either the model with fixed or random cluster-specific cov. matrices:

imp<-jomo1rancathr(Y.cat, Y.numcat, X,Z,clus,beta.start,u.start,l1cov.start, 
      l2cov.start,l1cov.prior,l2cov.prior,nburn,nbetween,nimp, a, meth="fixed")
      
cat("Original value was missing (",imp[3,1],"), imputed value:", imp[1003,1])

  # Check help page for function jomo to see how to fit the model and 
  # combine estimates with Rubin's rules


}
