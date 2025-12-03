inp = "data/day1.txt"

mutable struct Turn
    direction::String
    amount::Integer
end

lines = readlines(inp)

# split a line and assign it to a Turn struct
function split_turn(x::String)
    d = x[1:1]
    a = parse(Int, x[2:end])

    return Turn(d, a)
end

xxx = split_turn.(lines)

# coerce a turn to a numeric value using the direction
function coerce_turn(t::Turn)
    v = t.amount
    if t.direction == "L"
        v = -v
    end

    return v
end

yyy = coerce_turn.(xxx)

# count the number of times the dial lands at k, given a start at "start"
function count_combos(x::Vector{Int64}, start=50, k=0)
    r = 0
    s = start

    for i ∈ eachindex(x)
        s = s + x[i]
        s = mod(s, 100)
        if s == k
            r += 1
        end
    end

    return r
end

# part 1 ---------
res = count_combos(yyy)

# part 2 -----------
function count_passes(x::Vector{Int64}, start=50, k=0)
    r = 0
    s_raw = start
    n = length(x)
    j = Vector{Int64}(undef, n)

    get_k_cross_count(val, k_val) = floor(Int, (val - k_val) / 100)

    for i ∈ eachindex(x)
        s_prev_raw = s_raw

        s_raw += x[i]

        passes_this_spin = abs(get_k_cross_count(s_raw, k) - get_k_cross_count(s_prev_raw, k))
        r += passes_this_spin

        if passes_this_spin == 0 && mod(s_raw, 100) == k
            r += 1
        end

        j[i] = r
    end
    return r, j
end

p2, log = count_passes(yyy)
