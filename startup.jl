push!(LOAD_PATH, "$(homedir())/.julia/dev")
push!(LOAD_PATH, "$(homedir())/work/ocean/mirage")

using OhMyREPL
colorscheme!("GruvboxDark")
using Revise

# import REPL
# import REPL.LineEdit
#
# const mykeys = Dict{Any,Any}(
#     "F10" => "~",
# )
#
# function customize_keys(repl)
#     repl.interface = REPL.setup_interface(repl; extra_repl_keymap = mykeys)
# end
#
# atreplinit(customize_keys)
