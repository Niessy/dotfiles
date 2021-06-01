push!(LOAD_PATH, "$(homedir())/.julia/dev")
push!(LOAD_PATH, "$(homedir())/work/ocean")
push!(LOAD_PATH, "$(homedir())/dev/ml-projects")

try
    using Revise
    using OhMyREPL
catch e
    @warn "Error initializing" exception=(e, catch_backtrace())
end
