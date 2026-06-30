


local sjevqtsoeoj= fk.CreateSkill({
  name = "sjevqtsoeoj",
})

Fk:loadTranslationTable{
["sjevqtsoeoj"] = "消災",
[":sjevqtsoeoj"] = "當伱受傷旹,若有傷害來源且不爲伱,伱可交与一其他角色A2手牌,將傷害轉与A,若A爲傷源,改爲防止傷害",

["#sjevqtsoeoj"] = "消災 交出2手牌 轉迻傷害",

["$sjevqtsoeoj1"] = "上下使得銀兩,可免三百殺威棒",
["$sjevqtsoeoj2"] = "財可通神,止當破財消災",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

sjevqtsoeoj:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  prompt = "#sjevqtsoeoj",
	can_trigger = function(self, event, target, player, data)
		return target == player  and player:hasSkill(sjevqtsoeoj.name)
    and data.from and data.from~=player 
    and player:getHandcardNum()>=2   --不當在此
	end,
  on_cost = function(self, event, target, player, data)
    tos, cards = player.room:askToChooseCardsAndPlayers(player,{
        min_num = 1,
        max_num = 1,
        min_card_num = 2,
        max_card_num = 2,
        targets = player.room:getOtherPlayers(player,false),
        pattern = ".|.|.|hand",
        skill_name = sjevqtsoeoj.name,
        prompt = "#sjevqtsoeoj",
        cancelable = true,
        -- expand_pile = ids,
    })
    if #cards > 0 and #tos>0 then
      event:setCostData(self, {tos = tos, cards = cards})
      return true
    end
  end,
	on_use = function(self, event, target, player, data)  --jujkeir
    local room = player.room
    local n = data.damage

    local to = event:getCostData(self).tos[1]
    room:moveCardTo(event:getCostData(self).cards, Player.Hand, to, fk.ReasonGive, sjevqtsoeoj.name, nil, false, player.id,nil)

    if to==data.from then
    S.preventDamage({damageData=data,skillName=sjevqtsoeoj.name})
      return 
    end
    if not to.dead then
      data.to=to
      -- room:damage{
      --   from = data.from,
      --   to = to,
      --   damage = n,
      --   damageType = data.damageType,
      --   skillName = data.skillName,
      --   chain = data.chain,
      --   card = data.card,
      -- }
    end
  end,
})

return sjevqtsoeoj

