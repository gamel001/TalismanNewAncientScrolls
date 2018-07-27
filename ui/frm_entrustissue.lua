local m_tTypeInfo = {}
local m_fConsignFee = 10
--local EV_UI_SHORTCUT_OWNER_CONSIGN = 13

--[ Retrive the task list ]
function layWorld_frmEntrustissue_getConsignInfo()
	local m_typeName1 = uiLanString("consign_type1")
	local m_typeName2 = uiLanString("consign_type2")
	--uiInfo("layWorld_frmEntrustissue_getConsignInfo begin......" )
	m_tTypeInfo[m_typeName1] = {}
	m_tTypeInfo[m_typeName2] = {}
	local mTaskList = uiTaskGetTaskList()
	for idx, t in pairs( mTaskList ) do
		for k, v in ipairs(t) do
			local strID = v["Id"]
			local strFlag = v["SpecialFlag"]
			local strName = v["Name"]
			local bIsConsign = v["IsConsign"]
			local numID = tonumber(v["Id"])
			if numID == nil then
				numID = 0
			end
			--uiInfo("TaskName:"..strName.." Consign:"..tostring(bIsConsign).." uiConsignIsTaskConsign:"..tostring(uiConsignIsTaskConsign(numID)) )
			if bIsConsign and uiConsignIsTaskConsign(numID)==false then
				if tonumber(strFlag) == 11 then
					m_tTypeInfo[m_typeName1][table.getn(m_tTypeInfo[m_typeName1])+1] = {strID,strName}
				else
					m_tTypeInfo[m_typeName2][table.getn(m_tTypeInfo[m_typeName2])+1] = {strID,strName}
				end
			end
		end
	end
	
	local max1 = 0
	local max2 = 0
	max1, max2 , m_fConsignFee = uiConsignGetConfig()
	local m_numGold = math.floor( m_fConsignFee/10000 )
	local m_numSilver = math.floor( math.mod(m_fConsignFee,10000)/100 )
	local m_numCopper = math.floor( math.mod( m_fConsignFee, 100 ) )
	local m_labFeegold = uiGetglobal( "layWorld.frmEntrust.lbprocedurefeegold" )
	m_labFeegold:SetText( tostring(m_numGold) )
	local m_labFeesilver = uiGetglobal( "layWorld.frmEntrust.lbprocedurefeesilver" )
	m_labFeesilver:SetText( tostring(m_numSilver) )
	local m_labFeecopper = uiGetglobal( "layWorld.frmEntrust.lbprocedurefeecopper" )
	m_labFeecopper:SetText( tostring(m_numCopper) )	
	--uiInfo("layWorld_frmEntrustissue_getConsignInfo End......" )
end

--[ Task combobox update ]
function layWorld_frmEntrustissue_updateTask()
	--uiInfo("layWorld_frmEntrustissue_updateTask begin......" )
	layWorld_frmEntrustissue_getConsignInfo()
	local m_cbxTaskName = uiGetglobal( "layWorld.frmEntrust.cbxEntrustTaskName" )
	local m_cbxTask = uiGetglobal( "layWorld.frmEntrust.cbxEntrustTask" )	
	m_cbxTaskName:RemoveAllItems()	
	m_cbxTask:RemoveAllItems()
	m_cbxTaskName:SetText("")
	m_cbxTask:SetText("")
	
	local m_strFirstKey = nil
	for k,v in pairs(m_tTypeInfo) do
		if nil == m_strFirstKey then
			m_strFirstKey = k
		end
		m_cbxTask:AddItem( k, nil )
	end
	
	if nil ~= m_strFirstKey then		
		local m_tFirstVal = m_tTypeInfo[m_strFirstKey]
		for m, n in pairs( m_tFirstVal ) do
			--uiInfo("TaskName: additem "..tostring(n[2]) )
			m_cbxTaskName:AddItem( n[2], nil )
		end		
		if table.getn( m_tFirstVal ) > 0 then
			m_cbxTaskName:SelectItem( 0 )
		end
		m_cbxTask:SelectItem( 0 )
	end
	--uiInfo("layWorld_frmEntrustissue_updateTask end......" )
end

--[ Do nothing, just for messagebox functor ]
function layWorld_frmEntrustissue_dumbFunction( _, __ )
end

