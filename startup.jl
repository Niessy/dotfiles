push!(LOAD_PATH, "$(homedir())/.julia/dev")
push!(LOAD_PATH, "$(homedir())/work")

using OhMyREPL
colorscheme!("GruvboxDark")
using Revise
