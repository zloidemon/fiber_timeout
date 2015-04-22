package = 'fiber_timeout'
version = 'scm-1'
source  = {
    url    = 'git://github.com/zloidemon/fiber_timeout.git',
    branch = 'master',
}
description = {
    summary  = "Fiber timeout module",
    homepage = 'https://github.com/zloidemon/fiber_timeout.git',
    license  = 'BSD',
}
dependencies = {
    'lua >= 5.1'
}
build = {
    type = 'builtin',
    modules = {
        ['fiber_timeout'] = 'fiber_timeout.lua'
    }
}

-- vim: syntax=lua
