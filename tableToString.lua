return function(t)
    local s = ""
    local tabs = 0
    function searchTable(t)
        s = s.."{\n"
        tabs = tabs + 1
        for i, v in pairs(t) do
            if type(i) == "string" then
                s = s..string.rep("    ", tabs).."['"..tostring(i).."'] = "
            else
                s = s..string.rep("    ", tabs).."["..tostring(i).."] = "
            end
            
            if type(v) == "table" then
                searchTable(v)
            elseif type(v) == "string" then
                s = s.."'"..string.gsub(v, "\n", "\\n").."';".."\n"
            elseif type(v) == "userdata" and typeof(v) == "Instance" then
                s = s..v:GetFullName()..";\n"
            elseif typeof(v) == "Vector3" then
                s = s.."Vector3.new("..tostring(v)..");\n"
            elseif typeof(v) == "CFrame" then
                s = s.."CFrame.new("..tostring(v)..");\n"
            elseif typeof(v) == "Color3" then
                s = s.."Color3.fromRGB("..tostring(v)..");\n"
            elseif typeof(v) == "BrickColor" then
                s = s.."BrickColor.new("..tostring(v)..");\n"
            elseif typeof(v) == "Enum" or typeof(v) == "EnumItem" or typeof(v) == "Enums" then
                s = s..tostring(v)..";\n"
            elseif typeof(v) == "Ray" then
                s = s.."Ray.new(Vector3.new("..tostring(v.Origin).."), Vector3.new("..tostring(v.Direction).."));\n"
            elseif typeof(v) == "TweenInfo" then
                s = s.."TweenInfo.new(.."..tostring(v)..");\n"
            else
                s = s..tostring(v)..";\n"
            end
        end
        tabs = tabs - 1
        s = s..string.rep("    ", tabs).."};\n"
        return string.sub(s, 1, string.len(s)-2)
    end
    
    return searchTable(t)
end
