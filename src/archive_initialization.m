arch.rX = zeros(noGen,2*N,noX);
arch.rY = zeros(noGen,2*N,noY);
arch.rU = zeros(noGen,2*N,noU);
arch.eli = cell(1,noGen);

arch.X = zeros(noGen,N,noX);
arch.Y = zeros(noGen,N,noY);
arch.U = zeros(noGen,N,noU);

arch.Z = cell(1,noGen);
arch.nsgaData = cell(1,noGen);
arch.outOfRange = zeros(noGen,noX);