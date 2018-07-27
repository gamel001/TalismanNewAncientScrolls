local m_delegateItems = {}						-- All delegate items
local m_acceptItems = {}						-- The accepted items
local COLOR_WHITE = 4294967295 					-- White Color
local m_curPage = 0

function layWorld_frmEntrusthall_findDelegate( strPublisher, strID )
	for idx, v in ipairs( m_delegateItems ) do
		if v["publisher"] == strPublisher and v["ID"] == strID then
			return idx
		end
	end	
	return nil
end

function layWorld_frmEntrusthall_findAcceptItem( strPublisher, strID )
	for idx, v in ipairs( m_acceptItems ) do
		if v["publisher"] == strPublisher and v["ID"] == strID then
			return idx
		end
	end	
	return nil
end

function layWorld_frmEntrusthall_addDelegate( strID, strTaskID, strLevel, strDifficulty, strPublisher, strName, strReward, strRewardItem1, strRewardItem2, strRewardItem3, strReputation, strState, strValiTime, strDesc )
	local m_idx = layWorld_frmEntrusthall_findDelegate( strPublisherID, strID )
	if nil ~= m_idx then
		return
	end
	local newItem = {}
	newItem["ID"] = strID
	newItem["TaskID"] = strTaskID
	newItem["level"] = strLevel
	if strDifficulty == "0" then
		newItem["difficulty"] = uiLanString("consign_tasklev_0")
	elseif strDifficulty == "1" then
		newItem["difficulty"] = uiLanString("consign_tasklev_1")
	elseif strDifficulty == "11" then
		newItem["difficulty"] = uiLanString("consign_tasklev_11")
	else
		newItem["difficulty"] = ""
	end	
	--newItem["difficulty"] = strDifficulty
	newItem["publisher"] = strPublisher
	newItem["name"] = strName
	newItem["reward"] = strReward
	newItem["rewardItem1"] = strRewardItem1
	newItem["rewardItem2"] = strRewardItem2
	newItem["rewardItem3"] = strRewardItem3
	newItem["reputation"] = strReputation
	newItem["state"] = strState
	newItem["time"] = strValiTime
	newItem["desc"] = strDesc
	m_idx = table.getn( m_delegateItems )	
	m_delegateItems[m_idx+1] = newItem
end

function layWorld_frmEntrusthall_sortDelegate( strCondition,  bAscend )
	--uiInfo( "layWorld_frmEntrusthall_sortDelegate begin..." )
	--uiInfo( "condition:"..strCondition )
	if layWorld_frmEntrusthall_checkSortCondition(strCondition) == false then
		return
	end
	local m_nItems = table.getn( m_delegateItems )
	for idx1=1, m_nItems do
		local temp = nil
		local bNeed = false
		for idx2=idx1+1, m_nItems do
			bNeed = false
			if bAscend then
				--uiInfo( "bAscend: 1 con:"..m_delegateItems[idx1][strCondition] )
				--uiInfo( "bAscend: 2 con:"..m_delegateItems[idx2][strCondition] )
				--uiInfo( "1<2: "..tostring(m_delegateItems[idx2][strCondition] < m_delegateItems[idx1][strCondition]) )
				if m_delegateItems[idx2][strCondition] < m_delegateItems[idx1][strCondition] then
					bNeed = true
				end
			else
				if m_delegateItems[idx2][strCondition] > m_delegateItems[idx1][strCondition] then
					bNeed = true
				end
			end
			
			if bNeed then
				--uiInfo( "condition:"..m_delegateItems[idx1][strCondition] )
				temp = m_delegateItems[idx1]
				m_delegateItems[idx1] = m_delegateItems[idx2]
				m_delegateItems[idx2] = temp
			end
		end
	end
	--uiInfo( "layWorld_frmEntrusthall_sortDelegate End..." )
end

function layWorld_frmEntrusthall_isDelegateConditionAscend( strCondition )
	if layWorld_frmEntrusthall_checkSortCondition(strCondition) == false then
		return false
	end	
	local m_nItems = table.getn( m_delegateItems )
	for idx=1, m_nItems-1 do
		if m_delegateItems[idx][strCondition] > m_delegateItems[idx+1][strCondition] then
			return false
		end
	end
	return true
end

-- [sort by name, level, difficulty, time, state]
function layWorld_frmEntrusthall_checkSortCondition( strCondition )
	if strCondition == "name" or strCondition == "level" or strCondition == "difficulty" or strCondition == "time" or strCondition == "state" then
		return true
	end
	return false
end

function layWorld_frmEntrusthall_addAcceptItem( strID, strTaskID, strLevel, strDifficulty, strPublisher, strName, strReward, strRewardItem1, strRewardItem2, strRewardItem3, strReputation, strState, strValiTime, strDesc )
	local m_idx = layWorld_frmEntrusthall_findAcceptItem( strPublisherID, strID )
	if nil ~= m_idx then
		return
	end
	local newItem = {}
	newItem["ID"] = strID
	newItem["TaskID"] = strTaskID
	newItem["level"] = strLevel
	if strDifficulty == "0" then
		newItem["difficulty"] = uiLanString("consign_tasklev_0")
	elseif strDifficulty == "1" then
		newItem["difficulty"] = uiLanString("consign_tasklev_1")
	elseif strDifficulty == "11" then
		newItem["difficulty"] = uiLanString("consign_tasklev_11")
	else
		newItem["difficulty"] = ""
	end
	--newItem["difficulty"] = strDifficulty
	newItem["publisher"] = strPublisher
	newItem["name"] = strName
	newItem["reward"] = strReward
	newItem["rewardItem1"] = strRewardItem1
	newItem["rewardItem2"] = strRewardItem2
	newItem["rewardItem3"] = strRewardItem3
	newItem["reputation"] = strReputation
	newItem["state"] = strState
	newItem["time"] = strValiTime
	newItem["desc"] = strDesc
	m_idx = table.getn( m_acceptItems )	
	m_acceptItems[m_idx+1] = newItem
