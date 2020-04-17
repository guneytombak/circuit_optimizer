%% User Defined Options

if isempty(load_name)
    run(['../ins/' file_name '.m']);
else
    load(load_name);
end