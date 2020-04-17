function [iniX] = population_initialization(specs)

initSize = specs.iniPopMult*specs.popSize;

xLo = specs.lims.xLo;
xUp = specs.lims.xUp;

initSet = sobolset(specs.noXYU(1)); % Sobol Random Set with noX-Dim
initSet = scramble(initSet,'MatousekAffineOwen'); % Method for Scrambling
initSet = net(initSet,initSize); % Initial Set Construction

% Putting into Limits
iniX = (xUp - xLo).*initSet + xLo;

end
