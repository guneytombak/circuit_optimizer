function [refDen] = n2refDen(N,noY)

refDen = 1;
H = 0;

while H < N
    refDen = refDen + 1;
    H = nchoosek(noY+refDen-1,refDen);
end 

refDen = refDen - 1;
    
end
