include("../Node/ADFwd.jl") # AD Fwd Node definition
include("../Node/ADRev.jl") # AD Rev Node definition
include("../Node/ADRevSwf.jl")

function f(x)
    a = 1
    b = 1
    for i = 1:length(x)
        y = 0.3 * sin(a) + 0.4 * b
        z = 0.1 * a + 0.3 * cos(b) + x[i]
        a = y
        b = z
    end
    return [a; b]
end

function f_rev(x::Array{ADRev})
    a = ADRev(1.0)
    b = ADRev(1.0)
    for i=1:length(x)
        y = ADRev(0.3)*sin(a) + ADRev(0.4)*b
        z = ADRev(0.1)*a + ADRev(0.3)*cos(b) + x[i]
        a = y
        b = z
    end
    return [a; b]
end

function f_swf(X::Array{ADRevSwf})
    a = ADRevSwf(1.0)
    b = ADRevSwf(1.0)
    for i = 1:length(X)
        y = ADRevSwf(0.3) * sin(a) + ADRevSwf(0.4) * b
        z = X[i] + ADRevSwf(0.1) * a + ADRevSwf(0.3) * cos(b)
        a = y
        b = z
    end
    return [a; b]
end
