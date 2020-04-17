function eli = elimination(Y, U, specs)

yLo = specs.lims.yLo; 
yUp = specs.lims.yUp;

uLo = specs.lims.uLo; 
uUp = specs.lims.uUp;

eli.yInd = (isnan(yLo) | (Y >= yLo)) & (isnan(yUp) | (Y <= yUp)); 
eli.uInd = (isnan(uLo) | (U >= uLo)) & (isnan(uUp) | (U <= uUp));

eli.nInd = isnan([Y U]);

eli.selInd = ~all(eli.nInd,2) & all(eli.uInd,2) & all(eli.yInd,2);
eli.elimInd = ~eli.selInd;

end