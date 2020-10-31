mutable struct ADFwd
    value::Float64
    derivative::Float64
    ADFwd(val::Float64) = new(val, 0)
    ADFwd(val::Float64, der::Float64) = new(val, der)
end