end

function layWorld_frmEntrusthall_updateDelegateList()
	--uiInfo( "layWorld_frmEntrusthall_updateDelegateList begin...... " )
	local m_list = uiGetglobal( "layWorld.frmEntrusthall.lbxEntrust" )
	m_list:RemoveAllLines( true )
	local max1 = 0
	local max2 = 0
	local m_numConsignFee = 0
	max1, max2 , m_numConsignFee = uiConsignGetConfig()
	for idx, v in ipairs( m_delegateItems ) do
		m_list:InsertLine( 20, COLOR_WHITE, -1 )
		m_list:SetLineItem( idx-1, 0, v["name"], COLOR_WHITE )
		m_list:SetLineItem( idx-1, 1, v["level"], COLOR_WHITE )
		m_list:SetLineItem( idx-1, 2, v["difficulty"], COLOR_WHITE )		
		--m_list:SetLineItem( idx-1, 4, v["publisher"], COLOR_WHITE )
		--m_list:SetLineItem( idx-1, 4, v["reputation"], COLOR_WHITE )
		m_list:SetLineItem( idx-1, 3, v["time"], COLOR_WHITE )
		m_list:SetLineItem( idx-1, 4, v["state"], COLOR_WHITE )
		local m_strReward = v["reward"]
		local m_numReward = tonumber( m_strReward )
		local m_numRealGet = 0
		if m_numReward>m_numConsignFee then
			m_numRealGet = m_numReward*0.9
		else
			m_numRealGet = 0
		end
		local m_numRewardG = 0
		local m_numRewardS = 0
		local m_numRewardC = 0		
		m_numRewardG = math.floor( m_numRealGet/10000 )
		m_numRewardS = math.floor( math.mod(m_numRealGet,10000)/100 )
		m_numRewardC = math.floor( math.mod( m_numRealGet, 100 ) )	
		m_strReward = string.format("%d"..uiLanString("consign_gold").."%d"..uiLanString("consign_silver").."%d"..uiLanString("consign_copper"),m_numRewardG,m_numRewardS,m_numRewardC)
		m_list:SetLineItem( idx-1, 5, m_strReward, COLOR_WHITE )		
		local m_item1Name = ""
		local m_item2Name = ""
		local m_item3Name = ""
		if "0" ~= v["rewardItem1"] then
			local m_item1 = uiItemGetItemClassInfoByTableIndex( tonumber(v["rewardItem1"]) )			
			if nil ~= m_item1 then
				m_item1Name = m_item1["Name"]
				if m_item1["IsCountable"]==true then
				     m_item1Name=m_item1Name.."("..tostring(m_item1["InitCount"])..")"
				end
				local m_item1HintText = uiItemGetBagItemHintByTableId( tonumber(v["rewardItem1"]) )
				if nil ~= m_item1HintText then
					m_list:SetItemHintRichText(idx-1, 6, m_item1HintText)
				end
			end
		else
			m_list:SetItemHintRichText(idx-1, 6, 0)
		end
		if "0" ~= v["rewardItem2"] then
			local m_item2 = uiItemGetItemClassInfoByTableIndex( tonumber(v["rewardItem2"]) )
			if nil ~= m_item2 then
				m_item2Name = m_item2["Name"]
				if m_item2["IsCountable"]==true then
				     m_item2Name=m_item2Name.."("..tostring(m_item2["InitCount"])..")"
				end
				local m_item2HintText = uiItemGetBagItemHintByTableId( tonumber(v["rewardItem2"]) )
				if nil ~= m_item2HintText then
					m_list:SetItemHintRichText(idx-1, 7, m_item2HintText)
				end
			end
		else
			m_list:SetItemHintRichText(idx-1, 7, 0)
		end
		if "0" ~= v["rewardItem3"] then
			local m_item3 = uiItemGetItemClassInfoByTableIndex( tonumber(v["rewardItem3"]) )
			if nil ~= m_item3 then
				m_item3Name = m_item3["Name"]
				if m_item3["IsCountable"]==true then
				     m_item3Name=m_item3Name.."("..tostring(m_item3["InitCount"])..")"
				end
				local m_item3HintText = uiItemGetBagItemHintByTableId( tonumber(v["rewardItem3"]) )
				if nil ~= m_item3HintText then
					m_list:SetItemHintRichText(idx-1, 8, m_item3HintText)
				end
			end
		else
			m_list:SetItemHintRichText(idx-1, 8, 0)
		end		
		m_list:SetLineItem( idx-1, 6, m_item1Name, COLOR_WHITE )
		m_list:SetLineItem( idx-1, 7, m_item2Name, COLOR_WHITE )
		m_list:SetLineItem( idx-1, 8, m_item3Name, COLOR_WHITE )		
		m_list:SetLineItem( idx-1, 9, v["desc"], COLOR_WHITE )
		if "" ~= v["desc"] then
		    m_list:SetItemHintText(idx-1,9,tostring(v["desc"]))	
		else
		    m_list:SetItemHintText(idx-1,9,0)		
		end 
	end	
	--uiInfo( "layWorld_frmEntrusthall_updateDelegateList end...... " )
