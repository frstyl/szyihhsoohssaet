Fk:loadTranslationTable{
  ["kiaploav"] = "劫牢",
  [":kiaploav"] = "任一末段始旹,若其下家A有牢或伏區有延旹錦囊,伱可預打出1殺或武器牌發動.下家迻去全部牢与伏區延旹錦囊",

  ["#kiaploav-discard"] = "劫牢 是否解救%src",
 
  ["$kiaploav1"] = "我等在此堅守戒僃",
  ["$kiaploav2"] = "昰後路早就安排妥當",
}

local kiaploav = fk.CreateSkill{
  name = "kiaploav",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

kiaploav:addEffect(fk.TurnEnd, {  --歬轉終
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(kiaploav.name) then return end
    local to= S.getNextOne(target)
    return (to:getMark("loav")>0 or #S.getPlayerDelayCards(to)>0)
    and not player:isNude()
  end,
    on_cost = function(self, event, target, player, data)
      local cards= S.askToPlayCard(player,{
        min_num=1,
        max_num=1,
        include_equip=true,
        pattern = "ssaet|.|.;.|.|.|.|.|weapon",
        cancelable=true,
        prompt="#kiaploav-discard:"..target:getNextAlive().id,
        skip=true,
      })
      if #cards>0 then 
        event:setCostData(self, {cards = cards})
        return true
      end
    end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.playCard(player,event:getCostData(self).cards,kiaploav.name)
    --引用
    local to = target:getNextAlive()  --迻除 修整
    room:doIndicate(player, to)

    S.deControl(to,kiaploav.name)

    -- room:setPlayerMark(to,"loav",0)
    -- local cids= to:getCardIds("j")
    -- cids=table.filter(cids,function(id)
    --   return Fk:getCardById(id).sub_type==Card.SubtypeDelayedTrick
    -- end)
    -- room:throwCard(cids, kiaploav.name, to, player)
  end,
})


return kiaploav
