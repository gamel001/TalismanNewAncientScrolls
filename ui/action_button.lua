

function OnClick_ActionButton(self)
	if (ActionButtons[self:getParam1()]) then
	    local poseInfo = ActionButtons[self:getParam1()];
		PlayAction(poseInfo[2], poseInfo[3], poseInfo[4], poseInfo[5]);
	end
end

function OnHint_ActionButton(self)
    if (ActionButtons[self:getParam1()]) then
	    local poseInfo = ActionButtons[self:getParam1()];
		self:SetHintText(Language(poseInfo[2]));
	end
end

function OnDragOut_ActionButton(self)
	SetDragSlots(self:getParam1(), self)
end
