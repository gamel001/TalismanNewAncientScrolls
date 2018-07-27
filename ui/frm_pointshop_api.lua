--**************
-- API
--**************

PointShopAPI = {};
function PointShopAPI.SelectItem (indexType, indexItem)

end

function PointShopAPI.GetDate()
	local ver, _, _ = uiPointShopGetInfo();
	if ver == nil then
		return;
	end
	local _argTable = {
		["version"] = ver,
	};
	RemoteCommand("point_shop", "getdata", "request", _argTable);
end







