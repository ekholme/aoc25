inp = "data/day2.txt"

line = readline(inp)

lines = split(line, ",")

mutable struct IdRange
    a::Integer
    b::Integer
end

function make_id_range(x::AbstractString)
    tmp = split(x, "-")
    a = parse(Int, tmp[1])
    b = parse(Int, tmp[2])

    return IdRange(a, b)
end

rngs = make_id_range.(lines)

zz = collect(rngs[1].a:rngs[1].b)

function split_compare(x::Int64)
    x_string = string(x)
    len = length(x_string)
    if len < 2
        return 0
    end

    mp = div(len, 2)

    x1 = x_string[begin:mp]
    x2 = x_string[mp+1:end]

    if x1 == x2
        return x
    else
        return 0
    end
end

r1 = split_compare.(zz)

function solve_p1(x::Vector{IdRange})
    len = length(x)
    r = Vector{Int64}(undef, len)

    for i ∈ eachindex(x)
        j = collect(x[i].a:x[i].b)
        y = split_compare.(j)
        r[i] = sum(y)
    end
    return sum(r)
end

p1 = solve_p1(rngs)

# part 2 ---------------


function split_compare2(x::Int64)
    x_string = string(x)
    len = length(x_string)
    if len < 2
        return 0
    end

    for i ∈ 1:div(len, 2)
        if mod(len, i) == 0
            j = x_string[begin:i]
            k = div(len, i)
            if x_string == repeat(j, k)
                return x
            end
        end
    end
    return 0
end

function solve_p2(x::Vector{IdRange})
    len = length(x)
    r = Vector{Int64}(undef, len)

    for i ∈ eachindex(x)
        j = collect(x[i].a:x[i].b)
        y = split_compare2.(j)
        r[i] = sum(y)
    end
    return sum(r)
end

p2 = solve_p2(rngs)