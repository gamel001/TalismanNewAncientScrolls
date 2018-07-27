
-- Ë¢ÐÂÖ¸¶¨×°±¸
function TemplateBtnOtherEquip_Refresh(self)
	local part = self:Get(EV_UI_EQUIP_PART_KEY);
	local id, classid = uiSeeEquipGetCurEquipItemByPart(part); -- »ñÈ¡´Ë²¿Î»µÄµ±Ç°×°±¸
	if id == nil or id == 0 or classid == nil or classid == 0 then
		self:Delete(EV_UI_SHORTCUT_OBJECTID_KEY);
		self:Delete(EV_UI_SHORTCUT_CLASSID_KEY);
		self:SetNormalImage(0); -- Çå³ýÍ¼±ê
	else
		self:Set(EV_UI_SHORTCUT_OBJECTID_KEY, id);
		self:Set(EV_UI_SHORTCUT_CLASSID_KEY, classid);
		local tableInfo = uiItemGetItemClassInfoByTableIndex(classid); -- µÀ¾ßµÄ¾²Ì¬ÐÅÏ¢
		self:SetNormalImage(SAPI.GetImage(tableInfo.Icon)); -- ÉèÖÃÍ¼±ê
	end
end
function layWorld_frmItemlookEx_modelOther_RefreshPart(self, part)
	uiInfo("layWorld_frmItemlookEx_modelOther_RefreshPart[ "..tostring(part).." ]")
	local model_pre = "SELF_SUB_MODEL";
	local path_pre = "SELF_SUB_PATH";
	if self == nil then self = uiGetglobal("layWorld.frmItemlookEx.modelOther") end
	local model= uiSeeEquipGetCurEquipModelByPart(part);
	local equip_mode, param = uiSeeEquipGetEquipParamByPart(part);
	if equip_mode == nil then return end
	if equip_mode == EV_EQUIP_MODE_LOAD_SKIN then
		self:UnloadSkin(model_pre..part);
		if model == nil or model[1] == nil then
			self:UnloadSkin(model_pre..part);
		else
			self:LoadSkin(model_pre..part, model[1]);
			uiInfo("SKIN="..model[1]);
		end
	elseif equip_mode == EV_EQUIP_MODE_LINK then
		local slot = param.Slot;
		for i, s in ipairs(slot) do
			local short_name = model_pre..part..i;
			if model == nil or model[i] == nil then
				self:UnlinkModel(short_name);
			else
				local m = model[i];
				self:LinkModel(m, short_name, s);
				uiInfo("LINK="..m);
			end
		end
	elseif equip_mode == EV_EQUIP_MODE_LINK_WITH_PATH then
		local path = param.Path;
		self:LinkModel(path.Name, path_pre, path.Slot);
		local slot = param.Slot;
		for i, s in ipairs(slot) do
			local short_name = model_pre..part..i;
			local full_name = path_pre.."."..short_name;
			if model == nil or model[1] == nil then
				self:UnlinkModel(full_name);
			else
				local m = model[1];
				self:LinkSubModel(m, short_name, s, path_pre);
				uiInfo("EV_EQUIP_MODE_LINK_WITH_PATH="..m);
			end
		end
	end
end
function layWorld_frmItemlookEx_modelOther_Refresh(self)
	if self == nil then self = uiGetglobal("layWorld.frmItemlookEx.modelOther") end
	self:ClearModel();
	self:SetCameraEye(0, -80, 50, true);
	self:SetCameraLookAt(0, 0, 25);
	self:SetCameraUp(0, 0, 1);
	local model = uiSeeEquipGetCurModel();
	uiInfo("model="..model);
	if model == nil then return end
	local head, hair = uiSeeEquipGetCurAppearance();
	if head == nil then return end
	self:SetModel(model);
	self:LoadSkin("head", head);
	self:LoadSkin("hair", hair);
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_MAINTRUMP);			--Ö÷·¨±¦
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_SUBTRUMP1);            --¸¨Öú·¨±¦1
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_SUBTRUMP2);            --¸¨Öú·¨±¦2
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_CLOTHING);             --¿ø¼×
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_GLOVE);                --ÊÖÌ×
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_SHOES);                --Ð¬×Ó
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_CUFF);                 --»¤Íó
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_KNEEPAD);              --»¤Ï¥
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_SASH);                 --Ñü´ø
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_RING1);                --½äÖ¸1
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_RING2);                --½äÖ¸2
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_AMULET1);              --»¤Éí·û1
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_AMULET2);              --»¤Éí·û2
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_PANTS);                --¿ã×Ó
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_CLOAK);                --Åû·ç
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_HELM);                 --Í·¿ø
	layWorld_frmItemlookEx_modelOther_RefreshPart(self, EV_EQUIP_PART_SHOULDER);             --»¤¼ç
