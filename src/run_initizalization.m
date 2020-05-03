if isempty(load_name)
    preGen = -1; % no previous generation
    iniX = population_initialization(specs);
    Z = linGrid(specs.refDen, specs.noXYU(2));
    if specs.au_flag
        au_protocol;
    end
else
    preGen = preData.noGen;
    iniX = preData.continuum.X;
    Z = preData.continuum.Z;
end

gen = preGen; % generation count


