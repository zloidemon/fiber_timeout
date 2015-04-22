#!/usr/bin/env tarantool
-- vim: set ft=lua

local fiber = require 'fiber'
local timeout = require 'fiber_timeout'
local test = (require 'tap').test()

function ftest(sleep, retval, exception)
    fiber.sleep(sleep)
    if retval == nil then
        box.error(box.error.PROC_LUA, exception)
    end
    return retval
end

test:plan(2)


test:test('test ftest', function(test)
    test:plan(2)
    test:is(ftest(0.1, 1), 1)
    local s, e = pcall(ftest, 0.1, nil, 'test exception')
    test:ok(not s, 'test exception')
end)

test:test('testing fiber_timeout', function(test)
    test:plan(6)
    test:is(false, timeout(0.1, ftest, 0.2, 123))
    test:ok(timeout(0.1, ftest, 0.01, 123))

    local s, e = pcall(timeout, 0.1, ftest, 0.01, nil, 'test exception')
    test:ok(not s, 'timeout')
    test:is(e, 'test exception')
    local s, e = pcall(timeout, 0.01, ftest, 0.1, nil, 'test exception')
    test:ok(s, 'timeout ok')
    test:is(e, false)
end)

test:check()
os.exit(0)
