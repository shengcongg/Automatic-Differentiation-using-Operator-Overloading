include("./f/index.jl")
include("./config.jl")
# f = FFFF.f
using LinearAlgebra
println()

function timing1(ff, xx)
    n = length(xx)
    h = 1e-5
    df_dx = []
    # df_dx = Array{Float64,2}(undef, 2, nums)
    for i = 1:n
        e = zeros(1, n)
        e[i] += 1.0
        df_dxi = (ff(xx + h * e) - ff(xx)) / h
        push!(df_dx, df_dxi)
        # df_dx[:, i] = ((f_num(x + h * e) - f_num(x)) / h)
    end
    return df_dx
end

function timing2(ff, xx)
    n = length(xx)
    h = 1e-5
    # df_dx = []
    df_dx = Array{Float64,2}(undef, 2, n)
    e = Matrix(1.0I, n, n)
    for i = 1:n
        df_dxi = (ff(xx + h * transpose(e[:,i])) - ff(xx)) / h
        # push!(df_dx, df_dxi)
        df_dx[:, i] = df_dxi
    end
    return df_dx
end

x = ones(1, nInput)
@time a = timing1(f, x)
@time b = timing2(f, x)

# println(a)
# println(transpose(b))
# println("========")