end

function layWorld_frmEntrusthall_updateAcceptList()
	local m_listRecv = uiGetglobal( "layWorld.frmEntrusthall.lbxReceive" )
	m_listRecv:RemoveAllLines( true )
	local max1 = 0
	local max2 = 0
	local m_numConsignFee = 0
	max1, max2 , m_numConsignFee = uiConsignGetConfig()
	for idx, v in ipairs( m_acceptItems ) do
		m_listRecv:InsertLine( 20, COLOR_WHITE, -1 )
		m_listRecv:SetLineItem( idx-1, 0, v["name"], COLOR_WHITE )
		m_listRecv:SetLineItem( idx-1, 1, v["level"], COLOR_WHITE )
		m_listRecv:SetLineItem( idx-1, 2, v["difficulty"], COLOR_WHITE )
		
		--m_listRecv:SetLineItem( idx-1, 4, v["publisher"], COLOR_WHITE )
		--m_listRecv:SetLineItem( idx-1, 4, v["reputation"], COLOR_WHITE )
		m_listRecv:SetLineItem( idx-1, 3, v["time"], COLOR_WHITE )
		m_listRecv:SetLineItem( idx-1, 4, v["state"], COLOR_WHITE )
		local m_strReward = v["reward"]
		local m_numReward = tonumber( m_strReward )
		local m_numRealGet = 0
		if m_numReward>m_numConsignFee then
			m_numRealGet = m_numReward*0.9
		else
			m_numRealGet = 0
		end
		local m_numRewardG = 0
		local m_numRewardS = 0
		local m_numRewardC = 0		
		m_numRewardG = math.floor( m_numRealGet/10000 )
		m_numRewardS = math.floor( math.mod(m_numRealGet,10000)/100 )
		m_numRewardC = math.floor( math.mod( m_numRealGet, 100 ) )	
		m_strReward = string.format("%d"..uiLanString("consign_gold").."%d"..uiLanString("consign_silver").."%d"..uiLanString("consign_copper"),m_numRewardG,m_numRewardS,m_numRewardC)
		m_listRecv:SetLineItem( idx-1, 5, m_strReward, COLOR_WHITE )	
		local m_item1Name = ""
		local m_item2Name = ""
		local m_item3Name = ""
		if "0" ~= v["rewardItem1"] then
			local m_item1 = uiItemGetItemClassInfoByTableIndex( tonumber(v["rewardItem1"]) )
			if nil ~= m_item1 then
				m_item1Name = m_item1["Name"]
				if m_item1["IsCountable"]==true then
				     m_item1Name=m_item1Name.."("..tostring(m_item1["InitCount"])..")"
				end
				local m_item1HintText = uiItemGetBagItemHintByTableId( tonumber(v["rewardItem1"]) )
				if nil ~= m_item1HintText then
					m_listRecv:SetItemHintRichText(idx-1, 6, m_item1HintText)
				end
			end
		else
			m_listRecv:SetItemHintRichText(idx-1, 6, 0)
		end
		if "0" ~= v["rewardItem2"] then
			local m_item2 = uiItemGetItemClassInfoByTableIndex( tonumber(v["rewardItem2"]) )
			if nil ~= m_item2 then
				m_item2Name = m_item2["Name"]
				if m_item2["IsCountable"]==true then
				     m_item2Name=m_item2Name.."("..tostring(m_item2["InitCount"])..")"
				end
				local m_item2HintText = uiItemGetBagItemHintByTableId( tonumber(v["rewardItem2"]) )
				if nil ~= m_item2HintText then
					m_listRecv:SetItemHintRichText(idx-1, 7, m_item2HintText)
				end
			end
		else
			m_listRecv:SetItemHintRichText(idx-1, 7, 0)
		end
		if "0" ~= v["rewardItem3"] then
			local m_item3 = uiItemGetItemClassInfoByTableIndex( tonumber(v["rewardItem3"]) )
			if nil ~= m_item3 then
				m_item3Name = m_item3["Name"]
				if m_item3["IsCountable"]==true then
				     m_item3Name=m_item3Name.."("..tostring(m_item3["InitCount"])..")"
				end
				local m_item3HintText = uiItemGetBagItemHintByTableId( tonumber(v["rewardItem3"]) )
				if nil ~= m_item3HintText then
					m_listRecv:SetItemHintRichText(idx-1, 8, m_item3HintText)
				end
			end
		else
			m_listRecv:SetItemHintRichText(idx-1, 8, 0)
		end		
		m_listRecv:SetLineItem( idx-1, 6, m_item1Name, COLOR_WHITE )
		m_listRecv:SetLineItem( idx-1, 7, m_item2Name, COLOR_WHITE )
		m_listRecv:SetLineItem( idx-1, 8, m_item3Name, COLOR_WHITE )
		m_listRecv:SetLineItem( idx-1, 9, v["desc"], COLOR_WHITE )
		if "" ~= v["desc"] then
		    m_listRecv:SetItemHintText(idx-1,9,tostring(v["desc"]))	
		else
		    m_listRecv:SetItemHintText(idx-1,9,0)		
		end 
	end
