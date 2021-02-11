push!(LOAD_PATH, "$(homedir())/.julia/dev")

using OhMyREPL
try
colorscheme!("GruvboxDark")
catch
end
