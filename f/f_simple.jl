include("../Node/ADFwd.jl") # AD Fwd Node definition
include("../Node/ADRev.jl") # AD Rev Node definition
include("../Node/ADRevSwf.jl")

function f_num(x)
    a = 1.0
    # b = 1.0
    for i=1:length(x)
        y = (a + x[i]) + a
        a = y
    end
    return a
end

function f_fwd(x)
    a = ADFwd(1.0)
    # b = ADFwd(1.0)
    for i=1:length(x)
        y = a + x[i]
        a = y
    end
    return a
end

function f_rev(x::Array{ADRev})
    a = ADRev(1.0)
    # b = ADRev(1.0)
    for i=1:length(x)
        y = a + x[i]
        a = y
    end
    return a
end

function f_swf(X::Array{ADRevSwf})
    a = ADRevSwf(1.0)
    # b = ADRevSwf(1.0)
    for i = 1:length(X)
        y = a + x[i]
        a = y
    end
    return a
end
