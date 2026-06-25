

local gxeqmoon= fk.CreateSkill({
  name = "gxeqmoon",
})

Fk:loadTranslationTable{
["gxeqmoon"] = "奇門",
[":gxeqmoon"] = "任一角色回合開始歬,選擇一其它角色A發動(不能已被奇門).A判定.判定後伱可打出一張与判定牌同色手牌,令A失去當旹全部技能,轉終旹或此技能離場旹A褈獲得因此所失去技能.",
["#gxeqmoon-choose"] = "奇門 選擇一名角色，令其判定",
["#gxeqmoon-discard"] = "奇門 弃1 %arg 手牌令 %src  失去技能至回合終",
["@[:]gxeqmoon"] = "奇門 ",
-- ["_gxeqmoon_list"] = "奇門 ",
}


local S = require "packages/szyihhsoohssaet/szyih_guos"


local clean_spec =function(player) 
    local room = player.room
		local p=room:getPlayerById(player:getTableMark("_gxeqmoon_list")[1])
		local skills = p:getTableMark("@[:]gxeqmoon")
		room:handleAddLoseSkills(p, table.concat(skills, "|"), nil, true, false)
		room:setPlayerMark(p, "@[:]gxeqmoon", 0)
    room:setPlayerMark(player, "_gxeqmoon_list", 0)
end

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
      prompt = "#gxeqmoon-choose",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
	on_use = function(self, event, target, player, data)
		local room = player.room
		local target = event:getCostData(self).tos[1] --id
		--1 死也判定
		local judge = {
		  who = target,
		  reason = gxeqmoon.name,
		  pattern = ".|.|.",
		}
		room:judge(judge)
		if judge.card == nil then return end
		if judge.card.color == nil then return end
			-- local colors = {}
			-- table.insert(colors, judge.card:getColorString())
		if judge.card.color == Card.NoColor then return end--无色无同色


		-- local yes, dat = room:askToUseActiveSkill(player, {
		-- skill_name = "askToDiscardHomoChromic",
		-- prompt = "#gxeqmoon-discard:" .. target.id .. "::" .. judge.card:getColorString(),
		-- cancelable = true,
		-- skip = true,  --不執行
		-- extra_data = {
		-- 	same_color = true,
		-- 	color = judge.card.color,  --必塡
		-- 	},
		-- })
		local color = judge.card.color
		local cards=room:askToCards(player,{
			min_num=1,
			max_num=1,
			include_equip=false,
			pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
				return Fk:getCardById(id).color == color and not player:prohibitResponse(Fk:getCardById(id))
			end
			) }),
			prompt = "#gxeqmoon-discard:" .. target.id .. "::" .. judge.card:getColorString(),
			cancelable = true,
		})
		if #cards==0 then return end
		--2
			-- room:throwCard(cards, gxeqmoon.name, player, player)  
			-- room:responseCard({
			-- 	card=Fk:getCardById(cards[1]),
			-- 	from=player,
			-- 	attachedSkillAndUser={muteCard=true},
			-- })
			S.playCard(player,cards,gxeqmoon.name)
		--3
		if target.dead then return  end
		local skills = {}
		for _, s in ipairs(target:getSkillNameList()) do
		if s:isPlayerSkill(target) then
			table.insertIfNeed(skills, s.name)
			end
		end
		if #skills == 0 then return end
		room:setPlayerMark(target, "@[:]gxeqmoon", skills)
	  room:handleAddLoseSkills(target, "-"..table.concat(skills, "|-"), nil, true, false)
		room:setPlayerMark(player, "_gxeqmoon_list", table.map(event:getCostData(self).tos, Util.IdMapper))
		
		-- local turnEvent = room.logic:getCurrentEvent():findParent(GameEvent.Turn)
		-- if turnEvent then
		-- 	 turnEvent:addCleaner(function()
		-- 	clean_spec(player)
		-- 	end)
		-- end
	end,
})

gxeqmoon:addEffect(fk.TurnEnd,{ 
  can_refresh = function(self, event, target, player, data)
    return target == player and #player:getTableMark("_gxeqmoon_list") ~= 0
  end,
  on_refresh = function(self, event, target, player, data)
			clean_spec(player)
	end,
})
gxeqmoon:addEffect(fk.Death,{ 
  can_refresh = function(self, event, target, player, data)
    return target == player and #player:getTableMark("_gxeqmoon_list") ~= 0
  end,
  on_refresh = function(self, event, target, player, data)
			clean_spec(player)
	end,
})

gxeqmoon:addEffect(fk.EventLoseSkill,{ --可能无失機而不回復
  can_refresh = function(self, event, target, player, data)
    return target == player and data.skill.name==gxeqmoon.name
  end,
  on_refresh = function(self, event, target, player, data)
			clean_spec(player)
	end,
})
-- gxeqmoon:addLoseEffect (function (self, player)
-- 	if #player:getTableMark("_gxeqmoon_list") ~= 0 then  --引用

-- 	local room = player.room
-- 	local p=room:getPlayerById(player:getTableMark("_gxeqmoon_list")[1])
-- 	local skills = p:getTableMark("@[:]gxeqmoon")
-- 	room:handleAddLoseSkills(p, table.concat(skills, "|"), nil, true, false)
-- 	room:setPlayerMark(p, "@[:]gxeqmoon", 0)
--     room:setPlayerMark(player, "_gxeqmoon_list", 0)
-- end
-- end)

return gxeqmoon
