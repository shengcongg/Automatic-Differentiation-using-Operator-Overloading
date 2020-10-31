include("./Node/ADRev.jl") # AD Node definition
include("./OO/OOADRev.jl")  # overloaded operators
include("./f/index.jl") # function f
include("./config.jl")

function chainRule(graph::Vector{ADRev})
    current = graph
    for i = 1:length(current)
        current[i].derivative[i] = 1
    end
    frontier = current
    while length(frontier) > 0
        current = pop!(frontier)
        current.derivativeOp(current.derivative, current.parents)
        for i = 1:length(current.parents)
            if (current.parents[i].count == 0)
                push!(frontier, current.parents[i])
            end
        end
    end
    return graph
end

function ad_rev(ff, xx)
    # parse inputs as Nodes
    X = ADRev[]
    n = length(xx)
    for i = 1:n
        push!(X, ADRev(xx[i]))
    end
    eRev_forward = ff(X)
    e = chainRule(eRev_forward)
    df_dX = map(node -> node.derivative, X)
    return df_dX
end

xInput = ones(1, nInput)
@time a = ad_rev(f, xInput)
# df_dX = transpose(df_dX)
# println(a)
# println("df_dX")
# println(df_dX)
println("==========")
println()
