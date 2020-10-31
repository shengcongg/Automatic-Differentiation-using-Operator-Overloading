# a slightly different reverse mode implementation for comparison
include("./Node/ADRevSwf.jl") # AD Node definition
include("./OO/OORevSwf.jl")  # overloaded operators
include("./f/index.jl") # function f
include("./config.jl")

function chainRule(graph::Vector{ADRevSwf})
    current = graph
    for i = 1:length(current)
        current[i].derivative[i] = 1
    end
    front = current
    while length(front) > 0
        current = pop!(front)
        current.derivativeOp(current.derivative, current.parents)
        for i = 1:length(current.parents)
            if (current.parents[i].count == 0)
                push!(front, current.parents[i])
            end
        end
    end
    return graph
end

function swift(ff, xx)
    x_swf = ADRevSwf[]
    n = length(xx)
    for i = 1:n
        push!(x_swf, ADRevSwf(xx[i]))
    end

    eRev_forward = ff(x_swf)
    e = chainRule(eRev_forward)
    df_dX = map(node -> node.derivative, x_swf)
    return df_dX
end

xInput = ones(1, nInput)
@time a = swift(f_swf, xInput)
# println(a)
# println("df_dX")
# println(df_dX)
println("==========")
println()
