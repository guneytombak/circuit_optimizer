for k = 1:pll.numWorkers
    folder_directory = ['../sim/' ckt.name '/' num2str(k)];
    if ~exist(folder_directory, 'dir')
       mkdir(folder_directory);
    end
    edit([folder_directory '/param.cir']);
    copyfile(['../ins/' ckt.name '.sp'], folder_directory, 'f');
    
    for m = 1:length(ckt.inc)
        copyfile(['../ins/' ckt.inc{m}], folder_directory, 'f');
    end
end

