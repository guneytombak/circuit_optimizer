function err = evaluator(Y, Uy, cir)

%% Error

% Phase Margin Error %

pm = Uy(:,1);

lambda = 0.5;
pm_lim = cir.errParam.pm_lim;

sigmoMin = pm_lim(1);
sigmoMax = pm_lim(2);
sigmoMean = mean(pm_lim);

nanInd = any(isnan(Y),2);
lowPmInd = (pm < sigmoMin);

wrongInd = nanInd | lowPmInd;

goodInd = (pm > sigmoMax);
sigmoInd = (pm <= sigmoMax) & (pm >= sigmoMin);

diffPm = pm - sigmoMean;

sigmoPm = 1-1./(1 + exp(-lambda*diffPm));

pm_err = sigmoPm.*sigmoInd;

% Area Error %

area = Uy(:,2);
max_area = cir.errParam.max_area;

area_err = (area > max_area).*(area - max_area); 

% Total Error %

pmFac = cir.errParam.pmFac; 
areaFac = cir.errParam.areaFac;
erreur = (pmFac*pm_err + areaFac*area_err).*goodInd - wrongInd;

err.total = erreur;
err.pm = pm_err;
err.area = area_err;

err.nanInd = nanInd;
err.lowPmInd = lowPmInd;

err.elimInd = wrongInd;
err.selInd = ~wrongInd;

end