function [Y, U] = simulation(X, ckt, ind)

%% Parameters
    
[N,noX] = size(X);

sim_file = ['../sim/' ckt.name '/' num2str(ind) '/' ckt.name];
par_file = ['../sim/' ckt.name '/' num2str(ind) '/param.cir'];
sys_ini = 'start/min/wait C:\synopsys\Hspice_A-2008.03\BIN\hspicerf.exe ';

%% Initialize

%%
for k = 1:N  % for each
    
    %% Write: Parameters
    
    fid_param = fopen(par_file);
    write_line= '.PARAM';
    dlmwrite(par_file, write_line, 'delimiter','');
    for m=1:noX
        write_line= ['+ ' char(ckt.input_parameters(m)) ...
            ' = ' char(num2str(X(k,m)))];
        dlmwrite(par_file, write_line, '-append','delimiter','');
    end
    fclose(fid_param);
    
    %% Run the Simulation
    
    system([sys_ini sim_file '.sp -o ' sim_file]);
    
    %% Read: Results
    
    read_line = '';
    
    for m = 1:length(ckt.ext)
        fid_out = fopen([sim_file ckt.ext{m}]);
        numLines = ckt.numLines{m};
        
        getl_count = 0; 
        while getl_count < max(numLines)
            getl_count = getl_count + 1;
            line_data = fgetl(fid_out);
            if any(getl_count == numLines)
                read_line = [read_line line_data];
            end
        end
        fclose(fid_out);
    end
    
    read_data = split(strtrim(read_line));    
    
    %% Calculation of Output Parameters
    
    Y(k,:) = ckt.y_func(read_data);
    U(k,:) = ckt.u_func(read_data);
    
end

end