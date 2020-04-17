current_time = toc;

if gen == (preGen + 1)
    simDur = t1/(specs.popSize*specs.iniPopMult);
    selDur = current_time - t1;
    genDur = simDur*specs.popSize + selDur;
    totDur = current_time + genDur*specs.noGen;
    
    est.simulation_duration = simDur;
    est.selection_duration = selDur;
    est.generational_duration = genDur; 
    est.total_duration = totDur;
    
    disp(['Estimated generational duration: ' ...
    datestr(seconds(est.generational_duration),'HH:MM:SS')]);

    disp(['Estimated total duration: ' ...
    datestr(seconds(est.total_duration),'dd | HH:MM:SS')]);
end
    disp(['Estimated remaining duration: ' ...
    datestr(seconds(est.total_duration - current_time),'dd | HH:MM:SS')]);

% Note: Should be redefined for load