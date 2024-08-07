### Functions

symMat <- function(m){
	stopifnot(class(m) == "matrix")
	stopifnot(nrow(m) == ncol(m))

	return((m+t(m))/2)
}

## Make a mixing matrix from a preference matrix and a Total activity vector
## If not specified, total activity in each class is set to 1
pref2mix <- function(phi, T=NULL){

	phi <- symMat(phi)

	B <- rep(1, nrow(phi))
	if(is.null(T)) T <- B
	p <- T/sum(T)
	sig <- as.vector(1 - phi %*% p)
	D <- sum(p*sig)
	rho <- diag(T) %*% (outer(sig, sig)/D + phi) %*% diag(p)
	return(rho)
}

## Fit a preference matrix to a given mixing matrix
## The idea is that we can later adjust T and get a new mixing matrix 
## that matches the new T and is roughly consistent with the old mixing matrix
## The fit uses a crude, recursive approach that seems to work OK
## It would be good to add checks
mix2pref <- function(rho
	, delta=1, alpha=0.1
	, iterations=40, verbose=FALSE
){
	rho <- symMat(rho)
	nr <- nrow(rho)
	T <- colSums(rho)

	phi <- alpha*matrix(rep(1, nr^2)
		, nrow = nr
	) + (delta-alpha)*diag(rep(1, nr))

	for (i in 1:iterations){
		rhoc <- pref2mix(phi, T)
		if(verbose) print(rhoc)
		phi <- phi*(rho/rhoc) ## ^cpow Tried this. <1 is wimpy and >1 unstable
	}
	
	return(phi)
}

## This is the key function, it takes a mixing matrix, symmetrizes it,
## and tries to return a new mixing matrix with the supplied total activity
## and similar "preferences"
popAdj <- function(rho, Tnew
	, delta=1, alpha=0.1
	, iterations=40, verbose=FALSE
){
	rho <- symMat(rho)

	T <- rowSums(rho)
	phi_est <- mix2pref(rho, delta, alpha, iterations, verbose)
	return(pref2mix(phi_est, Tnew))
}

## Wrapper to adjust a Prem-style matrix (with per-individual mixing rates)
indAdj <- function(mm, orig_pop, new_pop = orig_pop
	, delta=1, alpha=0.1
	, iterations=40, verbose=FALSE
){
  # Convert to a total-contact matrix: multiply rows by pops and symmetrize
  tc <- sweep(mm, 1, orig_pop, `*`) 
  tc_sym <- symMat(tc) 

  # Calculate total-activity vectors
  ta <- rowSums(tc_sym)
  ta_new <- ta  * new_pop / orig_pop

  # Adjust the matrix to new activity levels
  tc_new <- popAdj(tc_sym, ta_new, delta, alpha, iterations, verbose)

  # Return the individual-level version
  return(sweep(tc_new, 1, new_pop, `/`))
}

### Values

phi <- matrix(
	c(
		1, 0, 0
	 , 0, 1, 0
	 , 0.3, 1, 1
	), nrow=3, byrow=TRUE
)

T <- c(1, 1, 2)
Tnew <- c(1, 2, 2)

## Run

rho <- pref2mix(phi, T)
print(rho)
print(popAdj(rho, T))
print(popAdj(rho, Tnew))
print(popAdj(rho, Tnew, alpha=0.5))

print(I1 <- indAdj(phi, orig_pop=T))
print(indAdj(I1, orig_pop=T))
print(indAdj(I1, orig_pop=T, new_pop=Tnew))