end

function layWorld_frmEntrusthall_getDelegateState( oneDelegate, strName )
	--uiInfo( "layWorld_frmEntrusthall_getDelegateState begin... " )
	local m_ret = ""
	if nil == oneDelegate or nil == strName then
		return m_ret
	end
	--uiInfo( "Releaser: "..oneDelegate["ReleaserId"] )
	if nil ~= oneDelegate["ReleaserId"] and oneDelegate["ReleaserId"] == strName then
		-- 如果发布人是自己
		--uiInfo( "Releaser is self... ReceiveID: "..oneDelegate["ReceiverId"] )
		if nil ~= oneDelegate["ReceiverId"] then
			if 0 == tonumber( oneDelegate["ReceiverId"] ) then
				m_ret = uiLanString("consign_state_2")
			elseif "18446744073709551615" == tostring(oneDelegate["ReceiverId"]) then -- Value -1
				m_ret = uiLanString("consign_state_5")
			elseif tonumber( oneDelegate["ReceiverId"] )>0 then
				m_ret = uiLanString("consign_state_3")
			end
		end
	elseif nil ~= oneDelegate["ReceiverId"] then
		-- 发布人不是自己
		--uiInfo( "Releaser is not self... " )
		if 0 == tonumber( oneDelegate["ReceiverId"] ) then
			-- 并且没有任何人接收
			m_ret = uiLanString("consign_state_1")
		elseif tonumber( oneDelegate["ReceiverId"] )>0 then
			-- 已经有人接受委托了
			--uiInfo( "TaskID.."..tostring(oneDelegate["TaskId"]) )
			local m_canFinish = uiConsignTaskCanFinish( oneDelegate["TaskId"] )
			--uiInfo( "uiConsignTaskCanFinish"..tostring( m_canFinish ) )
			if m_canFinish then				
				m_ret = uiLanString("consign_state_4")
			else
				m_ret = uiLanString("consign_state_3")
			end
		end
	else
		m_ret = "Default Value"
	end
	--uiInfo( "layWorld_frmEntrusthall_getDelegateState End... " )
	return m_ret	
end

function layWorld_frmEntrusthall_requestUpdateDelegateItems()
	--uiInfo("layWorld_frmEntrusthall_requestUpdateDelegateItems begin...")
	local m_consignList = uiConsignGetConsignList()
	local m_strID = uiGetMyInfo("DBId")
	--uiInfo( "Delegates items num.."..tostring(table.getn(m_consignList)) )
	m_delegateItems = {}
	for k, v in pairs( m_consignList ) do
		--uiInfo( "ReceiverID:.."..tostring(v["ReceiverId"]).." TaskID:.."..tostring(v["TaskId"]) )
		local m_delegateState = layWorld_frmEntrusthall_getDelegateState( v, m_strID )
		local m_remainTime = ""
		if v["RemainTm"] ~= nil then
			local m_hour = 0
			local m_minu = 0
			local m_seco = 0
			m_hour = math.floor( v["RemainTm"]/3600 )
			m_minu = math.floor( math.mod( v["RemainTm"], 3600 )/60 )
			m_seco = math.floor( math.mod( math.mod( v["RemainTm"], 3600 ), 60 )/60 )
			if m_hour>0 then
				m_remainTime = string.format("%d"..uiLanString("consign_hour"),m_hour)
			elseif m_minu>0 then
				m_remainTime = string.format("%d"..uiLanString("consign_min"),m_minu)
			else
				m_remainTime = string.format("%d"..uiLanString("consign_sec"),m_seco)
			end
		end
		layWorld_frmEntrusthall_addDelegate( tostring(v["ID"]), tostring(v["TaskId"]), tostring(v["TaskLev"]), tostring(v["TaskDif"]), v["ReleaserName"], v["TaskName"], tostring(v["Money"]), tostring(v["Item1"]), tostring(v["Item2"]), tostring(v["Item3"]), tostring(v["Credit"]), m_delegateState, m_remainTime, v["Desc"] )
	end
	layWorld_frmEntrusthall_sortDelegate( "name", true )
	layWorld_frmEntrusthall_updateDelegateList()
	--uiInfo("layWorld_frmEntrusthall_requestUpdateDelegateItems End...")
end

