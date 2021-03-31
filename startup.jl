push!(LOAD_PATH, "$(homedir())/.julia/dev")
push!(LOAD_PATH, "$(homedir())/work/ocean")
push!(LOAD_PATH, "$(homedir())/dev/ml-projects")

using OhMyREPL
try
colorscheme!("GruvboxDark")
catch
end

using Revise