end
-- Ë¢ÐÂËùÓÐ×°±¸
function TemplateBtnOtherEquip_RefreshAll()
	local form = uiGetglobal("layWorld.frmItemlookEx");
	for i = 0,13,1 do
		local btPart = SAPI.GetChild(form, "btPart"..i);
		TemplateBtnOtherEquip_Refresh(btPart); -- Öð¸öË¢ÐÂ
	end
	local modelOther = SAPI.GetChild(form, "modelOther");
	layWorld_frmItemlookEx_modelOther_Refresh(modelOther);
end
function TemplateBtnOtherEquip_OnLoad(self)
	self:RegisterScriptEventNotify("EVENT_SelfEnterWorld");
end
function TemplateBtnOtherEquip_OnEvent(self, event, Arg)
	if event == "EVENT_SelfEnterWorld" then
		local t_equip_part =
		{
			["btPart0"] = EV_EQUIP_PART_CLOTHING,	-- ¿ø¼×
			["btPart1"] = EV_EQUIP_PART_SASH,		--  Ñü´ø
			["btPart2"] = EV_EQUIP_PART_CUFF,		--  »¤Íó
			["btPart3"] = EV_EQUIP_PART_GLOVE,		--  ÊÖÌ×
			["btPart4"] = EV_EQUIP_PART_KNEEPAD,	--  »¤Ï¥
			["btPart5"] = EV_EQUIP_PART_MAINTRUMP,	--  Ö÷·¨±¦
			["btPart6"] = EV_EQUIP_PART_SUBTRUMP1,	--  ¸¨Öú·¨±¦
			["btPart7"] = EV_EQUIP_PART_SUBTRUMP2,	--  ¸¨Öú·¨±¦
			["btPart8"] = EV_EQUIP_PART_SHOES,		--  Ð¬×Ó
			["btPart9"] = EV_EQUIP_PART_AMULET1,	--  »¤Éí·û
			["btPart10"] = EV_EQUIP_PART_AMULET2,	--  »¤Éí·û
			["btPart11"] = EV_EQUIP_PART_RING1,		--  ½äÖ¸
			["btPart12"] = EV_EQUIP_PART_RING2,		--  ½äÖ¸
			["btPart13"] = EV_EQUIP_PART_PANTS,		--  ½äÖ¸
			["btPart14"] = EV_EQUIP_PART_CLOAK,		--  ½äÖ¸
		}
		local name = self:getShortName();
		self:Set(EV_UI_EQUIP_PART_KEY, t_equip_part[name]);
	end
end
-- ´¥·¢Hint
function TemplateBtnOtherEquip_OnHint(self)
	local part = self:Get(EV_UI_EQUIP_PART_KEY);
	if part == nil then self:SetHintRichText(0); return end
	local hint = uiSeeEquipGetEquipedItemHintByPart(part);
	if hint == nil then hint = 0 end
	self:SetHintRichText(hint);
end

function layWorld_frmItemlookEx_OnLoad(self)
	self:RegisterScriptEventNotify("EVENT_ItemSeeOtherEquipShow");
	self:RegisterScriptEventNotify("EVENT_OtherLeaveWorld");
end

function layWorld_frmItemlookEx_OnEvent(self, event, arg)
	if event == "EVENT_ItemSeeOtherEquipShow" then
		TemplateBtnOtherEquip_RefreshAll();
		self:ShowAndFocus();
	elseif event == "EVENT_OtherLeaveWorld" then
		if self:getVisible() == false then return end
		local ObjectId = arg[1];
		local CurObjectId = uiSeeEquipGetOtherObjectId();
		if CurObjectId == nil or CurObjectId == 0 or CurObjectId == ObjectId then
			self:Hide();
		end
	end
end

function layWorld_frmItemlookEx_OnShow(self)
	uiRegisterEscWidget(self);
end






