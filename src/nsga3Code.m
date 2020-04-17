%% Parameters

N = 100; % population size
dp = 10; % Number of points per axis
M = 3; % number of dimensions

R = abs(randn([2*N,3])); % pseudo results from the previous  

%% Reference Points (should be in the main code)

Z = linGrid(dp,M);
[Ni,M] = size(R);

%% New Population (S) and Last Front (Fl) 

initremi = 1:(Ni);
remi = initremi;

frontLabel = zeros(Ni,1);
noFr = 0;

while 1
    
    lenRem = length(remi);
    
    if lenRem <= (Ni - N)
        break;
    end
    
    noFr = noFr + 1;
    
    for i = 1:lenRem
        frontLabel(remi(i)) = noFr*(~any(all(R(remi(i),:)' > R(remi,:)')));
    end   
    
    remi = initremi(frontLabel == 0);
    
end

% P = S/Fl
indS = frontLabel > 0;
indP = frontLabel > 0 & frontLabel < noFr;
indFl = frontLabel == noFr;

S = R(indS,:); % all to be considered
P = R(indP,:); % selected fronts
Fl = R(indFl,:); % last front

[lenS,~] = size(S);
[lenP,~] = size(P);
[lenFl,~] = size(Fl);

K = N - lenP;

%% Normalization to [0 1]

maxS = max(S); % max
minS = min(S); % min
ranS = maxS - minS; %range

Sn = (S - minS)./ranS;
Pn = (P - minS)./ranS;
Fln = (Fl - minS)./ranS;

%% Association

lenZ = length(Z);

rho = zeros(lenZ, 1);

assocP = zeros(lenP, 1);
assocFl = zeros(lenFl, 1);
distFl = zeros(lenFl, 1);
gammaPn = zeros(lenP, 1);
gammaFln = zeros(lenFl, 1);

for k = 1:lenP
    
    p = Pn(k,:);
    g = gammaFind(p);
    gammaPn(k) = g;
    
    Zg = surfPoint(Z,g);
    
    distSq = sum((Zg - p).^2, 2);
    
    [~,selZ] = min(distSq);
    
    rho(selZ) = rho(selZ) + 1;
    
    assocP(k) = selZ;
    
end

for k = 1:lenFl
    
    f = Fln(k,:);
    g = gammaFind(f);
    gammaFln(k) = g;
    
    Zg = surfPoint(Z,g);
    
    distSq = sum((Zg - f).^2, 2);
    
    [distZ,selZ] = min(distSq);
    
    assocFl(k) = selZ;
    distFl(k) = distZ;
    
end

%% Niching

delZ = [];

k = 1;

avaiFl = true(lenFl,1);
avaiRho = true(lenZ,1);

while sum(~avaiFl) < K
    
    % finding min number of associations
    minRho = min(rho(avaiRho));
    Jmin = find((rho == minRho) & avaiRho);
    
    % random selection from mins
    lenJmin = length(Jmin);
    Jbar = Jmin(randi(lenJmin));
    
    % associated Fls
    Ibar = find((assocFl == Jbar) & avaiFl);
    
    if ~isempty(Ibar)
        if minRho == 0
            [~,fSel] = min(distFl(Ibar));
        else
            lenIbar = length(Ibar);
            fSel = Ibar(randi(lenIbar));
        end 
        avaiFl(fSel) = 0;
        rho(Jbar) = rho(Jbar) + 1;
    else
        avaiRho(Jbar) = 0;
    end
end

selFl = Fl(~avaiFl,:);
gammaSelFln = gammaFln(~avaiFl,:);

Znew = Z(rho > 0,:);

findFl = find(indFl);

sel = [find(indP); findFl(~avaiFl)];
hete = [rho(assocP); rho(assocFl(~avaiFl))];

findex.Fl = findFl;
findex.P = find(indP);
findex.selFl = findFl(~avaiFl);

gamma.P = gammaPn;
gamma.Fl = gammaFln;
gamma.selFl = gammaSelFln;
gamma.sel = [gammaPn; gammaSelFln];

nsgaData.R = R;
nsgaData.frontLabel = frontLabel(sel);
nsgaData.gamma = gamma;
nsgaData.findex = findex;
nsgaData.rho = rho;

scatter3(R(:,1),R(:,2),R(:,3),'.b');
hold on;
scatter3(P(:,1),P(:,2),P(:,3),'or');
scatter3(selFl(:,1),selFl(:,2),selFl(:,3),'og');
view(85,27)
hold off;