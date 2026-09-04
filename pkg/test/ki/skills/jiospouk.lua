local jiospouk = fk.CreateSkill({
  name = "jiospouk",
  tags = {Skill.Compulsory},
})

Fk:loadTranslationTable{
  ["jiospouk"] = "預卜",
  [":jiospouk"] = "一脚色轉始旹",

  ["jiospouk-invoke"] = "預卜：對 %src 發動",

  ["#jiospouk-turn"] = "預卜",

  -- ["$jiospouk1"] = "皓月如晝共椉歡爭忍歸來",
  -- ["$jiospouk2"] = "瓊林玉殿朝喧弦管暮列笙琶",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

jiospouk:addEffect(fk.TurnStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(jiospouk.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local cards = S.askToPlayCard(player, {
		  min_num = 1,
		  max_num = 1,
		  include_equip = true,
		  skill_name = jiospouk.name,
		  cancelable = true,
      pattern = ".",
      prompt = "#jiospouk-invoke:"..target.id,
		  skip = true,
		})
    if #cards ~= 0 then
      event:setCostData(self, {cards = cards,tos={tos}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.playCard(event:getCostData(self).cards, jiospouk.name,player)
    local judge = {
      who = target,
      reason = "jiospouk",
      pattern = ".|^0|.",
    }
    room:judge(judge)
    room:addPlayerMark(target,"@jiospouk-turn",judge.card.number)  --0爲无點
  end,
})

jiospouk:addEffect(fk.CardUsing, {
  anim_type = "control",
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return player:getMark("@jiospouk-turn") ~= 0
  end,
  on_trigger = function(self, event, target, player, data)
    local m=data.card.number
    if m==0 then return end --0爲无點 不比
    local n =player:getMark("@jiospouk-turn") 
    if m == n then return end
    if m<n then 
      S.useNullify(data,nil,jiospouk.name)
    else
      data.additionalEffect = (data.additionalEffect or 0) +1
    end
  end,
})
return jiospouk
