
push!(LOAD_PATH, "$(homedir())/.julia/dev")
push!(LOAD_PATH, "$(homedir())/work/ocean")
push!(LOAD_PATH, "$(homedir())/dev/ml-projects")

try
    using OhMyREPL
    using Revise
catch
    @warn "something is not installed"
end

