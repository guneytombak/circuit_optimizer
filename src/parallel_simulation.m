function [Y, U] = parallel_simulation(X, ckt)

    [N,~] = size(X);
    
    pllProp = gcp;
    noPool = pllProp.NumWorkers;
    
    perPool = ceil(N/noPool);
    
    Xcell = cell(1,noPool);
    Ycell = cell(1,noPool);
    Ucell = cell(1,noPool);
    
    for k = 1:noPool
        if k ~= noPool
            Xcell{k} = X(((k-1)*perPool+1):k*perPool,:);
        else
            Xcell{k} = X(((k-1)*perPool+1):N,:);
        end
    end
        
    parfor ii = 1:noPool
        [Ycell{ii},Ucell{ii}]=simulation(Xcell{ii},ckt,ii);
    end
    
    for k = 1:noPool
        if k ~= noPool
            Y(((k-1)*perPool+1):k*perPool,:) = Ycell{k};
            U(((k-1)*perPool+1):k*perPool,:) = Ucell{k};
        else
            Y(((k-1)*perPool+1):N,:) = Ycell{k};
            U(((k-1)*perPool+1):N,:) = Ucell{k};
        end
    end

end
