%% Check the Toolbox
if pll.flag == 1
    try 
       ver('parallel')
    catch
       fprintf('There is no parallel computing module.');
       pll.flag = 0;
    end
else
    pll.numWorkers = 1;
end

%% Parallel Pool Start
if pll.flag
    pll_run_flag = ~isempty(gcp('nocreate'));
    if pll_run_flag
        current_pll = gcp;
        if current_pll.NumWorkers ~= pll.numWorkers
            delete(gcp('nocreate'));
            parpool('local',pll.numWorkers);
        end
    else
        parpool('local',pll.numWorkers);
    end
    pll.status = gcp;
    pll.numWorkers = pll.status.NumWorkers; 
end

%% Selection of Simulator

if pll.flag == 1
    simu = @parallel_simulation;
else
    simu = @(X, ckt) simulation(X, ckt, 1);
end