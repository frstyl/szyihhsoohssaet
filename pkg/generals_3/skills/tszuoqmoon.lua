local tszuoqmoon = fk.CreateSkill({
  name = "tszuoqmoon",
  -- tags={Skill.Compulsory},
})

Fk:loadTranslationTable{
  ["tszuoqmoon"] = "朱門",
  [":tszuoqmoon"] = "➀游戲始旹,必發.視爲使用樹上開花(不可被抵消)➁殺鬥將迷對伱生效歬,若伱裝僃區有同色牌,伱可發動.此牌對伱无效",


  ["$tszuoqmoon1"] = "官人我臉申過去伱敢打无",
  ["$tszuoqmoon2"] = "柔偄是立身之本,剛彊是惹火之胎",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tszuoqmoon:addEffect(fk.GameStart, {
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(tszuoqmoon.name)
  end,
  on_cost=Util.TrueFunc,
  on_use = function(self, event, target, player, data)
    player.room:useVirtualCard("dzzuoh_dzziach_khoeoj_hsfa", nil, player, {player}, tszuoqmoon.name, true)  --zzin souk


    -- local card = Fk:cloneCard("dzzuoh_dzziach_khoeoj_hsfa")  --虛牌鎖无色?
    -- card.skillName = tszuoqmoon.name
    -- -- card:addFakeSubcard(cards)
    -- player.room:useCard{
    --   from = player,
    --   tos = {player},
    --   card = card,
    --   unoffsetableList = table.simpleClone(player.room.players)
    -- }

  end,
})

tszuoqmoon:addEffect(fk.PreCardEffect, {
  can_trigger = function(self, event, target, player, data)
      if   data.to==player and player:hasSkill(tszuoqmoon.name) and data.card and  table.contains({"ssaet","tous_tsiacs","meej"},data.card.trueName) and data.card.suit~=Card.NoSuit then 
        local suit = data.card.suit
        for _,id in ipairs(player:getCardIds("e")) do
          if Fk:getCardById(id).suit==suit then
            return true
          end
        end
      end
  end,
  on_use = function(self, event, target, player, data)
    S.effectNullify(data,player,tszuoqmoon.name)
  end,
})



return tszuoqmoon
