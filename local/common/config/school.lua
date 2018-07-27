--int GetUserParty(int nUserId)
--int GetUserLevel(int nUserId)

--void CreateItemAndMail(
--    int nUserId,
--    int nItemClassId,
--    char *pszItemColor,
--    char *pszItemBind,
--    int nLimitTime,
--    int nUpdatelev,
--    int nSmithingLev,
--    int nAttributeId
--)

--void AddTeacherPoint(int nTeacherId, int nTeacherPoint)

--void AddUserExp(int nUserId, int nExp)

--void AddUserNimbus(int nUserId, int nNimbus)

--Npc function:
--rtl 求师榜
--graduate 出师
--tptc 师道值换取声望

OpenFlag = 1 --师徒系统是否开放, 1 : 开放, 0 : 关闭

MinStduentReqLev = 1 --最小徒弟等级
MaxStduentReqLev = 25 --最大徒弟等级
MinTeacherLev = 5 --最小师傅等级
MaxUngraduateStduentCnt = 5 --最多学徒数量
TeacherAwardExpRate = 0.10 --出师前，学徒每升一级，师傅得到的当前等级经验比率
TeacherAwardNimbusRate = 0.40 --出师前，学徒每升一级，师傅得到的当前等级灵力比率
StudentAwardExpRate = 0.05 --出师前，学徒每升一级，学徒得到的当前等级经验比率
StudentAwardNimbusRate = 0.20 --出师前，学徒每升一级，学徒得到的当前等级灵力比率
GraduateLev = 25 --出师等级
AlertReportTimeInterval = 7*24*60*60 --学徒多长时间没有汇报成绩，师傅可以无惩罚的开除他
SchoolExpPunishRate = 0.05 --学徒离开师门或者师傅无故开除学徒时，相应的扣除当前等级经验的比率
UserForbidTimeDuration = 6*60*60 --学徒离开师门或者师傅无故开除学徒时，禁止操作师徒系统的时间
CanAcceptStudent = 1

--[npc 类型ID] = {声望Id, 1点师道值换取的声望值}
TeacherPointToCredit = {
    [406] = {CreditId = 14, PerTeacherPointToCredit = 100},
    [407] = {CreditId = 17, PerTeacherPointToCredit = 100},
    [413] = {CreditId = 15, PerTeacherPointToCredit = 100},
    [414] = {CreditId = 16, PerTeacherPointToCredit = 100},
    [4447] = {CreditId = 29, PerTeacherPointToCredit = 100},
    [4865] = {CreditId = 29, PerTeacherPointToCredit = 100},	
    [4101] = {CreditId = 26, PerTeacherPointToCredit = 100},
    [4201] = {CreditId = 22, PerTeacherPointToCredit = 100},
    [4512] = {CreditId = 13, PerTeacherPointToCredit = 100},
    [4650] = {CreditId = 28, PerTeacherPointToCredit = 100},
    [4651] = {CreditId = 30, PerTeacherPointToCredit = 100},
    [4415] = {CreditId = 31, PerTeacherPointToCredit = 100},
    [4863] = {CreditId = 33, PerTeacherPointToCredit = 100},
    [4864] = {CreditId = 33, PerTeacherPointToCredit = 100},
    [5041] = {CreditId = 33, PerTeacherPointToCredit = 100},
}

function OnStudentLevelUp(nStudentId, nLevel, nState) --学徒升级
     iParty=GetUserParty(nStudentId)
     if nLevel == 10 then
       if iParty == 0 then
         CreateItemAndMail(nStudentId, 5, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 15, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 1 then
	 CreateItemAndMail(nStudentId, 25, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 35, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 2 then
	 CreateItemAndMail(nStudentId, 551, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 561, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 3 then
	 CreateItemAndMail(nStudentId, 55, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 45, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 4 then
	 CreateItemAndMail(nStudentId, 629, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 639, "blue", "binded", 0, 0, 0, 156)
       end
    elseif nLevel == 20 then
       CreateItemAndMailToTeacher(3970, "white", "binded", 0, 0, 0, 0)
       if iParty == 0 then
         CreateItemAndMail(nStudentId, 6, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 16, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 1 then
	 CreateItemAndMail(nStudentId, 26, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 36, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 2 then
	 CreateItemAndMail(nStudentId, 552, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 562, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 3 then
	 CreateItemAndMail(nStudentId, 56, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 46, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 4 then
	 CreateItemAndMail(nStudentId, 630, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 640, "blue", "binded", 0, 0, 0, 156)
       end
   elseif nLevel == 30 then
       CreateItemAndMailToTeacher(3971, "white", "binded", 0, 0, 0, 0)
   elseif nLevel == 40 then
       CreateItemAndMail(nStudentId, 3971, "white", "binded", 0, 0, 0, 0)
       CreateItemAndMail(nStudentId, 3971, "white", "binded", 0, 0, 0, 0)
       CreateItemAndMailToTeacher(382, "white", "unbinded", 0, 0, 0, 0)
       CreateItemAndMailToTeacher(382, "white", "unbinded", 0, 0, 0, 0)
       CreateItemAndMailToTeacher(382, "white", "unbinded", 0, 0, 0, 0)
       CreateItemAndMailToTeacher(402, "white", "unbinded", 0, 0, 0, 0)
   end
end

function OnGraduateTeacher(nTeacherId, nCurGraduateStudentCount) --师傅的学徒出师
    nAddTeacherPoint = 10 + (nCurGraduateStudentCount - 1) * 2
    AddTeacherPoint(nTeacherId, nAddTeacherPoint)
end

function OnGraduateStudent(nStudentId, nLevel) --学徒出师
    iParty=GetUserParty(nStudentId)
    if iParty == 0 then
         CreateItemAndMail(nStudentId, 7, "green", "binded", 0, 0, 0, 153)
         CreateItemAndMail(nStudentId, 17, "green", "binded", 0, 0, 0, 153)
    elseif iParty == 1 then
         CreateItemAndMail(nStudentId, 27, "green", "binded", 0, 0, 0, 153)
	 CreateItemAndMail(nStudentId, 37, "green", "binded", 0, 0, 0, 153)
    elseif iParty == 2 then
	 CreateItemAndMail(nStudentId, 553, "green", "binded", 0, 0, 0, 153)
	 CreateItemAndMail(nStudentId, 563, "green", "binded", 0, 0, 0, 153)
    elseif iParty == 3 then
	 CreateItemAndMail(nStudentId, 57, "green", "binded", 0, 0, 0, 153)
	 CreateItemAndMail(nStudentId, 47, "green", "binded", 0, 0, 0, 153)
    elseif iParty == 4 then
	 CreateItemAndMail(nStudentId, 631, "green", "binded", 0, 0, 0, 153)
	 CreateItemAndMail(nStudentId, 641, "green", "binded", 0, 0, 0, 153)
    end
end


function OnReportGrade(nTeacherId, nStudentId, nReportLev)  --学徒汇报获得师道值
    iStudentLv = GetUserLevel(nStudentId)
    iPreLv = iStudentLv - nReportLev    
    if iPreLv  >= 10 then
	 nAddTeacherPoint = nReportLev
         AddTeacherPoint(nTeacherId, nAddTeacherPoint)
    elseif iPreLv <10 then
	 if (iStudentLv - 10) > 0 then
	    nAddTeacherPoint = iStudentLv - 10
	    AddTeacherPoint(nTeacherId, nAddTeacherPoint)
         end
    end  
end