function layWorld_frmEntrusthall_requestUpdateAcceptItems()
	local m_consignList = uiConsignGetMyAccConsign()
	m_acceptItems = {}
	local m_strName = uiGetMyInfo("Role")
	--uiInfo( "SelfName.."..m_strName )
	for k, v in pairs( m_consignList ) do
		local m_delegateState = layWorld_frmEntrusthall_getDelegateState( v, m_strName )	
		local m_remainTime = ""
		if v["RemainTm"] ~= nil then
			local m_hour = 0
			local m_minu = 0
			local m_seco = 0
			m_hour = math.floor( v["RemainTm"]/3600 )
			m_minu = math.floor( math.mod( v["RemainTm"], 3600 )/60 )
			m_seco = math.floor( math.mod( math.mod( v["RemainTm"], 3600 ), 60 )/60 )
			if m_hour>0 then
				m_remainTime = string.format("%d"..uiLanString("consign_hour"),m_hour)
			elseif m_minu>0 then
				m_remainTime = string.format("%d"..uiLanString("consign_min"),m_minu)
			else
				m_remainTime = string.format("%d"..uiLanString("consign_sec"),m_seco)
			end
		end
		layWorld_frmEntrusthall_addAcceptItem( tostring(v["ID"]), tostring(v["TaskId"]), tostring(v["TaskLev"]), tostring(v["TaskDif"]), v["ReleaserName"], v["TaskName"], tostring(v["Money"]), tostring(v["Item1"]), tostring(v["Item2"]), tostring(v["Item3"]), tostring(v["Credit"]), m_delegateState, m_remainTime, v["Desc"] )
	end
	layWorld_frmEntrusthall_updateAcceptList()
end

function layWorld_frmEntrusthall_OnLoad( self )
        self:RegisterScriptEventNotify("EVENT_LocalGurl")
	self:RegisterScriptEventNotify("RefreshConsignList")
	self:RegisterScriptEventNotify("RefreshMyAccConsignList")
	local m_btnPrePage = uiGetglobal( "layWorld.frmEntrusthall.btPrepage" )
	m_btnPrePage:Disable()
	
	local m_btnAcceptDelegate = uiGetglobal( "layWorld.frmEntrusthall.btReceiveEntrust" )
	local m_btnCancelDelegate = uiGetglobal( "layWorld.frmEntrusthall.btCancelEntrust" )
	local m_btnFinishDelegate = uiGetglobal( "layWorld.frmEntrusthall.btFinishEntrust" )
	local m_btnReceptDelegate = uiGetglobal( "layWorld.frmEntrusthall.btReceptEntrust" )
	m_btnAcceptDelegate:Disable()
	m_btnCancelDelegate:Disable()
	m_btnFinishDelegate:Disable()
	m_btnReceptDelegate:Disable()
end

function layWorld_frmEntrusthall_OnEvent( self, event, arg )
        
	--uiInfo( "layWorld_frmEntrusthall_OnEvent Begin...Event.."..event )
	local frmEntrusthall = uiGetglobal("layWorld.frmEntrusthall");
	if event =="RefreshConsignList" then
		--[ update the pre and next button]
		local m_btnNextPage = uiGetglobal( "layWorld.frmEntrusthall.btNextpage" )		
		if arg ~= nil then
			--uiInfo("arg == "..tostring(arg[1]) )
			if arg[1] == 0 then
				m_btnNextPage:Enable()
			else
				m_btnNextPage:Disable()
			end
		end
		--[ update the count times ]
		local m_maxRele = nil 
		local m_maxRecv = nil 
		m_maxRele, m_maxRecv = uiConsignGetConfig()
		local m_enaRele = nil 
		local m_enaRecv = nil 
		m_enaRele, m_enaRecv = uiConsignGetReleaseCnt(), uiConsignGetReceiveCnt()	
		local m_labRele = uiGetglobal( "layWorld.frmEntrusthall.lbIssueTimes" )
		local m_labRecv = uiGetglobal( "layWorld.frmEntrusthall.lbReceiveTimes" )
		m_labRele:SetText( string.format("%d/%d", m_enaRele, m_maxRele ) )
		m_labRecv:SetText( string.format("%d/%d", m_enaRecv, m_maxRecv ) )
		
		--[ update the delegate items ]
		layWorld_frmEntrusthall_requestUpdateDelegateItems()
	elseif event == "RefreshMyAccConsignList" then
		layWorld_frmEntrusthall_requestUpdateAcceptItems()
        elseif event == "EVENT_LocalGurl" then	      
	        if tostring(arg[1])=="viewconsign" then		   
		    frmEntrusthall:ShowAndFocus();
		end
        end
	--uiInfo( "layWorld_frmEntrusthall_OnEvent End..." )
end

function layWorld_frmEntrusthall_OnShow( self )	
	--[ Ask for updating the delegate list]
	layWorld_frmEntrusthall_RefreshCurPage()
	
	
	--[ Ask for updating the accept list]
	layWorld_frmEntrusthall_requestUpdateAcceptItems()
	
	uiRegisterEscWidget( self )
	self:ShowAndFocus()
end

function layWorld_frmEntrusthall_OnHide( self )
	--[ Hide the detail dialog ]
	local detailForm = uiGetglobal( "layWorld.frmTaskText" )
	if detailForm:getVisible() == true then
		detailForm:Hide()
	end
end

function layWorld_frmEntrusthall_RefreshCurPage()
	--[ Refresh the count number ]
	local m_maxRele = nil 
	local m_maxRecv = nil 
	m_maxRele, m_maxRecv = uiConsignGetConfig()
	local m_enaRele = nil 
	local m_enaRecv = nil 
	m_enaRele, m_enaRecv = uiConsignGetReleaseCnt(), uiConsignGetReceiveCnt()	
	local m_labRele = uiGetglobal( "layWorld.frmEntrusthall.lbIssueTimes" )
	local m_labRecv = uiGetglobal( "layWorld.frmEntrusthall.lbReceiveTimes" )	
	m_labRele:SetText( string.format("%d/%d", m_enaRele, m_maxRele ) )
	m_labRecv:SetText( string.format("%d/%d", m_enaRecv, m_maxRecv ) )
	
	--[ Care about the bottom buttons ]
	local btnAccept = uiGetglobal( "layWorld.frmEntrusthall.btReceiveEntrust" )
	local btnCancel = uiGetglobal( "layWorld.frmEntrusthall.btCancelEntrust" )
	btnAccept:Show()
	btnCancel:Hide()
	
	--[ Ask for consign list ]
	--uiInfo( "layWorld_frmEntrusthall_BtnRefresh_OnClicked Ask for consign, page:"..tostring(m_curPage).."..." )
	uiConsignViewConsign( m_curPage )
	-- uiMessageBox(uiLanString("msg_task_can_accept_day_list"),uiLanString("consign_msg_title"),true,false,true)