--[ Find current task id ]
function layWorld_frmEntrustissue_findCurrentTaskID()
	local m_cbxTaskName = uiGetglobal( "layWorld.frmEntrust.cbxEntrustTaskName" )
	local m_cbxTask = uiGetglobal( "layWorld.frmEntrust.cbxEntrustTask" )	
	local m_taskType = m_cbxTask:getText()
	local m_taskName = m_cbxTaskName:getText()
	for k, v in pairs( m_tTypeInfo ) do
		if k == m_taskType then
			for idx, vv in pairs( v ) do
				if vv[2] == m_taskName then
					return vv[1]
				end
			end
		end
	end	
	return nil
end

function layWorld_frmEntrustissue_OnLoad( self )
	--m_tTypeInfo["FB"] = {{"id","name"},{"0","2"},{"0","3"}}
	--m_tTypeInfo["TA"] = {{"0","4"},{"0","5"},{"0","6"}}	
	self:RegisterScriptEventNotify("event_update_task")
	self:RegisterScriptEventNotify("EVENT_SelfLevelUp")
end

function layWorld_frmEntrustissue_OnEvent( self, event, arg )
	if event =="event_update_task" or "EVENT_SelfLevelUp" then
		layWorld_frmEntrustissue_updateTask()
    end
end

function layWorld_frmEntrustissue_OnShow( self )
	uiRegisterEscWidget( self )
	layWorld_frmEntrustissue_updateTask()
	
	--[ Clear the content ]
	layWorld_frmEntrustissue_ClearContent()
	self:ShowAndFocus()
end

function layWorld_frmEntrustissue_OnHide( self )
	layWorld_frmEntrustissue_ClearContent()
end

function layWorld_frmEntrustissue_EbxGold_OnTextChanged( self )	
	local m_strNewFee = self:getText()
	local m_numNewFee = tonumber(m_strNewFee)
	if m_numNewFee==nil then
		m_numNewFee = 0
	else
		m_numNewFee = m_numNewFee*1000
	end
	
	local max1 = 0
	local max2 = 0
	max1, max2 , m_fConsignFee = uiConsignGetConfig()
	local m_max = 0
	if m_numNewFee>m_fConsignFee then
		m_max = m_numNewFee
	else
		m_max = m_fConsignFee
	end	
	local m_numGold = math.floor( m_max/10000 )
	local m_numSilver = math.floor( math.mod(m_max,10000)/100 )
	local m_numCopper = math.floor( math.mod( m_max, 100 ) )
	local m_labFeegold = uiGetglobal( "layWorld.frmEntrust.lbprocedurefeegold" )
	m_labFeegold:SetText( tostring(m_numGold) )
	local m_labFeesilver = uiGetglobal( "layWorld.frmEntrust.lbprocedurefeesilver" )
	m_labFeesilver:SetText( tostring(m_numSilver) )
	local m_labFeecopper = uiGetglobal( "layWorld.frmEntrust.lbprocedurefeecopper" )
	m_labFeecopper:SetText( tostring(m_numCopper) )
end

