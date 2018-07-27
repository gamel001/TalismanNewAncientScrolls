GuildMaxLevel = 10;			        -- 公会最大等级
GuildCreateNeedMoney = 100000;	    -- 公会创建需要金币
GuildMemberCapacity = { 40, 55, 70, 85, 100, 115, 130, 145, 160 ,175 };   -- 公会的人数上限
GuildHouseHoldCapacity = { 3, 3, 4, 4, 5 , 5, 6 , 6 , 6 , 8};     -- 公会的堂上限

GuildTerrEnable = true;		        -- 是否开启公会领地系统
GuildTerrApplyMemberCount = 1;		-- 公会领地申请需要公会人数
GuildTerrApplyMoney = 200000;	    -- 公会领地申请需要金币
GuildTerrSceneId = 9;		        -- 公会领地的场景ID
MainToTerrPos = { 339, 101, 0 };    -- 公会领地的默认传送位置
TerrToMainPos = { 245, -479, 0 };   -- 公会领地传送回主场景的默认位置

GuildTerrContriMoney_Rate = 30;     -- 1金可以兑换的贡献度
GuildTerrContri_EveryDay = 1000000;     -- 每天最多可以兑换的贡献度

GuildBankHistoryCount = 500;        -- 帮会仓库保留的历史数目

GuildOpTimeMgrNeed     = 1;     -- 1秒 堂主职位变更
GuildOpTimeSenatorNeed = 86400;     -- 24小时 长老职位变更
GuildOpTimeLeaderNeed  = 86400;     -- 24小时 帮主职位变更
GuildMaxBundCount = 3