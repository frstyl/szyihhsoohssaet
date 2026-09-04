local khioktshuoh = fk.CreateSkill{
  name = "khioktshuoh",
}

Fk:loadTranslationTable{
  ["khioktshuoh"] = "曲取",
  [":khioktshuoh"] = "伱起動牌指定其它腳色爲目幖後,伱可發動.其抽1,肰後伱取得其1牌",

  ["#khioktshuoh-ask"] = "曲取 是否對 %src 發動",
  ["#khioktshuoh-choose"] = "曲取 選擇1手牌",

  ["$khioktshuoh1"] = "且慢",  --
  -- ["$khioktshuoh1"] = "慢著,不要輕動",  --
  ["$khioktshuoh2"] = "待俺尋思尋思",
  ["$khioktshuoh3"] = "緟新開始夫",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


-- Fk:addPoxiMethod{
--   name = "khioktshuoh_discard",
--   prompt = "#khioktshuoh-ask",
--   card_filter = function(to_select, selected, data)

--     return not (Self:prohibitDiscard(Fk:getCardById(to_select)) and table.contains(data[1][2], to_select))
--   end,
--   feasible = function(selected)
--     return #selected == 1
--   end,
-- }
khioktshuoh:addEffect(fk.TargetConfirmed, {  --TargetSpecifying TargetConfirming
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from==player
    and data.to~=player
    and player:hasSkill(khioktshuoh.name) --
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      skill_name=khioktshuoh.name,
      prompt="#khioktshuoh-ask:"..data.to.id
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if not data.to.dead then 
    data.to:drawCards(1,khioktshuoh.name)
    end
    if player.dead or data.to==player or data.to:isNude() then  return end

    local cid = room:askToChooseCard(player, { target = data.to, flag = "he", skill_name = khioktshuoh.name })
    room:obtainCard(player, cid, false, fk.ReasonPrey, player, khioktshuoh.name)

  end,
})



return khioktshuoh
