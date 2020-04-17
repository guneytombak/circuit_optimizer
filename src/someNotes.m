%% NSGA bad code

selR = [P; selFl];
sel = zeros(2*N,1);

for k = 1:N
    sel = sel + all(R == selR(k,:),2);
end

sel = sel > 0;