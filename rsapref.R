library(shellpipes)

loadEnvironments()

mix <- tsvRead(col_names=FALSE) |> as.matrix()

rho <- symMat(mix)
print(rho)

T <- rowSums(rho)
Tnew <- 1 + T

print(popAdj(rho))
print(popAdj(rho, Tnew=Tnew))
