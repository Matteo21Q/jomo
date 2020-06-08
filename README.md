# jomo
An R package for Joint Modelling (Multilevel) Multiple Imputation

This R package provides functions to handle missing data in single or multilevel datasets by means of Multiple Imputation. In particular, imputation functions are based on a parametric type of imputation that assumes a joint model for the partially observed data and uses MCMC to draw the imputations. 

This package is based on a similar algorithm as pan, but handles binary and categorical variables through latent normals. Other features of jomo are the possibility to impute level 2 variables, to allow for cluster-specific covariance matrices and to impute compatibly with some specific imputation models. 

Please feel free to email me if you use jomo and have any suggestions on ways to improve it. 