end

function layWorld_frmEntrusthall_BtnRefresh_OnClicked( self )
	--[ Hide The Cancel delegate Button, And show the accept delegate button ]
	local btnAccept = uiGetglobal( "layWorld.frmEntrusthall.btReceiveEntrust" )
	local btnCancel = uiGetglobal( "layWorld.frmEntrusthall.btCancelEntrust" )
	local edSpecify = uiGetglobal("layWorld.frmEntrusthall.edSpecify")
	local lbxEntrust = uiGetglobal("layWorld.frmEntrusthall.lbxEntrust")
	local btnCheckTask = uiGetglobal("layWorld.frmEntrusthall.btnCheckTask")

	btnAccept:Show()
	btnCancel:Hide()	
	
	btnCheckTask:Show()
	lbxEntrust:Show()	
	edSpecify:Hide()

	
	--[ Refresh delegate list ]
	layWorld_frmEntrusthall_RefreshCurPage()
	
	--[ Hide and clear the consign detail dialog ]
	layWorld_frmEntrusthall_ClearConsignDetail()
	--local detailForm = uiGetglobal( "layWorld.frmTaskText" )
	--detailForm:Hide()	
end

function layWorld_frmEntrusthall_BtnReceiveEntrust_OnClicked( self )
	local m_lbxEntrust = uiGetglobal( "layWorld.frmEntrusthall.lbxEntrust" )
	local m_curSel = m_lbxEntrust:getSelectLine()
	if nil == m_curSel or m_curSel >= table.getn(m_delegateItems) then
		return
	end
	if m_delegateItems[m_curSel+1]["ID"] ~= nil then
		local nLev = uiGetMyInfo("Exp")
		if nLev >= 31 then
			--uiInfo("Send Request: Accept consign ID:"..m_delegateItems[m_curSel+1]["ID"] )
			uiConsignAccept( m_delegateItems[m_curSel+1]["ID"] )
		else
			uiMessageBox(uiLanString("consign_msg_4"),uiLanString("consign_msg_title"),true,false,true)
		end
	end	
end

function layWorld_frmEntrusthall_BtnCancelEntrust_OnClicked( self )
	local m_lbxDelegate = uiGetglobal( "layWorld.frmEntrusthall.lbxEntrust" )
	local m_curSel = m_lbxDelegate:getSelectLine()
	if nil == m_curSel or m_curSel >= table.getn(m_delegateItems) then
		return
	end
	if m_delegateItems[m_curSel+1]["ID"] ~= nil then
		local nLev = uiGetMyInfo("Exp")
		if nLev >= 26 then
			--uiInfo("Send Request: Cancel consign ID:"..m_delegateItems[m_curSel+1]["ID"] )
			uiConsignCancel( m_delegateItems[m_curSel+1]["ID"] )
			self:Disable()
		else
			uiMessageBox(uiLanString("consign_msg_5"),uiLanString("consign_msg_title"),true,false,true)
		end
	end	
end


function layWorld_frmEntrusthall_BtnFinishEntrust_OnClicked( self )
	uiConsignFinish()
end

function layWorld_frmEntrusthall_BtnReceptEntrust_OnClicked( self )
	--uiInfo("layWorld_frmEntrusthall_BtnReceptEntrust_OnClicked begin...")
	local m_list = uiGetglobal( "layWorld.frmEntrusthall.lbxEntrust" )
	local m_curSel = m_list:getSelectLine()
	if nil == m_curSel or m_curSel >= table.getn(m_delegateItems) then
		return
	end
	--uiInfo("ID:"..tostring(m_delegateItems[m_curSel+1]["ID"]) )
	-- 验收一个委托
	uiConsignGetResult(m_delegateItems[m_curSel+1]["ID"])
	--uiInfo("layWorld_frmEntrusthall_BtnReceptEntrust_OnClicked end...")
end

function layWorld_frmEntrusthall_BtnDistribute_OnClicked( self )
	local nLev = uiGetMyInfo("Exp")
	if nLev >= 26 then
		local m_distributeForm = uiGetglobal( "layWorld.frmEntrust" )
		if m_distributeForm:getVisible() then
			m_distributeForm:Hide()
		else
			m_distributeForm:ShowAndFocus()
		end
	else
		uiMessageBox(uiLanString("consign_msg_6"),uiLanString("consign_msg_title"),true,false,true)
	end
end

function layWorld_frmEntrusthall_BtnPrepage_OnClicked( self )
	m_curPage = m_curPage-1
	if m_curPage < 0 then
		m_curPage = 0
		local m_btnPrePage = uiGetglobal( "layWorld.frmEntrusthall.btPrepage" )
		m_btnPrePage:Disable()
	end
	uiConsignViewConsign( m_curPage )
