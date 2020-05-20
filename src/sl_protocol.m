sl_name = specs.slp.file_name;

load(['../slp/' file_name '/' sl_name]);

specs.slp = slp;
specs.slp.file_name = sl_name;