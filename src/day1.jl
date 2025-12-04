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
function count_p2(x::Vector{Int64}, start=50)
    r = 0
    s_prev = start

    for i ∈ eachindex(x)
        s_next = s_prev + x[i]

        # check for change in signs
        if s_prev * s_next < 0
            r += 1
        end

        z = abs(div(s_next, 100))
        r += z

        s_next = mod(s_next, 100)
        if s_next == 0
            r += 1
        end
        s_prev = s_next
    end
    return r
end

p2 = count_p2(yyy)
