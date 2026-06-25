local hqoomstsjens = fk.CreateSkill {
  name = "hqoomstsjens",
}

Fk:loadTranslationTable{
  ["hqoomstsjens"] = "暗箭",
  [":hqoomstsjens"] = "➀恆續效果,主旹,伱可葢伏1手牌➁當伱對其它角色或其它角色對伱所使用殺被閃抵消旹,伱可將1葢伏牌轉化爲殺使用,此殺无視距離不可響應",

  ["#hqoomstsjens"] = "暗箭 選擇一牌 將其視爲葢伏牌",
  ["#hqoomstsjens-invoke"] = "暗箭 將葢伏牌轉化爲殺對 %src 殺",

  ["$hqoomstsjens1"] = "明搶易躲暗箭難防",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hqoomstsjens:addAcquireEffect(function (self, player)
  -- player.room:handleAddLoseSkills(player, "koarbiuk_active&", nil, false, true)
  S.handleAddLoseVirtualSkills(player, "koarbiuk_active&", hqoomstsjens.name, false, true)
end)

hqoomstsjens:addLoseEffect (function (self, player)
  -- player.room:handleAddLoseSkills(player, "-koarbiuk_active&", nil, false, true)  --其它 tag?
  S.handleAddLoseVirtualSkills(player, "-koarbiuk_active&", hqoomstsjens.name, false, true)
end)


hqoomstsjens:addEffect(fk.CardEffectCancelledOut, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  data.cardsResponded[1].name=="szjemh"  
    and player:hasSkill(hqoomstsjens.name)   and data.card.trueName == "ssaet" 
    and ((data.from == player )or (data.to == player ) )
    and #S.getPlayerKoarbiukCards(player) > 0
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local cards=S.getPlayerKoarbiukCards(player)
    local targets=data.from == player and {data.to.id} or {data.from.id}
    local use = room:askToUseVirtualCard(player, {  --旣視感--askToUseRealCard active  非askForUse 无旹機 can_use有效
      name = "ssaet",
      card_filter = {
        n=1,
        cards=cards,
      },
      skill_name = hqoomstsjens.name,  --提示
      prompt = "#hqoomstsjens-invoke:"..data.to.id,
      expand_pile = cards,
      cancelable = true,
      skip = true,
      extra_data = {
        -- must_targets = targets,
        -- exclusive_targets = targets,
        bypass_distances = true,  --渻?
        bypass_times = true,
        extraUse = true,
      }
    })
    if use  then
      use.disresponsiveList = table.simpleClone(room.players)
      event:setCostData(self, {use = use})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:useCard(event:getCostData(self).use)
  end,
})

return hqoomstsjens
