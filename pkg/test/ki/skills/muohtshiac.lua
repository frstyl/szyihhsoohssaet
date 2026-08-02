local muohtshiac = fk.CreateSkill {
  name = "muohtshiac",
}

Fk:loadTranslationTable{
  ["muohtshiac"] = "舞鏘",
  [":muohtshiac"] = "伱受傷後,伱可將1至多牌轉化爲殺對傷源起動發動.起動後伱抽x",

  ["#muohtshiac-invoke"] = "舞鏘：令 %src 交予伱牌或受傷",

  ["$muohtshiac1"] = "事已至此，当思后策。",
  ["$muohtshiac2"] = "休养生息，无碍徐图天下。",
}
muohtshiac:addEffect(fk.Damaged, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(muohtshiac.name) and target == player 
    and data.from and data.from~=player
  end,
  on_cost = function (self, event, target, player, data)
    local use = player.room:askToUseVirtualCard(player, {
      name = "ssaet",
      skill_name = muohtshiac.name,
      prompt = "#muohtshiac-use",
      cancelable = true,
      extra_data = {
        bypass_distances = false,
        extraUse = false,
        bypass_times=false,
      },
      card_filter = {
        n = {1,999},
        -- cards = cards,
      },
      skip = true,
    })
    if use then
      event:setCostData(self, {use=use,tos={data.from}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    if player.dead then return end
    local room = player.room
    local use =event:getCostData(self).use
    room:useCard(use)
    if player.dead then return end
    player:drawCards(#use.card.subcards,muohtshiac.name)
  end,
})

--   on_cost = function(self, event, target, player, data)
--       local cards = player.room:askToCards(player, {
--         min_num = 1,
--         max_num = 99,
--         include_equip = false,
--         skill_name = muohtshiac.name,
--         prompt = "#muohtshiac-choose",
--         cancelable = true,
--       })
--       if #cards>0 then
--         event:setCostData(self,{cards=cards})
--         return true
--       end
--     end,
--   on_use = function(self, event, target, player, data)
--     if player.dead then return end
--     local room = player.room
--     room:recastCard(event:getCostData(self).cards, player, muohtshiac.name)
--     room:useVirtualCard("ssaet", nil, player, {data.from}, muohtshiac.name, true)  --zzin souk
--   end,
-- })

return muohtshiac