end

function layWorld_frmEntrusthall_BtnNextpage_OnClicked( self )
	m_curPage = m_curPage+1
	uiConsignViewConsign( m_curPage )
end

--[ request show own consign list ]
function layWorld_frmEntrusthall_BtnMyconsign_OnClicked( self )
	--[ Hide The Accept delegate Button, And show the Cancel delegate button ]	
	local btnAccept = uiGetglobal( "layWorld.frmEntrusthall.btReceiveEntrust" )
	local btnCancel = uiGetglobal( "layWorld.frmEntrusthall.btCancelEntrust" )
	local edSpecify = uiGetglobal("layWorld.frmEntrusthall.edSpecify")
	local lbxEntrust = uiGetglobal("layWorld.frmEntrusthall.lbxEntrust")
	local btnCheckTask = uiGetglobal("layWorld.frmEntrusthall.btnCheckTask")
        
	btnCheckTask:Show();
	lbxEntrust:Show()
	btnAccept:Hide()
	btnCancel:Show()
	edSpecify:Hide()
	
	--[ Request own delegates which have beed distributed ]
	uiConsignViewConsign( -1 )
	
	--[ Clear the consign detail dialog ]
	layWorld_frmEntrusthall_ClearConsignDetail()
end

function layWorld_frmEntrusthall_RefreshConsignDetail()
	--[ The content container ]
	local ebxDetail = uiGetglobal( "layWorld.frmTaskText.edxTaskText" )
	
	--[ if the focus is on the delegate list ]
	local m_lbxDelegate = uiGetglobal( "layWorld.frmEntrusthall.lbxEntrust" )
	local m_curSel = m_lbxDelegate:getSelectLine()
	if nil ~= m_curSel and m_curSel>=0 and m_curSel < table.getn(m_delegateItems) then
		if m_delegateItems[m_curSel+1]["TaskID"] ~= nil then
			--uiInfo("Delegate TaskID:"..tostring(m_delegateItems[m_curSel+1]["TaskID"]))
			local numID = tonumber( m_delegateItems[m_curSel+1]["TaskID"] )
			if nil ~= numID then
				local res=uiConsignGetTaskDetailInfo( numID )
				if res and res.Detail then
					local strconsign = string.format("%s%s%s%s%s", res.Detail["begin"], res.Detail["desc"], res.Detail["title"],  res.Detail["request"], res.Detail["end"])
					ebxDetail:SetRichText(strconsign,false);
				end
			end
			return
		end
	end
	
	--[ if the focus is on the accept list ]
	local m_lbxAccept = uiGetglobal( "layWorld.frmEntrusthall.lbxReceive" )
	m_curSel = m_lbxAccept:getSelectLine()
	--uiInfo( "AcceptSel:"..tostring(m_curSel).."ItemsN:"..tostring(table.getn(m_acceptItems)) )
	if nil ~= m_curSel and m_curSel>=0 and m_curSel < table.getn(m_acceptItems) then
		if m_acceptItems[m_curSel+1]["TaskID"] ~= nil then
			--uiInfo("Accept TaskID:"..tostring(m_acceptItems[m_curSel+1]["TaskID"]))
			local numID = tonumber( m_acceptItems[m_curSel+1]["TaskID"] )
			if nil ~= numID then
				local res=uiConsignGetTaskDetailInfo( numID )
				if res and res.Detail then
					local strconsign = string.format("%s%s%s%s%s", res.Detail["begin"], res.Detail["desc"], res.Detail["title"],  res.Detail["request"] , res.Detail["end"])
					ebxDetail:SetRichText(strconsign,false);
				end
			end
			return
		end
	end
end

--[ Clear the detail content ]
function layWorld_frmEntrusthall_ClearConsignDetail()
	local ebxDetail = uiGetglobal( "layWorld.frmTaskText.edxTaskText" )
	ebxDetail:SetText("")
end

--[ Ask for task detail ]
function layWorld_frmEntrusthall_BtnCheckTask_OnClicked( self )
	--uiInfo( "layWorld_frmEntrusthall_BtnCheckTask_OnClicked begin......" )
	--[ Show the detail dialog ]
	local detailForm = uiGetglobal( "layWorld.frmTaskText" )
	detailForm:Show()
	layWorld_frmEntrusthall_RefreshConsignDetail()	
	--uiInfo( "layWorld_frmEntrusthall_BtnCheckTask_OnClicked End......" ) 
end

