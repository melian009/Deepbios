#simulate the dynamics

#Initialize phenotypic frequencies

#option 1: All phenotypes are uniformly distributed

N=rand(Uniform(0,1), nsp,nt)

Ng0= N ./ (sum.(eachrow(N)))

Np0= 1000 .* Ng0
 
global Ngen = true 
Ngen=deepcopy(Ng0)
Np=deepcopy(Np0)

#Start the simulation

for m in 1:3000#Number of iterations per replicate
    
    #Determine the extinct species
    Np[findall(sum(Np,dims=2) .< 10),:] .= 0
    
    if all(sum(Np,dims=2) ==0) 
        break
    else
    
        newgen=zeros(Float64,nsp,nt)

        #Reproduction event
        for i in 1:size(Ngen)[1]

            probs=Ngen[i,:]*Ngen[i,:]'

            for j in 1:size(R)[3]
                newgen[i,j]=sum(probs.*R[:,:,j])
            end
        end



        newp=newgen .* sum(Np,dims=2)

        #Selection event
        for i in 1:size(newp)[1], j in 1:size(newp)[2]

            comps=sum(A1[j,:] .* newp[1:end .!=i,:]') + sum(A0[j,:] .* newp[i,:]) 
            Np[i,j]=newp[i,j]+(newp[i,j]*(1-comps))

        end

        Np[findall(Np .<10)] .= 0
        Ngen = Np ./ sum(Np,dims=2)#added Ngen1 instead of Ngen as initially defined
    end
end   

#@isdefined(Ngen1)
@isdefined(Ngen)

