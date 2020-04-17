elim.yLim = [60 NaN NaN; 61 NaN NaN]; % low & high 
elim.uLim = [10 NaN; 11 NaN]; % low & high 

ckt.elim = elim;

Y = 60 + randn(100,3);
U = 10 + randn(100,2);

%% Code Starts

yLim = ckt.elim.yLim;
uLim = ckt.elim.uLim;

err.yInd = (isnan(yLim(1,:)) | (yLim(1,:) < Y)) & ...
    (isnan(yLim(2,:)) | (Y < yLim(2,:)));
 
err.uInd = (isnan(uLim(1,:)) | (uLim(1,:) < U)) & ...
    (isnan(uLim(2,:)) | (U < uLim(2,:)));

err.nInd = isnan([Y U]);

err.selInd = ~all(err.nInd,2) & all(err.uInd,2) & all(err.yInd,2);
err.elimInd = ~err.selInd;