
local PointShopItemDisplayMaxCount = {
	TYPE = nil, -- [��Ʒ����]�ڽ�������ʾ����������
	ITEM = nil, -- [��Ʒ]�ڽ�������ʾ����������
	ITEMLINK = nil, -- [������Ʒ����]�ڽ�������ʾ����������
	ITEMCOL = nil,
};
local PointShopPromotionLabel = nil;
--���������б�
local PointShopPointTypes =
{
	0, -- ��ʯ
	1, -- ˮ��
	---1, -- ȫ��
	namelist =
	{
		"msg_point_shop_crystal_enter",
		"msg_point_shop_point_enter",
		--"$ȫ��$",
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
--��Ʒ����UIʵ���б�
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
--��ƷUIʵ���б�
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
--��ƷUIʵ���б�
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
-- ����ͼƬ�б�
local PointShopXMLPromotionImages = {
	ITEM_AREA = nil;
	PROMOTION_AREA = nil;
	ITEM_MODEL = nil;
};
--������
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

-- �̳ǽ��汻���ص�ʱ��[��Ʒ���ʹ���] (��XML��Ӧ��UIʵ��������Ӧ��table��)
function PointShop_frmShopTypes_OnLoad(self)

end

-- �̳ǽ��汻��ʾ��ʱ��
function PointShop_frmPointShop_OnShow(self)

end

-- �̳ǽ��汻���ص�ʱ��[��Ʒ����] (��XML��Ӧ��UIʵ��������Ӧ��table��)
function PointShop_frmItems_OnLoad(self)
	
end

-- �̳ǽ��汻���ص�ʱ��[��������] (��XML��Ӧ��UIʵ��������Ӧ��table��)
function PointShop_frmPromotion_OnLoad(self)
	
end

function PointShop_UpdateAllFrame ()
	
end

function PointShop_UpdatePoint (self)

end

--**************
-- ItemType
--**************

-- �û�ѡ����һ��[��Ʒ����]
function PointShopItemType_OnLClick(self)
	
end

-- ��������һ��[��Ʒ����]
function PointShopItemType_OnEnter(self)
end

-- �����̳ǽ��� [��Ʒ�����б�] ����ʾ
function PointShopItemType_Update()

end

function PointShopItemType_RollToSelected()
	
end

--**************
-- ItemShow
--**************

-- �û�ѡ����һ��[��Ʒ]
function PointShopItem_OnLClick(self)
	
end

-- ��������һ��[��ʾ��Ʒ]
function PointShopItem_OnEnter(self)
	
end

-- ������ѡ�����͵�����[��ʾ��Ʒ]
function PointShopItemShow_Update()

end

function PointShop_frmItems_lbItemPageControl_btPageUp_OnLClick(self)

end

function PointShop_frmItems_lbItemPageControl_btPageDown_OnLClick(self)

end

-- ����[��Ʒ��]������ͼƬ
function PointShopItemShow_SetPromotionImage(_image)

end

-- ����[��Ʒ��]�Ĺ���������ǰѡ����
function PointShopItemShow_RollToSelected()
	
end

--**************
-- ItemPromotion
--**************

function PointShopItemLink_OnLClick(self)
	
end

-- ������ѡ�����͵Ĺ������� (����:��Ʒ����)
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



