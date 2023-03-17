#Set up a probability matrix of an offspring having a phenotype x when the parents have the phenotypes v and w resp.
# This code follows the diploid version of an exact hypergeometric model
#from Shpak and Kondrashov (1999)
haplR=zeros(Float64,n+1,n+1,n+1)

for i in 0:n, j in 0:i, k in 0:min(n,(i+j))
    haplR[1+i,1+j,1+k]=sum(pdf.(Hypergeometric(i,n-i,j),max(0, i+j-n):min(i, j)) .*
                          map(x->pdf(Binomial(i+j-2*x),k-x),collect(max(0, i+j-n):min(i,j))))
end

for k in 0:n
    haplR[:,:,1+k]=haplR[:,:,1+k]+transpose(haplR[:,:,1+k])
    for i1 in 0:n
        haplR[i1+1,i1+1,k+1] /= 2
    end
end

ind_haplR=zeros(Float64,2*n+1, 2*n+1)

for k in 0:n
    for i in 0:n
        ind_haplR[1+i,1+k] = haplR[1+i,1,1+k]
        for j in 0:n
            ind_haplR[1+j+n,1+k]=haplR[1+n,1+j,1+k]
        end
    end
end

R=zeros(Float64,nt,nt,nt)

for i in 0:(2*n), j in 0:(2*n), q in 0:(2*n)
    R[1+i,1+j,1+q]= sum(ind_haplR[1+i,1 .+ (0:q)] .* 
                        ind_haplR[1+j,1+q .- (0:q)])
end

