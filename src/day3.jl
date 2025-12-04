using StatsBase

inp = "data/day3.txt"

lines = readlines(inp)

len = length(lines[1])

mutable struct Bank
    x::Vector{Int64}
end

function make_bank(x::String)
    tmp = parse.(Int, split(x, ""))
    return Bank(tmp)
end

banks = make_bank.(lines)

function get_joltage(b::Bank)
    x = b.x
    vals = sort(unique(x), rev=true)
    counts = countmap(x)

    #find the maximum
    m = vals[1]

    if m == x[end] && counts[m] > 1
        return parse(Int, (string(vals[1]) * string(vals[1])))
    elseif m == x[end]
        return parse(Int, (string(vals[2]) * string(vals[1])))
    else
        return parse(Int, (string(vals[1]) * string(vals[2])))
    end
end

p1 = sum(get_joltage.(banks))

# not correct -- troubleshoot later