include("./Node/ADFwd.jl") # AD Node definition
include("./OO/OOADFwd.jl")  # overloaded operators
include("./f/index.jl") # function f
include("./config.jl")
println()

function ad_fwd(ff, xx)
    x = ADFwd[]
    n = length(xx)
    for i = 1:n
        push!(x, ADFwd(xx[i]))
    end
    df_dx = []
    # compute derivative of y and z respectively
    for i = 1:n
        x_copy = copy(x)
        x_copy[i] = ADFwd(x_copy[i].value, 1.0)
        res = ff(x_copy)
        push!(df_dx, map(node -> node.derivative, res))
    end
    return df_dx
end

xInput = ones(1, nInput)
@time a = ad_fwd(f, xInput)

println(a)
# println("df_dx")
# println(df_dx)
println("==========")
println()
