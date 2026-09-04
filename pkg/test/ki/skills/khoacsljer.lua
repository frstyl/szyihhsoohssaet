local khoacsljer = fk.CreateSkill {
  name = "khoacsljer",
}

Fk:loadTranslationTable{
["khoacsljer"] = "抗勵",
[":khoacsljer"] = "伱體力變化後,伱可發動,伱抽x(x爲伱體力數)",

["#khoacsljer-invoke"] = "抗勵 抽 %arg",
["#khoacsljer-choose"] = "抗勵 選1手牌發動.其1轉內視爲因勢利導",

["@@khoacsljer-turn"] = "抗勵",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

khoacsljer:addEffect(fk.HpChanged, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(khoacsljer.name) 
    and not data.prevented
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room

    return room:askToSkillInvoke(player, {
      skill_name = khoacsljer.name,
      prompt = "#khoacsljer-invoke:::"..player.hp,
    }) 

  end,
  on_use = function(self, event, target, player, data)
    -- local n = math.max(1,player.hp)
	local n = player.hp
	if n>0 then
    player:drawCards(n,khoacsljer.name)
	end
  end,
})



return khoacsljer