function layWorld_frmEntrustissue_BtnConfirm_OnClicked( self )
	--uiInfo( "layWorld_frmEntrustissue_BtnConfirm_OnClicked Begin..." )
	local m_curTaskID = layWorld_frmEntrustissue_findCurrentTaskID()
	if m_curTaskID == nil then
	   --uiMessageBox(uiLanString("consign_msg_1"),uiLanString("consign_msg_title"),true,false,true)
	   uiClientMsg(uiLanString("consign_msg_7"),true)
	   return
	end
	
	local m_ebxRepuation = uiGetglobal( "layWorld.frmEntrust.ebxCreditworthiness" )
	local m_ebxTime = uiGetglobal( "layWorld.frmEntrust.ebxHours" )
	local m_ebxDesc = uiGetglobal( "layWorld.frmEntrust.ebxDescribe" )
	local m_ebxReward = uiGetglobal( "layWorld.frmEntrust.ebxGold" )
	local m_cbxItem1 = uiGetglobal( "layWorld.frmEntrust.cbtEncouragement1" )
	local m_cbxItem2 = uiGetglobal( "layWorld.frmEntrust.cbtEncouragement2" )
	local m_cbxItem3 = uiGetglobal( "layWorld.frmEntrust.cbtEncouragement3" )
	
	local m_testTime = tonumber( m_ebxTime:getText() )
	if nil == m_testTime or 0 == m_testTime then
		uiClientMsg(uiLanString("consign_msg_8"),true)
		return
	end
	
	local m_item1ID = m_cbxItem1:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
	local m_item2ID = m_cbxItem2:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
	local m_item3ID = m_cbxItem3:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
	--uiInfo("m_item1ID:"..tostring(m_item1ID))
	--uiInfo("m_item2ID:"..tostring(m_item2ID))
	--uiInfo("m_item3ID:"..tostring(m_item3ID))
	
	--[ unfreeze the encourage items ]
	local Item1Id = m_cbxItem1:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
	if Item1Id and Item1Id > 0 then
		LClass_ItemFreezeManager:Erase(Item1Id) -- 解冻
	end	
	local Item2Id = m_cbxItem2:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
	if Item2Id and Item2Id > 0 then
		LClass_ItemFreezeManager:Erase(Item2Id) -- 解冻
	end	
	local Item3Id = m_cbxItem3:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
	if Item3Id and Item3Id > 0 then
		LClass_ItemFreezeManager:Erase(Item3Id) -- 解冻
	end
	
	--[ Check money is engough or not]
	local max1 = 0
	local max2 = 0
	max1, max2 , m_fConsignFee = uiConsignGetConfig()
	local m_strNewFee = m_ebxReward:getText()
	local m_numMoney = uiGetMyInfo("Money")
	local m_bEnough = false
	local m_numNewFee = tonumber(m_strNewFee)
	if nil == m_numNewFee then
		m_numNewFee = 0
	end
	m_numNewFee = m_numNewFee*10000
	if m_numNewFee >= 10000 and m_numMoney >= m_numNewFee then
		m_bEnough = true
	elseif m_numMoney > m_fConsignFee then
		m_bEnough = true
	end	
	if false == m_bEnough then
		uiMessageBox(uiLanString("consign_msg_3"),uiLanString("consign_msg_title"),true,false,true)
		return
	end
	
	--[ Satisfy all items , and then assign the consign ]
	local m_fRepuation = 0 -- 信誉度弃用
	local m_fTime = tonumber( m_ebxTime:getText() )
	local m_strDesc = m_ebxDesc:getText()
	local m_fReward = tonumber( m_ebxReward:getText() )	
	if nil == m_fTime then
		m_fTime = 0
	end
	if nil == m_fReward then
		m_fReward = 0
	end
	
	
	--[ Can't beyond the max num ]
	if m_fReward > 2000 then
		uiClientMsg(uiLanString("consign_msg_9"),true)
		return
	end
	
	--[ The reward can't be empty ]
	if m_fReward==0 and m_item1ID==0 and m_item2ID==0 and m_item3ID==0 then
		uiClientMsg(uiLanString("consign_msg_10"),true)
		return
	end
	
	--uiInfo( "ID:"..m_curTaskID.." Repuation:"..tostring(m_fRepuation).." Time:"..tostring(m_fTime).." Reward:"..tostring(m_fReward).." Desc:"..m_strDesc )
	uiConsignSendConsign( tonumber(m_curTaskID), m_fRepuation, m_fTime, m_fReward*10000, m_strDesc, m_item1ID, m_item2ID, m_item3ID )
		
	--[ Clear the content ]
	m_ebxTime:SetText("")
	m_ebxDesc:SetText("")
	m_ebxReward:SetText("")
	
	m_cbxItem1:SetNormalImage(0)
	m_cbxItem1:SetUltraTextNormal("")
	m_cbxItem1:Set(EV_UI_SHORTCUT_TYPE_KEY, 0)
	m_cbxItem1:Set(EV_UI_SHORTCUT_OBJECTID_KEY, 0)
	m_cbxItem1:Set(EV_UI_SHORTCUT_CLASSID_KEY, 0)
	
	m_cbxItem2:SetNormalImage(0)
	m_cbxItem2:SetUltraTextNormal("")
	m_cbxItem2:Set(EV_UI_SHORTCUT_TYPE_KEY, 0)
	m_cbxItem2:Set(EV_UI_SHORTCUT_OBJECTID_KEY, 0)
	m_cbxItem2:Set(EV_UI_SHORTCUT_CLASSID_KEY, 0)
	
	m_cbxItem3:SetNormalImage(0)
	m_cbxItem3:SetUltraTextNormal("")
	m_cbxItem3:Set(EV_UI_SHORTCUT_TYPE_KEY, 0)
	m_cbxItem3:Set(EV_UI_SHORTCUT_OBJECTID_KEY, 0)
	m_cbxItem3:Set(EV_UI_SHORTCUT_CLASSID_KEY, 0)

	
	--[ And hide the dialog]
	local m_frmEntrust = uiGetglobal( "layWorld.frmEntrust" )
	m_frmEntrust:Hide()
	--uiInfo( "layWorld_frmEntrustissue_BtnConfirm_OnClicked End..." )
end

function layWorld_frmEntrustissue_ClearContent()
	local m_ebxRepuation = uiGetglobal( "layWorld.frmEntrust.ebxCreditworthiness" )
	local m_ebxTime = uiGetglobal( "layWorld.frmEntrust.ebxHours" )
	local m_ebxDesc = uiGetglobal( "layWorld.frmEntrust.ebxDescribe" )
	local m_ebxReward = uiGetglobal( "layWorld.frmEntrust.ebxGold" )
	local m_cbxItem1 = uiGetglobal( "layWorld.frmEntrust.cbtEncouragement1" )
	local m_cbxItem2 = uiGetglobal( "layWorld.frmEntrust.cbtEncouragement2" )
	local m_cbxItem3 = uiGetglobal( "layWorld.frmEntrust.cbtEncouragement3" )
	
	--[ unfreeze the encourage items ]
	local Item1Id = m_cbxItem1:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
	if Item1Id and Item1Id > 0 then
		LClass_ItemFreezeManager:Erase(Item1Id) -- 解冻
	end	
	local Item2Id = m_cbxItem2:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
	if Item2Id and Item2Id > 0 then
		LClass_ItemFreezeManager:Erase(Item2Id) -- 解冻
	end	
	local Item3Id = m_cbxItem3:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
	if Item3Id and Item3Id > 0 then
		LClass_ItemFreezeManager:Erase(Item3Id) -- 解冻
	end
	
	--[ Clear the content ]
	m_ebxTime:SetText("")
	m_ebxDesc:SetText("")
	m_ebxReward:SetText("")
	
	m_cbxItem1:SetNormalImage(0)
	m_cbxItem1:SetUltraTextNormal("")
	m_cbxItem1:Set(EV_UI_SHORTCUT_TYPE_KEY, 0)
	m_cbxItem1:Set(EV_UI_SHORTCUT_OBJECTID_KEY, 0)
	m_cbxItem1:Set(EV_UI_SHORTCUT_CLASSID_KEY, 0)
	
	m_cbxItem2:SetNormalImage(0)
	m_cbxItem2:SetUltraTextNormal("")
	m_cbxItem2:Set(EV_UI_SHORTCUT_TYPE_KEY, 0)
	m_cbxItem2:Set(EV_UI_SHORTCUT_OBJECTID_KEY, 0)
	m_cbxItem2:Set(EV_UI_SHORTCUT_CLASSID_KEY, 0)
	
	m_cbxItem3:SetNormalImage(0)
	m_cbxItem3:SetUltraTextNormal("")
	m_cbxItem3:Set(EV_UI_SHORTCUT_TYPE_KEY, 0)
	m_cbxItem3:Set(EV_UI_SHORTCUT_OBJECTID_KEY, 0)
	m_cbxItem3:Set(EV_UI_SHORTCUT_CLASSID_KEY, 0)
end

function layWorld_frmEntrustissue_BtnClose_OnClicked( self )
	--[ Clear the interface ]
	layWorld_frmEntrustissue_ClearContent()
	
	--[ And hide the dialog]
	local m_frmEntrust = uiGetglobal( "layWorld.frmEntrust" )
	m_frmEntrust:Hide()
end

function layWorld_frmEntrustissue_CBX_EntrustTask_OnUpdateText( self )
    local m_cbxTaskName = uiGetglobal( "layWorld.frmEntrust.cbxEntrustTaskName" )
	m_cbxTaskName:RemoveAllItems()
	m_cbxTaskName:SetText("")
	local m_tCurVal = m_tTypeInfo[self:getText()]
	for m, n in ipairs( m_tCurVal ) do
		m_cbxTaskName:AddItem( n[2], nil )
	end
	if table.getn( m_tCurVal ) > 0 then
		m_cbxTaskName:SelectItem( 0 )
	end
end

function layWorld_frmEntrustissue_CBX_EntrustTaskName_OnUpdateText( self )	
end

function layWorld_frmEntrustissue_CbxEncouragement_OnLoad( self )
	self:Set(EV_UI_SHORTCUT_OWNER_KEY, EV_UI_SHORTCUT_OWNER_CONSIGN)
end

function layWorld_frmEntrustissue_CbxEncouragement_OnDragIn( self, drag )
	local allow_owners = 
	{
		EV_UI_SHORTCUT_OWNER_ITEM,
		IsAllowed = function(self, owner)
			if owner == nil then return false end
			for i, v in ipairs(self) do
				if v == owner then return true end
			end
			return false;
		end
	}
	local drag_out = uiGetglobal(drag)
	if drag_out == nil then return end
	local shortcut_owner = drag_out:Get(EV_UI_SHORTCUT_OWNER_KEY)
	if shortcut_owner == nil then return end
	if allow_owners:IsAllowed(shortcut_owner) == false then return end
	local shortcut_type = drag_out:Get(EV_UI_SHORTCUT_TYPE_KEY)
	if shortcut_type == nil then shortcut_type = 0 end
	local shortcut_objectid = drag_out:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
	if shortcut_objectid == nil then shortcut_objectid = 0 end
	local shortcut_classid = drag_out:Get(EV_UI_SHORTCUT_CLASSID_KEY)
	if shortcut_classid == nil then shortcut_classid = 0 end
	if uiConsignCanItemDragIn( shortcut_objectid, true ) == false then
	   uiMessageBox(uiLanString("consign_msg_2"),uiLanString("consign_msg_title"),true,false,true)
	   return
	end
	local ItemId = self:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
	if ItemId and ItemId > 0 then
		LClass_ItemFreezeManager:Erase(ItemId) -- 解冻
	end
	self:Set(EV_UI_SHORTCUT_TYPE_KEY, shortcut_type)
	self:Set(EV_UI_SHORTCUT_OBJECTID_KEY, shortcut_objectid)
	self:Set(EV_UI_SHORTCUT_CLASSID_KEY, shortcut_classid)
	LClass_ItemFreezeManager:Push(shortcut_objectid) -- 冻结
	layWorld_frmEntrustissue_CbxEncouragement_Refresh( self )
end

function layWorld_frmEntrustissue_CbxEncouragement_Refresh(self)
	local shortcut_dbid = self:Get(LOCAL_SHORTCUT_DBID_KEY)
	local shortcut_owner = self:Get(EV_UI_SHORTCUT_OWNER_KEY)
	if shortcut_owner == nil or shortcut_owner ~= EV_UI_SHORTCUT_OWNER_CONSIGN then return end
	local shortcut_type = self:Get(EV_UI_SHORTCUT_TYPE_KEY)
	local shortcut_objectid = self:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
	local shortcut_classid = self:Get(EV_UI_SHORTCUT_CLASSID_KEY)
	
	local icon = 0 -- 图标地址 -- 指针地址
	local itemCount = 0 -- 道具的当前数量
	local countText = "" -- 道具的当前数量文本
	local bModifyFlag = false
	
	if shortcut_type == nil or shortcut_type == EV_SHORTCUT_OBJECT_NONE then
		shortcut_type = EV_SHORTCUT_OBJECT_NONE
	elseif not shortcut_objectid or shortcut_objectid == 0 or shortcut_classid == nil or shortcut_classid == 0 then
	elseif shortcut_type == EV_SHORTCUT_OBJECT_ITEM then
		local tableInfo = uiItemGetItemClassInfoByTableIndex(shortcut_classid) -- 道具的静态信息
		icon = SAPI.GetImage(tableInfo.Icon, 2, 2, -2, -2)
		if tableInfo.IsCountable == true then
			local objInfo = uiItemGetBagItemInfoByObjectId(shortcut_objectid) -- 道具的动态信息
			if objInfo then
				itemCount = objInfo.Count
				if itemCount > 0 then
					countText = tostring(itemCount)
				end
			end
		end
		bModifyFlag = true
	end
	-- 操作按钮
	self:ModifyFlag("DragOut_MouseMove", bModifyFlag)
	self:SetNormalImage(icon)
	self:SetUltraTextNormal(countText)
end

function layWorld_frmEntrustissue_CbxEncouragement_OnDragNull( self )
	local ItemId = self:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
	if ItemId and ItemId > 0 then
		LClass_ItemFreezeManager:Erase(ItemId) -- 解冻
	end
	self:Set(EV_UI_SHORTCUT_TYPE_KEY, 0)
	self:Set(EV_UI_SHORTCUT_OBJECTID_KEY, 0)
	self:Set(EV_UI_SHORTCUT_CLASSID_KEY, 0)
	layWorld_frmEntrustissue_CbxEncouragement_Refresh(self)
end

function layWorld_frmEntrustissue_CbxEncouragement_OnHint( self )
	local hint = 0
	local shortcut_type = self:Get(EV_UI_SHORTCUT_TYPE_KEY)
	if shortcut_type == nil then
	elseif shortcut_type == EV_SHORTCUT_OBJECT_ITEM then
		local shortcut_objectid = self:Get(EV_UI_SHORTCUT_OBJECTID_KEY)
		if shortcut_objectid == nil or shortcut_objectid == 0 then
		else
			hint = uiItemGetBagItemHintByObjectId(shortcut_objectid)
		end
	end
	self:SetHintRichText(hint)
end
