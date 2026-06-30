

local hzoojqtszhyin= fk.CreateSkill({
  name = "hzoojqtszhyin",
})

Fk:loadTranslationTable{
["hzoojqtszhyin"] = "回萅",
[":hzoojqtszhyin"] = "一名角色回合開始旹若其已損伱可預打出1非裝僃牌發動,其回1.",

["#hzoojqtszhyin-invoke"] = "回萅 是否打出1非裝僃牌 令%src回1",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzoojqtszhyin:addEffect(fk.TurnStart,{
	anim_type = "support",
	can_trigger = function(self, event, target, player, data)
		return player:hasSkill(hzoojqtszhyin.name) and target:isWounded() 
    and not player:isKongcheng()
	end,
	on_cost = function(self, event, target, player, data)
    local card =  S.askToPlayCard(player, {
      min_num = 1,
      max_num = 1,
      include_equip = false,
      skill_name = hzoojqtszhyin.name,
      cancelable = true,
      pattern = ".|.|.|.|.|^equip",
      prompt = "#hzoojqtszhyin-invoke:"..target.id,
      skip = true,
    })
    if #card > 0 then
      event:setCostData(self, { cards = card})
      return true
    end
  end,
	on_use = function(self, event, target, player, data)
    local room=player.room
    S.playCard(player,event:getCostData(self).cards,hzoojqtszhyin.name)
    if target:isWounded() and not target.dead then
      room:recover{
        who = target,
        num = 1,
        recoverBy = player,
        skillName = hzoojqtszhyin.name,
      }
      end
    end,
})


return hzoojqtszhyin
