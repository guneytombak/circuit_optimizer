while gen < noGen

    gen = gen + 1;
    disp(gen);

    %% Simulation
    
    if gen == (preGen + 1)
        rX = iniX;
        [rY, rU] = simu(rX, ckt);
    else
        [offSpY, offSpU] = simu(offSpX, ckt);
            
        rX = [offSpX; X];
        rY = [offSpY; Y];
        rU = [offSpU; U];
    end
    
    %% Duration Estimation
    
    if gen == (preGen + 1)
        t1 = toc;
    end
    
    %% Elimination

    eli = elimination(rY,rU,specs);
    selE = eli.selInd;
    eliE = eli.elimInd;
    
    if sum(selE) < specs.popSize
        error('Not enough good member!');
    end
    
    X = rX(selE, :);
    Y = rY(selE, :);
    U = rU(selE, :);
    
    wX = rX(eliE, :);
    wY = rY(eliE, :);
    wU = rU(eliE, :);
          
    %% Raw Archive
    
    if gen ~= 0
        arch.rX(gen,:,:) = rX;
        arch.rY(gen,:,:) = rY;
        arch.rU(gen,:,:) = rU;
        arch.eli{gen} = eli;
    else
        arch.ini.rX = rX;
        arch.ini.rY = rY;
        arch.ini.rU = rU;
        arch.ini.err = eli;
    end
    
    %% Selection
    
    [sel, hete, Znew, nsgaData] = selection(Y, Z, specs);
    
    X = X(sel,:);
    Y = Y(sel,:);
    U = U(sel,:);
   
    loop_plot;

    %% Matingpool

    fr = nsgaData.frontLabel;
    matSel = mating(fr, hete, specs.popSize);

    %% Crossover and Mutation with Boundary Elimination
    
    [offSpX, outOfRange] = crossMutation(matSel, X, lims, specs);
    
    %% Archiving
    
    if gen ~= 0
        arch.X(gen,:,:) = X;
        arch.Y(gen,:,:) = Y;
        arch.U(gen,:,:) = U;
        arch.Z{gen} = Z;
        arch.nsgaData{gen} = nsgaData;
        arch.outOfRange(gen,:) = outOfRange;
    else
        arch.ini.X = X;
        arch.ini.Y = Y;
        arch.ini.U = U;
        arch.ini.Z = Z;
        arch.ini.nsgaData = nsgaData;
        arch.ini.outOfRange = outOfRange;
    end

    %% Last X and Z for Load
    continuum.X = [offSpX; X];
    continuum.Z = Z;
    
    %% Duration Estimation
    
    duration_estimation;
    
end