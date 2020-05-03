%% User Defined Options

if isempty(load_name)
    run(['../ins/' file_name '.m']);
    default_options;
else
    load(load_name);
end