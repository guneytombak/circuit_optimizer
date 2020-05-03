function [offSp, outOfRange] = crossMutation(matSel, X, lims, specs)

%% Parameters

mSS = specs.mssMuSig;
recCoef = specs.recCoef;
loB = lims.xLo;
upB = lims.xUp;
N = specs.popSize;
p = specs.noXYU(1);

%% Initialize Offspring
offSp = zeros(N, p);
outOfRange = zeros(1,p);

%% Cross Mutation
for k = 1:2:N
    p1 = randi(N/2,1);
    p2 = randi(N/2,1);
    
    while p1 == p2 % not itself
        p2=randi(N/2,1);
    end
    offSp(k, :)= recCoef*X(matSel(p1),:)+(1-recCoef)*X(matSel(p2),:);
    offSp(k+1, :)= recCoef*X(matSel(p2),:)+(1-recCoef)*X(matSel(p1),:);
end


%% Mutation

mutStepSize = mSS(1) + mSS(2)*rand(1,N);
mutBool = rand(1,N) < mutStepSize;
mutIndex = mutBool .* randi(p,[1 N]);

for k = 1:N
    q = mutIndex(k);
    if q
        offSp(k,q) = loB(q) + (upB(q) - loB(q))*rand; % mutate
    end
end

%% Out of Range Parameter Correction

for k = 1:N % kth person qth parameter
    for q = 1:p
        if (offSp(k,q) > upB(q)) || (offSp(k,q) < loB(q)) % if off range
            outOfRange(q) = 1 + outOfRange(q); % count how many of them
            offSp(k,q) = loB(q) + (upB(q) - loB(q))*rand; % mutate
        end
    end
end

end
