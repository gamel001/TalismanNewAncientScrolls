OpenFlag = 1 --��̯ϵͳ�Ƿ񿪷�, 1 : ����, 0 : �ر�

MinStallLevel = 10 --��̯��С�ȼ�

CanBuyWhenStall = 0 --��̯ʱ�Ƿ�����������̯λ�Ķ�����1 : ����, 0 : ������

MaxSloganTextSize = 24 --��̯���Ƶ�����ֽڳ���

MaxStallTalkPageItemSize = 20 --��������ֽڳ���

MaxStallTalkPageItemCount = 32 --�����������

StallArea = {2} --���԰�̯������Id

MinStallInterval = 80 --��̯��С���

function OnStallStateChanged(nUserId, nStallState, nLevel, nSex)

	if nStallState == 1 then
	   if nLevel < 60 then
	     if nSex == 0 then
		SetModel(nUserId, 4588)
             else
                SetModel(nUserId, 4588)
	     end
	   elseif nLevel >= 0 then
	     if nSex == 0 then
		SetModel(nUserId, 5141)
	     else
		SetModel(nUserId, 5136)
             end
	   end
	else
		ResetModel(nUserId)
	end

end

