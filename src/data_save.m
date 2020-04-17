% last inputs
data.continuum = continuum;

% time
data.run_date = datetime;
data.run_duration = total_duration; % end of duration timer

% run specifications
data.specs = specs;

% titles
data.naming = naming;

% limits 
data.lims = lims;

% archive data
data.arch = arch;

% circuit data
data.ckt = ckt;

ymdStr = num2str(yyyymmdd(data.run_date));
[h,mi,s] = hms(data.run_date);

saveText = [ckt.name '_' ymdStr(3:end) '_' num2str(h) '-' num2str(mi)];

save(['../res/' saveText '.mat'], 'data');