### Functions

symMat <- function(m){
	stopifnot(class(m) == "matrix")
	stopifnot(nrow(m) == ncol(m))

	return((m+t(m))/2)
}

## Make a mixing matrix from a preference matrix and a Total activity vector
## If not specified, T is just 1s
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
	, iterations=20, verbose=FALSE
){
	rho <- symMat(rho)
	nr <- nrow(rho)
	T <- colSums(rho)

	phi <- alpha*matrix(rep(1, nr^2)
		, nrow = nr
	) + (delta-alpha)*diag(rep(1, nr))

	for (i in 1:10){
		rhoc <- pref2mix(phi, T)
		if(verbose) print(rhoc)
		phi <- phi*rho/rhoc
	}
	
	return(phi)
}

## This is the key function, it takes a mixing matrix, symmetrizes it,
## and tries to return a new mixing matrix with the supplied total activity
## and similar "preferences"
mixAdj <- function(rho, Tnew
	, delta=1, alpha=0.1
	, iterations=20, verbose=FALSE
){
	rho <- symMat(rho)

	T <- rowSums(rho)
	phi_est <- mix2pref(rho, delta, alpha, iterations, verbose)
	return(pref2mix(phi_est, Tnew))
}
indAdj <- function(mm, orig_pop, new_pop = orig_pop){
  # Convert Prem to a total-contact matrix (multiply rows by pops)
  tc <- sweep(mm, 1, orig_pop, `*`) 
  # Symmetrize
  tc_sym <- symMat(tc) 
  # Take the margin (total-activity vector ⇒ T)
  ta <- rowSums(tc_sym)
  ta_new <- ta / orig_pop * new_pop
  # Run mixAdj to get a new rho
  tc_new <- mixAdj(tc_sym, ta_new)
  tc_new <- tc_sym
  # Adjust that to version the model wants
  betas_new <- sweep(tc_new, 1, new_pop, `/`)
  return(betas_new)
}

## Adjust a Prem-style matrix (with per-individual mixing rates)
indAdj2 <- function(mm, orig_pop, new_pop = orig_pop){
  # Convert to a total-contact matrix: multiply rows by pops and symmetrize
  tc <- sweep(mm, 1, orig_pop, `*`) 
  tc_sym <- symMat(tc) 

  # Calculate total-activity vectors
  ta <- rowSums(tc_sym)
  ta_new <- ta  * new_pop / orig_pop

  # Adjust the matrix to new activity levels
  tc_new <- mixAdj(tc_sym, ta_new)
  tc_new <- tc_sym

  # Return the individual-level version
  return(sweep(tc_new, 1, new_pop, `/`))
}

### Values

phi <- matrix(
	c(
		1, 0, 0
	 , 0, 1, 0
	 , 0, 1, 1
	), nrow=3, byrow=TRUE
)

T <- c(1, 1, 2)
Tnew <- c(1, 2, 2)

## Run

rho <- pref2mix(phi, T)
print(rho)

print(mixAdj(rho, T, Tnew))
print(mixAdj(rho, T, Tnew, alpha=0.5))
## Gives NAs now 2020 May 20 (Wed)
## print(I1 <- indAdj(phi, orig_pop=T))
## print(indAdj(I1, orig_pop=T))
