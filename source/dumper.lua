--// @java.dll
--// this code could be shortened down to 5 lines, but sorry for what you see now, I won't fix it lol XD

local dumper = {}

function dumper:__Dump()
    if not self.script.Parent then
        return
    end

    if not (self.script:IsA('ModuleScript') or self.script:IsA('LocalScript')) or typeof(self.script) ~= 'Instance' then
        return
    end

    local senv = getsenv(self.script)
    if not senv then
        return
    end

    for _, custom_unpack in senv do
        local fast_dump = '' :: string

        local success, error = pcall(function()
            fast_dump = dumpstring(self.script)
        end)

        if not success then
            warn('(IGNORED) error while unpack -> ' .. error)

            if error then
                break
            else
                continue
            end
        end

        local __DUMP = fast_dump

        if __DUMP:lower():find(self.key_word) then
            print(self.script, '->', __DUMP)
        end
    end
end

for _, script in getscripts() do
    dumper.__Dump({
        script = script,
        key_word = 'getserivce'
    })

    task.wait(0)
end

for _, module_script in getloadedmodules() do
    dumper.__Dump({
        script = module_script,
        key_word = 'getserivce'
    })
    
    task.wait(0)
end
