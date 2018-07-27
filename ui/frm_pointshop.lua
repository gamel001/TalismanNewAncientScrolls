
local PointShopItemDisplayMaxCount = {
	TYPE = nil, -- [物品类型]在界面上显示的上限数量
	ITEM = nil, -- [物品]在界面上显示的上限数量
	ITEMLINK = nil, -- [促销物品链接]在界面上显示的上限数量
	ITEMCOL = nil,
};
local PointShopPromotionLabel = nil;
--点数类型列表
local PointShopPointTypes =
{
	0, -- 钻石
	1, -- 水晶
	---1, -- 全部
	namelist =
	{
		"msg_point_shop_crystal_enter",
		"msg_point_shop_point_enter",
		--"$全部$",
	},
	SelectedIndex = nil,
	GetCurPointType = function (self)
		return self[self.SelectedIndex];
	end,
	GetCurPointTypeName = function (self)
		return self.namelist[self.SelectedIndex];
	end,
	IsValid = function (self, type)
		if self.SelectedIndex == nil then return false end
		if self[self.SelectedIndex] == -1 then return true end
		return type == self[self.SelectedIndex];
	end
};
--物品类型UI实例列表
PointShopXMLTypes = {
	SelectedIndex = nil,
	SelectedHistory = {},
	Save = function (self)
		self.SelectedHistory[PointShopPointTypes.SelectedIndex] = self.SelectedIndex;
	end,
	Load = function (self)
		self.SelectedIndex = self.SelectedHistory[PointShopPointTypes.SelectedIndex];
	end,
	TypeList =
	{
		Clear = function (self)
			for i = 1, table.getn(self), 1 do
				table.remove(self, 1);
			end
		end,
	},
	GetTypeIndex = function (self, index)
		return self.TypeList[index];
	end,
	GetSelectedTypeIndex = function (self)
		if self.SelectedIndex == nil then return nil end
		return self.TypeList[self.SelectedIndex];
	end,
	FindTypeIndex = function (self, typeindex)
		for i, v in ipairs(self.TypeList) do
			if v == typeindex then return i end
		end
	end
};
--物品UI实例列表
PointShopXMLItems = {
	SelectedIndex = nil,
	SelectedHistory = {},
	Save = function (self)
		self.SelectedHistory[PointShopPointTypes.SelectedIndex] = self.SelectedIndex;
	end,
	Load = function (self)
		self.SelectedIndex = self.SelectedHistory[PointShopPointTypes.SelectedIndex];
	end,
};
--物品UI实例列表
local PointShopXMLItemLinks = {
	SelectedIndex = nil,
	SelectedHistory = {},
	Save = function (self)
		self.SelectedHistory[PointShopPointTypes.SelectedIndex] = self.SelectedIndex;
	end,
	Load = function (self)
		self.SelectedIndex = self.SelectedHistory[PointShopPointTypes.SelectedIndex];
	end,
	LinkList =
	{
		Clear = function (self)
			for i = 1, table.getn(self), 1 do
				table.remove(self, 1);
			end
		end,
	},
};
-- 宣传图片列表
local PointShopXMLPromotionImages = {
	ITEM_AREA = nil;
	PROMOTION_AREA = nil;
	ITEM_MODEL = nil;
};
--滚动条
local PointShopXMLScrolls = {
	TYPE_V = nil,
	ITEM_V = nil,
	SelectedHistory_TYPE_V = {},
	SelectedHistory_ITEM_V = {},
	Save = function (self)
		if self.TYPE_V then
			self.SelectedHistory_TYPE_V[PointShopPointTypes.SelectedIndex] = self.TYPE_V:getValue();
		end
		if self.ITEM_V then
			self.SelectedHistory_ITEM_V[PointShopPointTypes.SelectedIndex] = self.ITEM_V:getValue();
		end
	end,
	Load = function (self)
		if self.TYPE_V and self.SelectedHistory_TYPE_V[PointShopPointTypes.SelectedIndex] then
			self.TYPE_V:SetValue(self.SelectedHistory_TYPE_V[PointShopPointTypes.SelectedIndex]);
		end
		if self.ITEM_V then
			self.ITEM_V:SetValue(self.SelectedHistory_ITEM_V[PointShopPointTypes.SelectedIndex]);
		end
	end,
};

-- 商城界面被加载的时候[物品类型窗口] (把XML对应的UI实例放入相应的table中)
function PointShop_frmShopTypes_OnLoad(self)

end

-- 商城界面被显示的时候
function PointShop_frmPointShop_OnShow(self)

end

-- 商城界面被加载的时候[物品窗口] (把XML对应的UI实例放入相应的table中)
function PointShop_frmItems_OnLoad(self)
	
end

-- 商城界面被加载的时候[促销窗口] (把XML对应的UI实例放入相应的table中)
function PointShop_frmPromotion_OnLoad(self)
	
end

function PointShop_UpdateAllFrame ()
	
end

function PointShop_UpdatePoint (self)

end

--**************
-- ItemType
--**************

-- 用户选择了一个[物品类型]
function PointShopItemType_OnLClick(self)
	
end

-- 鼠标进入了一个[物品类型]
function PointShopItemType_OnEnter(self)
end

-- 更新商城界面 [物品类型列表] 的显示
function PointShopItemType_Update()

end

function PointShopItemType_RollToSelected()
	
end

--**************
-- ItemShow
--**************

-- 用户选择了一个[物品]
function PointShopItem_OnLClick(self)
	
end

-- 鼠标进入了一个[显示物品]
function PointShopItem_OnEnter(self)
	
end

-- 更新已选择类型的所有[显示物品]
function PointShopItemShow_Update()

end

function PointShop_frmItems_lbItemPageControl_btPageUp_OnLClick(self)

end

function PointShop_frmItems_lbItemPageControl_btPageDown_OnLClick(self)

end

-- 设置[物品区]的宣传图片
function PointShopItemShow_SetPromotionImage(_image)

end

-- 设置[物品区]的滚动条到当前选中项
function PointShopItemShow_RollToSelected()
	
end

--**************
-- ItemPromotion
--**************

function PointShopItemLink_OnLClick(self)
	
end

-- 更新已选择类型的关联内容 (包括:商品链接)
function PointShopItemPromotion_Update()

end

function PointShopItemBuy_OnLClick(self)
	
end

function PointShopItemBuy_OnTextChanged(self)
	
end

function PointShop_frmPointShop_OnLoad(self)
	self:RegisterScriptEventNotify("point_shop_update");
	self:RegisterScriptEventNotify("EVENT_TogglePointShop");
	self:RegisterScriptEventNotify("EVENT_ToggleCrystalShop");
	self:RegisterScriptEventNotify("EVENT_LocalGurl");
end

function PointShop_frmPointShop_OnEvent(self, event, args)
	
end

function layWorld_frmPointShop1_btSwitchShop_OnLClick(self)
	
end

function layWorld_frmPointShop1_SetPointType(select)

end

function PointShop_BuyInputBox_Ok_OnLClick(self)
	
end

function layWorld_PointShopBuyInputBox_OnShow(self)
	
end



