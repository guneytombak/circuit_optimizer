function [gamma] = gammaFind(xp)

gammaMax = 1e2;
gammaMin = 1e-2;
epsTh = 1e-4; % it is important to change

if any(xp > 1) || any(xp < 0) || any(isnan(xp))
    gamma = -1;
    disp('Points should be in the interval [0 1]!');
    disp(xp);
    return;
elseif any(xp == 1)
    gamma = gammaMax;
    return;
elseif all(xp == 0)
    gamma = gammaMin;
    return;
end

y = exp(gammaMax);

while 1
    
    estimation = sum(xp.^log(y)) - 1;
    
    if abs(estimation) < epsTh
        break;
    end
    
    if estimation > 0
        % make y bigger
        y = 3*y/2;
    else
        % make y smaller
        y = y/2;
    end
        
end

gamma = log(y);

end
