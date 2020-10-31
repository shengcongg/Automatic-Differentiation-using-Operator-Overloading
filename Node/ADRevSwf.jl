mutable struct ADRevSwf
    value::Float64
    derivative::Vector{Float64}
    derivativeOp::Function
    parents::Array{ADRevSwf}
    count::Int64

    ADRevSwf(val::Float64) = new(val, zeros(2), ad_constD, ADRevSwf[], 0)
    ADRevSwf(val::Float64, der::Vector{Float64}) = new(val, der, ad_constD, ADRevSwf[], 0)
end

function ad_constD(prevDerivative::Vector{Float64}, adNodes::Array{ADRevSwf})
    return 0
end
