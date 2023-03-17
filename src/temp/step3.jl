#Define competition kernels

#The functional forms taken from Taper and Case (1992)
#there are two parameters: sigma (width of a Gaussian shape) and
#theta(asymmetry parameter)

sigma=1.0
theta=0.0

function alpha(x::Float64, y::Float64, sigma::Float64, theta::Float64)
    
    return exp((sigma^2)*(theta^2))*exp(-((x-y+(2*(sigma^2)*theta))^2)/(4*(sigma^2)))
end

#Pre-calculate coefficients of competition between pairs of genotypes

A1=zeros(Float64,nt,nt)
A0=zeros(Float64,nt,nt)

for i in 1:nt, j in 1:nt
    
    A1[i,j]=a1*alpha(geno[j],geno[i],sigma,theta)
    
    A0[i,j]=a1*alpha(geno[j],geno[i],sigma,theta)
end

A1= A1 ./ 10000
A0= A0 ./ 10000

