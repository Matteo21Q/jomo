\name{jomo1ran}
\alias{jomo1ran}

\title{
JM Imputation of clustered data
}
\description{
A wrapper function linking the six 2-level JM Imputation functions. The matrix of responses Y, must be a data.frame where continuous variables are numeric and binary/categorical variables are factors.}
\usage{
jomo1ran(Y, X=NULL, Z=NULL,clus, 
      beta.start=NULL, u.start=NULL, l1cov.start=NULL, l2cov.start=NULL, 
      l1cov.prior=NULL, l2cov.prior=NULL, nburn=1000, nbetween=1000, nimp=5, 
      a=NULL, a.prior=NULL, meth="common", output=1, out.iter=10) 

}

\arguments{
  \item{Y}{
    A data.frame containing the outcomes of the imputation model. Columns related to continuous variables have to be numeric and columns related to binary/categorical variables have to be factors. 
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
Starting value for the covariance matrix. Dimension of this square matrix is equal to the number of outcomes (continuous plus latent normals) in the imputation model. The default is the identity matrix.
}
  \item{l2cov.start}{
Starting value for the level 2 covariance matrix. Dimension of this square matrix is equal to the number of outcomes (continuous plus latent normals) in the imputation model times the number of random effects. The default is an identity matrix.
}
  \item{l1cov.prior}{
Scale matrix for the inverse-Wishart prior for the covariance matrix. The default is the identity matrix.
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
Starting value for the degrees of freedom of the inverse Wishart distribution of the cluster-specific covariance matrices. Default is 50+D, with D being the dimension of the covariance matrices. This is used only when option meth is set to "random".
}
  \item{a.prior}{
Hyperparameter (Degrees of freedom) of the chi square prior distribution for the degrees of freedom of the inverse Wishart distribution for the cluster-specific covariance matrices. Default is the starting value for a.
}

\item{meth}{
Method used to deal with level 1 covariance matrix. When set to "common", a common matrix across clusters is used (functions jomo1rancon, jomo1rancat and jomo1ranmix). When set to "fixed", fixed study-specific matrices are considered (jomo1ranconhr, jomo1rancathr and jomo1ranmixhr with coption meth="fixed"). Finally, when set to "random", random study-specific matrices are considered (jomo1ranconhr, jomo1rancathr and jomo1ranmixhr with coption meth="random")
}

 \item{output}{
When set to any value different from 1 (default), no output is shown on screen at the end of the process.
}
\item{out.iter}{
When set to K, every K iterations a dot is printed on screen. Default is 10. 
}

}
\details{
This is just a wrapper function to link jomo1rancon, jomo1rancat and jomo1ranmix and the respective "hr" (heterogeneity in covariance matrices) versions. Format of the columns of Y is crucial in order for the function to be using the right sub-function. }
\value{
On screen, the posterior mean of the fixed effects estimates and of the covariance matrix are shown. The only argument returned is the imputed dataset in long format. Column "Imputation" indexes the imputations. Imputation number 0 are the original data.
}
\references{
Carpenter J.R., Kenward M.G., (2013), Multiple Imputation and its Application. Chapter 9, Wiley, ISBN: 978-0-470-74052-1.
}

\examples{


# define all the inputs:
  
Y<-cldata[,c("measure","age")]
clus<-cldata[,c("city")]
nburn=as.integer(200);
nbetween=as.integer(200);
nimp=as.integer(5);


#And finally we run the imputation function:
imp<-jomo1ran(Y,clus=clus,nburn=nburn,nbetween=nbetween,nimp=nimp)

#we could even run it with fixed or random cluster-specific covariance matrices:

#imp<-jomo1ran(Y,clus=clus,nburn=nburn,nbetween=nbetween,nimp=nimp, meth="fixed")
#or:
#imp<-jomo1ran(Y,clus=clus,nburn=nburn,nbetween=nbetween,nimp=nimp, meth="random")

  # Check help page for function jomo to see how to fit the model and 
  # combine estimates with Rubin's rules


}