include("../Node/ADFwd.jl") # AD Fwd Node definition
include("../Node/ADRev.jl") # AD Rev Node definition
include("../Node/ADRevSwf.jl")

function f(x)
    a = 1.0
    b = 1.0
    for i=1:length(x)
        y = a + b
        z = x[i] + a * b
        a = y
        b = z
    end
    return [a; b]
end

function f_rev(x::Array{ADRev})
    a = ADRev(1.0)
    b = ADRev(1.0)
    for i=1:length(x)
        y = a + b
        z = a * b + x[i]
        a = y
        b = z
    end
    return [a; b]
end

function f_swf(X::Array{ADRevSwf})
    a = ADRevSwf(1.0)
    b = ADRevSwf(1.0)
    for i = 1:length(X)
        y = a + b
        z = a * b + X[i]
        a = y
        b = z
    end
    return [a; b]
end
