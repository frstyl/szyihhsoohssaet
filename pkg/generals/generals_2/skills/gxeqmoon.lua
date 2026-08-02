

local gxeqmoon= fk.CreateSkill({
  name = "gxeqmoon",
})

Fk:loadTranslationTable{
["gxeqmoon"] = "奇門",
[":gxeqmoon"] = "一脚色轉始歬,選擇一其它脚色A發動(不能已被奇門).A占卜.占卜後伱可打出1手牌与占卜牌同色,令A失去當旹全部技能,轉終旹或此技能離場旹A獲得因此所失技能.",
["#gxeqmoon-choose"] = "奇門 %src轉始 選擇一脚色，令其占卜",
["#gxeqmoon-discard"] = "奇門 弃1 %arg 手牌令 %src  失去技能至轉終",
["@[:]gxeqmoon"] = "奇門 ",
-- ["gxeqmoon_target"] = "奇門 ",
}


local S = require "packages/szyihhsoohssaet/szyih_guos"



gxeqmoon:addEffect(fk.BeforeTurnStart,{  --未始
	anim_type = "control",
	can_trigger = function(self, event, target, player, data)
		return player:hasSkill(gxeqmoon.name) 
	end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local targets=table.filter(room:getOtherPlayers(player, true, true),function(p)
		return p:getMark("@[:]gxeqmoon")==0
		end)
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = targets,  --可封死者
      skill_name = gxeqmoon.name,
      prompt = "#gxeqmoon-choose:"..target.id,
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
	on_use = function(self, event, target, player, data)
		local room = player.room
		local to = event:getCostData(self).tos[1] --id
		--1 死也占卜
		local judge = {
		  who = to,
		  reason = gxeqmoon.name,
		  pattern = ".|.|.",
		}
		room:judge(judge)
		if judge.card == nil then return end
		if judge.card.color == nil then return end
			-- local colors = {}
			-- table.insert(colors, judge.card:getColorString())
		if judge.card.color == Card.NoColor then return end--无色无同色



		local color = judge.card.color
		local cards=room:askToCards(player,{
			min_num=1,
			max_num=1,
			include_equip=false,
			pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
				return Fk:getCardById(id).color == color and not player:prohibitResponse(Fk:getCardById(id))
			end
			) }),
			prompt = "#gxeqmoon-discard:" .. to.id .. "::" .. judge.card:getColorString(),
			cancelable = true,
		})
		if #cards==0 then return end
		--2

		S.playCard(player,cards,gxeqmoon.name)
		--3
		if to.dead then return  end

		local skills = {}
		for _, s in ipairs(to:getSkillNameList()) do  --視爲有不失去 且搜不到
		if Fk.skills[s] and Fk.skills[s]:isPlayerSkill(to) then
			table.insertIfNeed(skills, s)
			end
		end
		if #skills == 0 then return end

		--多次發動 一起淸
		local t
		t= to:getTableMark("@[:]gxeqmoon")  --simpleClone
		table.insertTableIfNeed(t,skills)
		room:setPlayerMark(to, "@[:]gxeqmoon", table.simpleClone(t))

		t = to:getTableMark("gxeqmoon_from")
		table.insertIfNeed(t, player.id)
		room:setPlayerMark(to, "gxeqmoon_from", table.simpleClone(t))

		t = player:getTableMark("gxeqmoon_target")
		t[to.id]=t[to.id] or {}
		table.insertTableIfNeed(t[to.id],skills)
		room:setPlayerMark(player,"gxeqmoon_target",table.simpleClone(t))

		-- room:setPlayerMark(to, "@[:]gxeqmoon", skills)
		-- room:setPlayerMark(to, "gxeqmoon_from", player.id)
		-- room:setPlayerMark(player, "gxeqmoon_target", table.map(event:getCostData(self).tos, Util.IdMapper))  --26-7-31早期不行

	  room:handleAddLoseSkills(to, "-"..table.concat(skills, "|-"), nil, true, false)

	end,
})


gxeqmoon:addEffect(fk.TurnEnd,{   --目幖
  can_refresh = function(self, event, target, player, data)
    return target == player  --行動敘
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
		for _,p in pairs(room.alive_players) do
			if p:getMark("@[:]gxeqmoon") ~= 0  then --目幖
				for _, pid in pairs(p:getMark("gxeqmoon_from")) do
					local from =room:getPlayerById(pid)
					if not from.dead then
						local t=p:getTableMark("gxeqmoon_target")  --simpleClone
						t[p.id] = nil
						room:setPlayerMark(from,"gxeqmoon_target",t)
					end
				end
				local skills = p:getTableMark("@[:]gxeqmoon")
				room:setPlayerMark(p, "@[:]gxeqmoon", 0)
				room:handleAddLoseSkills(p, table.concat(skills, "|"), nil, true, false)
			end
		end
	end,
})


local clean_spec =function(player)  --源
    local room = player.room
		local t = player:getTableMark("gxeqmoon_target")
		for _, p in pairs(room:getOtherPlayers(player)) do
			if t[p.id] and not p.dead  then --目幖死不拏回技能
				room:handleAddLoseSkills(p, table.concat(t[p.id], "|"), nil, true, false)
				local temp={}
				for _, name in pairs(p:getTableMark("@[:]gxeqmoon")) do
					if not table.contains(t[p.id],name) then
						table.insertIfNeed(temp,name)
					end
				end
				if #temp==0 then temp=nil end
				room:setPlayerMark(p,"@[:]gxeqmoon",temp)  --目幖再拏回??
				room:removeTableMark(p,"gxeqmoon_from",player.id)
			end
		end
		room:setPlayerMark(player,"gxeqmoon_target",nil)
end

gxeqmoon:addEffect(fk.Death,{ 
  can_refresh = function(self, event, target, player, data)
    return target == player and player:getMark("gxeqmoon_target") ~= 0  --源
  end,
  on_refresh = function(self, event, target, player, data)
		clean_spec(player)
	end,
})

gxeqmoon:addEffect(fk.EventLoseSkill,{ --可能无失機而不回復?
  can_refresh = function(self, event, target, player, data)
    return target == player
		 and data.skill.name==gxeqmoon.name
		 and player:getMark("gxeqmoon_target") ~= 0
  end,
  on_refresh = function(self, event, target, player, data)
		clean_spec(player)
	end,
})


return gxeqmoon
