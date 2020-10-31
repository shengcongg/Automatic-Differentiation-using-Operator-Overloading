mutable struct ADRev
    value::Float64
    derivative::Vector{Float64}
    derivativeOp::Function
    parents::Array{ADRev}
    count::Int64

    ADRev(val::Float64) = new(val, zeros(2), ad_constD, ADRev[], 0)
    ADRev(val::Float64, der::Float64) = new(val, der, ad_constD, ADRev[], 0)
end

function ad_constD(prevDerivative::Vector{Float64}, adNodes::Array{ADRev})
    return 0
end
