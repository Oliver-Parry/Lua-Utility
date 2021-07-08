function tableToString(t)
    local str  = ''
    local tabs = 0
    local searchTable
    searchTable = function(t)
        t['__metatable'] = getmetatable(t)
        str = str.."{\n"
        tabs = tabs + 1
        for i, v in pairs(t) do
            str=str..string.rep("\t",tabs).."["..(type(i)=='string'and'\''or'')..tostring(i)..(type(i)=='string'and'\''or'').."] = "
            
            if type(v) == "table" then
                searchTable(v)
            else
                str=str..(type(v)=='string'and('\''..string.gsub(v,'\n','\\n')..'\'')or(tostring(v)))..'; <'..type(v)..'>\n'
            end
        end
        tabs = tabs - 1
        str = str..string.rep("\t",tabs).."};\n"
        return string.sub(str, 1, string.len(str)-2)
    end
    return searchTable(t)
end
return tableToString
