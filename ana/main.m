load_name = 'amp_200415_19-11.mat';

load(['../res/' load_name]);

N = [200];

figure(1);
genscat3(data,N);



