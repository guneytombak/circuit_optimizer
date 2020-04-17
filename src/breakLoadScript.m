expGen = noGen;
noGen = gen - 1;

specs.gen = noGen;

preArch = arch;

arch.rX = preArch.rX(1:noGen,:,:);
arch.rUx = preArch.rUx(1:noGen,:,:);
arch.rY = preArch.rY(1:noGen,:,:);
arch.rUy = preArch.rUy(1:noGen,:,:);
%arch.rV = preArch.rV(1:noGen,:,:,:);

arch.X = preArch.X(1:noGen,:,:);
arch.Ux = preArch.Ux(1:noGen,:,:);
arch.Y = preArch.Y(1:noGen,:,:);
arch.Uy = preArch.Uy(1:noGen,:,:);
arch.gamma = preArch.gamma(1:noGen,:);

arch.outOfRange = preArch.outOfRange(1:noGen,:);

arch.err = cell(1,noGen);
arch.Z = cell(1,noGen);
arch.nsgaData = cell(1,noGen);

for k = 1:noGen
    arch.err{k} = preArch.err{k};
    arch.Z{k} = preArch.Z{k};
    arch.nsgaData{k} = preArch.nsgaData{k};
end

runDur = toc;

%% Parallel Computing Stop

delete(gcp('nocreate'));

%% Data Save

% last inputs
data.lastX = lastX;

% previous run time
data.preDate = preDate;
data.preDur = preDur;

% run duration
data.date = datetime;
data.runDur = runDur;

% total duration
data.duration = runDur + preDur;

% run specifications
data.param = specs;

% titles
data.title = titel;

% limits 
data.lims = lims;

% archive data
data.archive = arch;

% circuit data
data.cir = cir;

ymdStr = num2str(yyyymmdd(data.date));
[h,mi,s] = hms(data.date);

saveText = [ymdStr(3:end) '_' num2str(h) '-' num2str(mi)];

save(['./results/' saveText '.mat'], 'data');