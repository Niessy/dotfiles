push!(LOAD_PATH, "$(homedir())/.julia/dev")
push!(LOAD_PATH, "$(homedir())/work/ocean/mirage")

using OhMyREPL
colorscheme!("GruvboxDark")
using Revise
