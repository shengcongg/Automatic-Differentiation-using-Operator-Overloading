import Base.+, Base.-, Base.*, Base./, Base.sin, Base.cos
include("../Node/ADRev.jl")

NumberADRev = Union{Number, ADRev}

# +++++++++++++++++++++++++++++++++
function adr_add(x::ADRev, y::ADRev)
    x.count += 1
    y.count += 1
    result = ADRev(x.value + y.value)
    result.derivativeOp = adr_addD
    push!(result.parents, x)
    push!(result.parents, y)
    return result
end
function adr_addD(prevDerivative::Vector{Float64}, adNodes::Array{ADRev})
    adNodes[1].derivative += prevDerivative * 1
    adNodes[2].derivative += prevDerivative * 1
    adNodes[1].count -= 1
    adNodes[2].count -= 1
    return
end
+(x::NumberADRev, y::NumberADRev) = adr_add(toRev(x), toRev(y))

# ----------------------------------
function adr_minus(x::ADRev, y::ADRev)
    x.count += 1
    y.count += 1
    result = ADRev(x.value - y.value)
    result.derivativeOp = adr_minusD
    push!(result.parents, x)
    push!(result.parents, y)
    return result
end
function adr_minusD(prevDerivative::Vector{Float64}, adNodes::Array{ADRev})
    adNodes[1].derivative += prevDerivative * 1
    adNodes[2].derivative += prevDerivative * (-1)
    adNodes[1].count -= 1
    adNodes[2].count -= 1
end
-(x::NumberADRev, y::NumberADRev) = adr_minus(toRev(x), toRev(y))

# ***********************************
function adr_mul(x::ADRev, y::ADRev)
    x.count += 1
    y.count += 1
    result = ADRev(x.value * y.value)
    result.derivativeOp = adr_mulD
    push!(result.parents, x)
    push!(result.parents, y)
    return result
end
function adr_mulD(prevDerivative::Vector{Float64}, adNodes::Array{ADRev})
    adNodes[1].derivative += prevDerivative * adNodes[2].value
    adNodes[2].derivative += prevDerivative * adNodes[1].value
    adNodes[1].count -= 1
    adNodes[2].count -= 1
    return
end
*(x::NumberADRev, y::NumberADRev) = adr_mul(toRev(x), toRev(y))

# ////////////////////////////////////////
function adr_divide(x::ADRev, y::ADRev)
    x.count += 1
    y.count += 1
    result = ADRev(x.value / y.value)
    result.derivativeOp = adr_divideD
    push!(result.parents, x)
    push!(result.parents, y)
    return result
end
function adr_divideD(prevDerivative::Vector{Float64}, adNodes::Array{ADRev})
    adNodes[1].derivative += prevDerivative / adNodes[2].value
    adNodes[2].derivative += prevDerivative * adNodes[1].value * (-1/(adNodes[2].value)^2)
    adNodes[1].count -= 1
    adNodes[2].count -= 1
end
/(x::NumberADRev, y::NumberADRev) = adr_divide(toRev(x), toRev(y))

# sin sin sin sin sin sin sin sin sin sin
function adr_sin(x::ADRev)
    x.count += 1
    result = ADRev(sin(x.value))
    result.derivativeOp = adr_sinD
    push!(result.parents, x)
    return result
end
function adr_sinD(prevDerivative::Vector{Float64}, adNodes::Array{ADRev})
    adNodes[1].derivative += prevDerivative * cos(adNodes[1].value)
    adNodes[1].count -= 1
end
sin(x::NumberADRev) = adr_sin(toRev(x))


# cos cos cos cos cos cos cos cos cos cos
function adr_cos(x::ADRev)
    x.count += 1
    result = ADRev(cos(x.value))
    result.derivativeOp = adr_cosD
    push!(result.parents, x)
    return result
end
function adr_cosD(prevDerivative::Vector{Float64}, adNodes::Array{ADRev})
    adNodes[1].derivative -= prevDerivative * sin(adNodes[1].value)
    adNodes[1].count -= 1
end
cos(x::NumberADRev) = adr_cos(toRev(x))


function toRev(x::NumberADRev)
    if (typeof(x) <: Number)
        x = ADRev(x)
    end
    return x
end
