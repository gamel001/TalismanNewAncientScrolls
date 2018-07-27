--PVP System Entry
--Code by jin.Wang
local frCreateRoomExType=1;
function layWorld_frCreateRoomEx_OnLoad(self)    
end

function layWorld_frCreateRoomEx_OnEvent(self,event,arg)
end

function layWorld_frCreateRoomEx_OnShow(self)
   uiRegisterEscWidget(self);
   layWorld_frCreateRoomEx_Show(frCreateRoomExType);
end

function layWorld_frCreateRoomEx_SetType(itype)
   frCreateRoomExType=itype;
end

--选择方式
function layWorld_frCreateRoomEx_cbChooseStyle_OnUpdateText(self)
    local frCreateRoomEx=uiGetglobal("layWorld.frCreateRoomEx");    
    local cbChooseMap=SAPI.GetChild(frCreateRoomEx,"cbChooseMap");
    if self:getSelectItemIndex()==0 then
        cbChooseMap:SelectItem(0);
        layWorld_frCreateRoomEx_cbChooseMap_content(3);
    end
end

--选择地图
function layWorld_frCreateRoomEx_cbChooseMap_OnUpdateText(self)

end

function layWorld_frCreateRoomEx_cbChooseMap_content(idx)
    local frCreateRoomEx=uiGetglobal("layWorld.frCreateRoomEx");
    local edbStyleIntroduction = SAPI.GetChild(frCreateRoomEx,"edbStyleIntroduction");
    local edbMapIntroduction = SAPI.GetChild(frCreateRoomEx,"edbMapIntroduction");
    local edbSetLevel=SAPI.GetChild(frCreateRoomEx,"edbSetLevel");
    local setting=uiGetDungeonSetting();
    local pvemin=setting["PVE_LEV"];
    local pvpmin=("61");

     
    if idx == 3 then
        edbStyleIntroduction:SetText(uiLanString("msg_dungeon_txt2"));
        edbMapIntroduction:SetText(uiLanString("msg_dungeon_map2"));
	edbSetLevel:SetText(tostring(pvpmin));
    end  

end

function layWorld_frCreateRoomEx_Show(idx)
    --idx 类型
    local frCreateRoomEx=uiGetglobal("layWorld.frCreateRoomEx");
    local edbEnterRoomName=SAPI.GetChild(frCreateRoomEx,"edbEnterRoomName");
    local cbChooseStyle=SAPI.GetChild(frCreateRoomEx,"cbChooseStyle");
    local cbChooseMap=SAPI.GetChild(frCreateRoomEx,"cbChooseMap");
    local edbEnterPassword=SAPI.GetChild(frCreateRoomEx,"edbEnterPassword");
    local edbSetLevel=SAPI.GetChild(frCreateRoomEx,"edbSetLevel");

    local setting=uiGetDungeonSetting();
    local pvpmin=("61");

	local name, party, sex = uiGetMyInfo("Role")
    --房间名字
    edbEnterRoomName:SetText(name.."'s Room");

    cbChooseStyle:RemoveAllItems();
    cbChooseMap:RemoveAllItems();
    edbEnterPassword:SetText("");

    cbChooseStyle:SetEnableInput(false);
    cbChooseStyle:AddItem(uiLanString("msg_dungeon_type2"),0);

    
    cbChooseMap:SetEnableInput(false);
    cbChooseMap:Disable();
    cbChooseMap:AddItem(uiLanString("msg_dungeon_type2"),0);

        edbSetLevel:SetText(tostring(pvpmin));
        cbChooseStyle:SelectItem(0);
        cbChooseMap:SelectItem(0);
 
    layWorld_frCreateRoomEx_cbChooseMap_content(idx);
    
end

--创建房间
function layWorld_frCreateRoomEx_btConfirm_OnLClick(self)   
    local frCreateRoomEx=uiGetglobal("layWorld.frCreateRoomEx");
    local edbEnterRoomName=SAPI.GetChild(frCreateRoomEx,"edbEnterRoomName");
    local cbChooseStyle=SAPI.GetChild(frCreateRoomEx,"cbChooseStyle");
    local cbChooseMap=SAPI.GetChild(frCreateRoomEx,"cbChooseMap");
    local edbEnterPassword=SAPI.GetChild(frCreateRoomEx,"edbEnterPassword");
    local edbSetLevel=SAPI.GetChild(frCreateRoomEx,"edbSetLevel");
    local setting=uiGetDungeonSetting();
    local pvpmin=("61");

    local itype;
    if cbChooseStyle:getSelectItemIndex() == 0 then
        itype=3;
    else
        return;
    end
	
    local strerror2=string.format(uiLanString("msg_dungeon_min_level"),tostring(pvpmin));
	local level, curexp, maxexp = uiGetMyInfo("Exp");
    if tonumber(level)<tonumber(pvpmin) then
	    uiClientMsg(strerror2,true);
	    return;
    end
	
    local roomtitle=edbEnterRoomName:getText();
    if  tostring(roomtitle)~="" then
        uiDungeonCreateRoom(roomtitle,itype,tonumber(edbSetLevel:getText()),edbEnterPassword:getText());
    end
end

--关闭
function layWorld_frCreateRoomEx_btCancel_OnLClick(self)
    local frCreateRoomEx=uiGetglobal("layWorld.frCreateRoomEx");
    frCreateRoomEx:Hide();
end