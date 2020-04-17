set(0,'defaulttextInterpreter','latex')

dp = 30; M = 3;

% number of points
H = nchoosek(M+dp-1,dp);

% initialization of matrix
Z = zeros(H,M);

count = 0;

for c = 0:dp
    Z((count+1):(count+dp-c+1),:) = [0:(dp-c);(dp-c):-1:0;c*ones(1,dp-c+1)]';
    count = count + dp - c + 1;
end

% normalization
Z = Z/dp;

figure;
subplot(121)
scatter3(Z(:,1),Z(:,2),Z(:,3),'.b');
subplot(122)
scatter3(-Z(:,1),-Z(:,2),Z(:,3),'.r');