function layWorld_frmEntrusthall_LbxEntrust_OnSelect( self )
	--uiInfo("layWorld_frmEntrusthall_LbxEntrust_OnSelect begin...")
	local m_curSel = self:getSelectLine()
	--uiInfo("Cur sel = "..tostring(m_curSel) )
	if nil == m_curSel or -1 == m_curSel or m_curSel >= table.getn(m_delegateItems) then
		return
	end
	local m_btnAcceptDelegate = uiGetglobal( "layWorld.frmEntrusthall.btReceiveEntrust" )
	local m_btnCancelDelegate = uiGetglobal( "layWorld.frmEntrusthall.btCancelEntrust" )
	local m_btnFinishDelegate = uiGetglobal( "layWorld.frmEntrusthall.btFinishEntrust" )
	local m_btnReceptDelegate = uiGetglobal( "layWorld.frmEntrusthall.btReceptEntrust" )
	
	--uiInfo("Sstate = "..m_delegateItems[m_curSel+1]["state"] )
	if m_delegateItems[m_curSel+1]["state"] == uiLanString("consign_state_2") then
		m_btnAcceptDelegate:Disable()
		m_btnCancelDelegate:Enable()
		m_btnFinishDelegate:Disable()
		m_btnReceptDelegate:Disable()
	elseif m_delegateItems[m_curSel+1]["state"] == uiLanString("consign_state_3") then
		m_btnAcceptDelegate:Disable()
		m_btnCancelDelegate:Disable()
		m_btnFinishDelegate:Disable()
		m_btnReceptDelegate:Disable()
	elseif m_delegateItems[m_curSel+1]["state"] == uiLanString("consign_state_5") then
		m_btnAcceptDelegate:Disable()
		m_btnCancelDelegate:Disable()
		m_btnFinishDelegate:Disable()
		m_btnReceptDelegate:Enable()
	elseif m_delegateItems[m_curSel+1]["state"] == uiLanString("consign_state_1") then
		m_btnAcceptDelegate:Enable()
		m_btnCancelDelegate:Disable()
		m_btnFinishDelegate:Disable()
		m_btnReceptDelegate:Disable()
	elseif m_delegateItems[m_curSel+1]["state"] == uiLanString("consign_state_4") then
		m_btnAcceptDelegate:Disable()
		m_btnCancelDelegate:Disable()
		m_btnFinishDelegate:Enable()
		m_btnReceptDelegate:Disable()
	end
	
	--[ If the consign detail dialog is show then fresh it ]
	local detailForm = uiGetglobal( "layWorld.frmTaskText" )
	if detailForm:getVisible() == true then
		layWorld_frmEntrusthall_RefreshConsignDetail()
	end
	
	layWorld_frmEntrusthall_updateAcceptList()
	--uiInfo("layWorld_frmEntrusthall_LbxEntrust_OnSelect End...")
end

function layWorld_frmEntrusthall_LbxEntrust_OnHeaderClick( self, index )
	local bAscend = false
	local strCondition = nil
	if index == 0 then
		strCondition = "name"
	elseif index == 1 then
		strCondition = "level"
	elseif index == 2 then
		strCondition = "difficulty"
	elseif index == 3 then
		strCondition = "time"
	elseif index == 4 then
		strCondition = "state"
	end
	if nil == strCondition then
		return
	end
	if layWorld_frmEntrusthall_isDelegateConditionAscend( strCondition ) then
		layWorld_frmEntrusthall_sortDelegate( strCondition, false )
	else
		layWorld_frmEntrusthall_sortDelegate( strCondition, true )
	end
	layWorld_frmEntrusthall_updateDelegateList()
end

function layWorld_frmEntrusthall_LbxReceive_OnSelect( self )
	--uiInfo( "layWorld_frmEntrusthall_LbxReceive_OnSelect begin..." )
	local m_curSel = self:getSelectLine()
	if nil == m_curSel or -1 == m_curSel or m_curSel >= table.getn(m_acceptItems) then
		return
	end
	local m_btnAcceptDelegate = uiGetglobal( "layWorld.frmEntrusthall.btReceiveEntrust" )
	local m_btnCancelDelegate = uiGetglobal( "layWorld.frmEntrusthall.btCancelEntrust" )
	local m_btnFinishDelegate = uiGetglobal( "layWorld.frmEntrusthall.btFinishEntrust" )
	local m_btnReceptDelegate = uiGetglobal( "layWorld.frmEntrusthall.btReceptEntrust" )
	m_btnAcceptDelegate:Disable()
	m_btnCancelDelegate:Disable()	
	m_btnReceptDelegate:Disable()
	if m_acceptItems[m_curSel+1]["state"] == uiLanString("consign_state_4") then
		m_btnFinishDelegate:Enable()
	else
		m_btnFinishDelegate:Disable()
	end
	
	--[ Clear the delegate item list state ]
	layWorld_frmEntrusthall_updateDelegateList()
	
	--[ If the consign detail dialog is show then fresh it ]
	local detailForm = uiGetglobal( "layWorld.frmTaskText" )
	if detailForm:getVisible() == true then
		--uiInfo( "Refresh consign detail" )
		layWorld_frmEntrusthall_RefreshConsignDetail()
	end	
	
	--uiInfo( "layWorld_frmEntrusthall_LbxReceive_OnSelect End..." )
end


function layWorld_frmEntrusthall_btSpecify_OnLClick(self)
        local btnAccept = uiGetglobal( "layWorld.frmEntrusthall.btReceiveEntrust" )
	local btnCancel = uiGetglobal( "layWorld.frmEntrusthall.btCancelEntrust" )
	local edSpecify = uiGetglobal("layWorld.frmEntrusthall.edSpecify")
	local lbxEntrust = uiGetglobal("layWorld.frmEntrusthall.lbxEntrust")
	local btnCheckTask = uiGetglobal("layWorld.frmEntrusthall.btnCheckTask")

	btnCheckTask:Hide()
	lbxEntrust:Hide()
	btnAccept:Hide()
	btnCancel:Hide()
	edSpecify:Show()
    
end



