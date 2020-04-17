function [G] = linGrid(dp,M)
% dp: number of divsion points
% M: number of dimensions

M = 3;

% number of points
H = nchoosek(M+dp-1,dp);

% initialization of matrix
G = zeros(H,M);

count = 0;

for c = 0:dp
    G((count+1):(count+dp-c+1),:) = [0:(dp-c);(dp-c):-1:0;c*ones(1,dp-c+1)]';
    count = count + dp - c + 1;
end

% normalization
G = G/dp;

end
