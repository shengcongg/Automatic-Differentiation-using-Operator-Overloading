import Base.+, Base.-, Base.*, Base./, Base.sin, Base.cos
include("../Node/ADFwd.jl")

NumberADFwd= Union{Number, ADFwd}

function add(a::ADFwd, b::ADFwd)
    return ADFwd(a.value + b.value, a.derivative + b.derivative)
end
+(x::NumberADFwd, y::NumberADFwd) = add(toFwd(x), toFwd(y))

function minus(a::ADFwd, b::ADFwd)
    return ADFwdNode(a.value - b.value, a.derivative - b.derivative)
end
-(x::NumberADFwd, y::NumberADFwd) = minus(toFwd(x), toFwd(y))

function mul(a::ADFwd, b::ADFwd)
    return ADFwd(a.value * b.value, a.derivative * b.value + b.derivative * a.value)
end
*(x::NumberADFwd, y::NumberADFwd) = mul(toFwd(x), toFwd(y))

function divide(a::ADFwd, b::ADFwd)
    return ADFwd(a.value / b.value, a.derivative / b.value - a.value / (b.value^2)) # ?????????????
end
/(x::NumberADFwd, y::NumberADFwd) = divide(toFwd(x), toFwd(y))

function adf_sin(a::ADFwd)
    return ADFwd(sin(a.value), cos(a.value)*a.derivative) # ?????????????
end
sin(a::NumberADFwd) = adf_sin(toFwd(a))

function adf_cos(a::ADFwd)
    return ADFwd(cos(a.value), -sin(a.value)*a.derivative) # ?????????????
end
cos(a::NumberADFwd) = adf_cos(toFwd(a))


function toFwd(x)
    if (typeof(x) <: Number)
        x = ADFwd(x)
    end
    return x
end
