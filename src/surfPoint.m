function [sPoint] = surfPoint(rPoint, gamma)
% rPoint should be NxnoDim matrix. 
    
zeta = (sum(rPoint.^gamma,2)).^(-1/gamma);

sPoint = zeta.*rPoint;

end
