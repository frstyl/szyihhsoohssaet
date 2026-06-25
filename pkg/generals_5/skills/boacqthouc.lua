local boacqthouc = fk.CreateSkill {
  name = "boacqthouc",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["boacqthouc"] = "㫄通",
  [":boacqthouc"] = "鎖定.伱聲明使用牌後,若伱未記錄此此牌類,伱記錄之.伱使用牌旹,伱迻去2記錄,獲得1牌与迻去記錄不同類者",   --紅包

  ["@boacqthouc"] = "㫄通",
  ["#boacqthouc-remove"] = "㫄通：请移除两种“㫄通”标记",

  ["$boacqthouc1"] = "天乃高且远，安可事事自下。",
  ["$boacqthouc2"] = "吾等当上体天心，下济黎民。",
  ["$boacqthouc3"] = "若除贪官恶吏，天下自为之一清。",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- qwerkiams:addAcquireEffect(function (self, player, is_death)
--   local t=table
--   for i=1,5,1 do
--     t[i]=false
--   end
--   player.room:setPlayerMark(player, "@boacqthouc", t)
-- end)

boacqthouc:addLoseEffect(function (self, player, is_death)
  player.room:setPlayerMark(player, "@boacqthouc", 0)
end)

boacqthouc:addEffect(fk.CardUsing, {
  anim_type = "special",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(boacqthouc.name) and
      #player:getTableMark("@boacqthouc") >1
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local choices={"basic","trick","equip","magic","allusion"}   --紅包
    local t=player:getTableMark("@boacqthouc")
    local removed=room:askToChoices(player, {
          min_num=2,
          max_num=2,
          choices = t,
          skill_name = boacqthouc.name,
          prompt = "#boacqthouc-remove",
          -- all_choices = all_names,
          cancelable=true,
        })
    if #removed~=2 then return end
    for _, c in ipairs(removed) do
      table.removeOne(t,c)
      table.removeOne(choices,c)
    end
    player.room:setPlayerMark(player, "@boacqthouc", t)

    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = boacqthouc.name,
      prompt = "#hzouc_paav-choose",
    })

    local names=S.getCardTypeByName(S.convertType(choice),true)
    names=table.concat(names,",")
    local cards=room:getCardsFromPileByRule(".|.|.|.|"..names,1)
    room:moveCards({
        ids = cards,
        to = player,
        toArea = Card.PlayerHand,
        moveReason = fk.ReasonJustMove,  --Prey?
        proposer = player,
        skillName = boacqthouc.name,
      })
  end,
})

boacqthouc:addEffect(fk.AfterCardTargetDeclared, {
  can_refresh = function (self, event, target, player, data)
    return target == player and player:hasSkill(boacqthouc.name)
  end,
  on_refresh = function (self, event, target, player, data)
    -- local t=player:getMark("@boacqthouc")
    -- t[S.getCardTypeByName(data.card.name)]==true
    -- player.room:setPlayerMark(player, "boacqthouc", t)
    player.room:addTableMarkIfNeed(player, "@boacqthouc", S.getCardTypeByName(data.card.name,nil,true))
  end,
})


return boacqthouc
