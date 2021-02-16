push!(LOAD_PATH, "$(homedir())/.julia/dev")
push!(LOAD_PATH, "$(homedir())/work")

using OhMyREPL
try
colorscheme!("GruvboxDark")
catch
end

# using Revise
