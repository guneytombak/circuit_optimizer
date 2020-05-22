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

save_text = [naming.file_name ...
            '_' ymdStr(3:end) '_' num2str(h) '-' num2str(mi)];

data.naming.save_text = save_text;

save_dir = ['../res/' ckt.name];
if ~exist(save_dir, 'dir')
   mkdir(save_dir);
end

save([save_dir  '/' save_text '.mat'], 'data');