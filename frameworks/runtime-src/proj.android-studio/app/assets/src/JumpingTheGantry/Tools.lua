local Tools = {}

local function checkNums(nums)
    local n = nums
    if n >= 0 then
        return n
    else
        n = 0 - n
        n = 0xffffffff - n + 1
    end
    return n
end
local function resultCover(n)
    local num = n
    if num >= 0x80000000 then
        num = num - 0xffffffff - 1
    end
    return num
end

function Tools.And(num1, num2)
    local tmp1 = checkNums(num1)
    local tmp2 = checkNums(num2)
    local ret = 0
    local count = 0
    repeat
        local s1 = tmp1 % 2
        local s2 = tmp2 % 2
        if s1 == s2 and s1 == 1 then
            ret = ret + 2 ^ count
        end
        tmp1 = math.modf(tmp1 / 2)
        tmp2 = math.modf(tmp2 / 2)
        count = count + 1
    until (tmp1 == 0 and tmp2 == 0)
    return resultCover(ret)
end

function Tools.Or(num1, num2)
    local tmp1 = checkNums(num1)
    local tmp2 = checkNums(num2)
    local ret = 0
    local count = 0
    repeat
        local s1 = tmp1 % 2
        local s2 = tmp2 % 2
        if s1 == s2 and s1 == 0 then

        else
            ret = ret + 2 ^ count
        end
        tmp1 = math.modf(tmp1 / 2)
        tmp2 = math.modf(tmp2 / 2)
        count = count + 1
    until (tmp1 == 0 and tmp2 == 0)
    return resultCover(ret)
end

function Tools.Xor(num1, num2)
    local tmp1 = checkNums(num1)
    local tmp2 = checkNums(num2)
    local ret = 0
    local count = 0
    repeat
        local s1 = tmp1 % 2
        local s2 = tmp2 % 2
        if s1 ~= s2 then
            ret = ret + 2 ^ count
        end
        tmp1 = math.modf(tmp1 / 2)
        tmp2 = math.modf(tmp2 / 2)
        count = count + 1
    until (tmp1 == 0 and tmp2 == 0)
    return resultCover(ret)
end
return Tools