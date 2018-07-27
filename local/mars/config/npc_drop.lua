function GetNpcMoneyAtt(nNpcLev, nUserLev, nDungeonId, nEctypeId)
if nDungeonId ~= 0 then
return 1
end

if nEctypeId ~= 0 then
if (nNpcLev + 55) <= nUserLev then
return 0
end

return 1
end

if (nNpcLev + 55) <= nUserLev then
return 0
end

if nNpcLev >= 1 and nNpcLev <= 39 then
return 0.3
end

if nNpcLev >= 40 and nNpcLev <= 70 then
return 0.7
end

return 1
end

function GetNpcExpAtt(nNpcLev, nUserLev, nDungeonId, nEctypeId)
if nDungeonId ~= 0 then
return 1
end

if nEctypeId ~= 0 and nNpcLev >= 14 then
return 1
end

if nNpcLev >= 1 and nNpcLev <= 39 then
return 0.2
end

if nNpcLev >= 40 and nNpcLev <= 70 then
return 0.6
end

return 1
end

function CanDropItem(nNpcLev, nUserLev, nDungeonId, nEctypeId, nDropType)
if nDropType >= 1 and nDropType <= 9 then
return 1
end

if nEctypeId ~= 0 then
if (nNpcLev + 10) <= nUserLev then
return 0
end

return 1
end

if (nNpcLev + 10) <= nUserLev then
return 0
end

return 1
end 
