
## Infer r_phe by assuming dr, Rscale and OUR interval parameters are correct.
## This is hard, since we have only a ratio for R

Rratio <- function(r, dr, g, kappa, target=0){
	R_orig <- genExp(r*g, kappa)
	R_new <- genExp((r+dr)*g, kappa)
	return(R_new/R_orig - target)
}

r_phe <- uniroot(
	Rratio, c(-rmax, rmax), dr=dr, g=g, kappa=kappa, target=Rscale
)$root
print(r_phe)
print(R_phe <- genExp(r_phe*g, kappa))

######################################################################

