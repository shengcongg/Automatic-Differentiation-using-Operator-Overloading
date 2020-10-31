import Base.+, Base.-, Base.*, Base./, Base.sin, Base.cos
include("../Node/ADRevSwf.jl")

# +++++++++++++++++++++++++++++++++
function adr_add(x::ADRevSwf, y::ADRevSwf)
    x.count += 1
    y.count += 1
    result = ADRevSwf(x.value + y.value)
    result.derivativeOp = adr_addD
    push!(result.parents, x)
    push!(result.parents, y)
    return result
end
function adr_addD(prevDerivative::Vector{Float64}, adNodes::Array{ADRevSwf})
    adNodes[1].derivative += prevDerivative * 1
    adNodes[2].derivative += prevDerivative * 1
    adNodes[1].count -= 1
    adNodes[2].count -= 1
    return
end
+(x::ADRevSwf, y::ADRevSwf) = adr_add(x, y)

# ----------------------------------
function adr_minus(x::ADRevSwf, y::ADRevSwf)
    x.count += 1
    y.count += 1
    result = ADRevSwf(x.value - y.value)
    result.derivativeOp = adr_minusD
    push!(result.parents, x)
    push!(result.parents, y)
    return result
end
function adr_minusD(prevDerivative::Vector{Float64}, adNodes::Array{ADRevSwf})
    adNodes[1].derivative += prevDerivative * 1
    adNodes[2].derivative += prevDerivative * (-1)
    adNodes[1].count -= 1
    adNodes[2].count -= 1
end
-(x::ADRevSwf, y::ADRevSwf) = adr_minus(x,y)

# ***********************************
function adr_mul(x::ADRevSwf, y::ADRevSwf)
    x.count += 1
    y.count += 1
    result = ADRevSwf(x.value * y.value)
    result.derivativeOp = adr_mulD
    push!(result.parents, x)
    push!(result.parents, y)
    return result
end
function adr_mulD(prevDerivative::Vector{Float64}, adNodes::Array{ADRevSwf})
    adNodes[1].derivative += (prevDerivative * adNodes[2].value)
    adNodes[2].derivative += (prevDerivative * adNodes[1].value)
    adNodes[1].count -= 1
    adNodes[2].count -= 1
    return
end
*(x::ADRevSwf, y::ADRevSwf) = adr_mul(x, y)

# ////////////////////////////////////////
function adr_divide(x::ADRevSwf, y::ADRevSwf)
    x.count += 1
    y.count += 1
    result = ADRevSwf(x.value / y.value)
    result.derivativeOp = adr_divideD
    push!(result.parents, x)
    push!(result.parents, y)
    return result
end
function adr_divideD(prevDerivative::Vector{Float64}, adNodes::Array{ADRevSwf})
    adNodes[1].derivative += prevDerivative / adNodes[2].value
    adNodes[2].derivative += prevDerivative * adNodes[1].value * (-1 / (adNodes[2].value) ^ 2)
    adNodes[1].count -= 1
    adNodes[2].count -= 1
end
/(x::ADRevSwf, y::ADRevSwf) = adr_divide(x,y)

# sin sin sin sin sin sin sin sin sin sin
function adr_sin(x::ADRevSwf)
    x.count += 1
    result = ADRevSwf(sin(x.value))
    result.derivativeOp = adr_sinD
    push!(result.parents, x)
    return result
end
function adr_sinD(prevDerivative::Vector{Float64}, adNodes::Array{ADRevSwf})
    adNodes[1].derivative += (prevDerivative * cos(adNodes[1].value))
    adNodes[1].count -= 1
end
sin(x::ADRevSwf) = adr_sin(x)


# cos cos cos cos cos cos cos cos cos cos
function adr_cos(x::ADRevSwf)
    x.count += 1
    result = ADRevSwf(cos(x.value))
    result.derivativeOp = adr_cosD
    push!(result.parents, x)
    return result
end
function adr_cosD(prevDerivative::Vector{Float64}, adNodes::Array{ADRevSwf})
    adNodes[1].derivative -= prevDerivative * sin(adNodes[1].value)
    adNodes[1].count -= 1
end
cos(x::ADRevSwf) = adr_cos(x)
