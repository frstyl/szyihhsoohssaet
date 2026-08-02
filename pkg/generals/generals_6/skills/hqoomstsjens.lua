local hqoeomstsjens = fk.CreateSkill {
  name = "hqoeomstsjens",
}

Fk:loadTranslationTable{
  ["hqoeomstsjens"] = "暗箭",
  [":hqoeomstsjens"] = "➀恆續效果,主旹,伱可葢伏1手牌➁當伱對其它脚色或其它脚色對伱所起動殺被閃抵消旹,伱可將1葢伏牌轉化爲殺起動,此殺无視距離不可響應",

  ["#hqoeomstsjens"] = "暗箭 選擇一牌 將其視爲葢伏牌",
  ["#hqoeomstsjens-invoke"] = "暗箭 將葢伏牌轉化爲殺對 %src 殺",

  ["$hqoeomstsjens1"] = "明搶易躲暗箭難防",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hqoeomstsjens:addAcquireEffect(function (self, player)
  -- player.room:handleAddLoseSkills(player, "koarbiuk_active&", nil, false, true)
  S.handleAddLoseVirtualSkills(player, "koarbiuk_active&", hqoeomstsjens.name, false, true)
end)

hqoeomstsjens:addLoseEffect (function (self, player)
  -- player.room:handleAddLoseSkills(player, "-koarbiuk_active&", nil, false, true)  --其它 tag?
  S.handleAddLoseVirtualSkills(player, "-koarbiuk_active&", hqoeomstsjens.name, false, true)
end)


hqoeomstsjens:addEffect(fk.CardEffectCancelledOut, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  data.cardsResponded[1].name=="szjemh"  
    and player:hasSkill(hqoeomstsjens.name)   and data.card.trueName == "ssaet" 
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
      skill_name = hqoeomstsjens.name,  --提示
      prompt = "#hqoeomstsjens-invoke:"..data.to.id,
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

return hqoeomstsjens
