local nzjevhdvoat = fk.CreateSkill {
  name = "nzjevhdvoat",
}

Fk:loadTranslationTable{
  ["nzjevhdvoat"] = "擾奪",
  -- [":nzjevhdvoat"] = "補段終旹,,伱可預弃1牌選擇其它角色區內1牌發動.伱獲得所選牌", 
  [":nzjevhdvoat"] = "補段終旹,,伱可選其它角色區內1牌發動.伱將其置入伱對應區域", 

  ["#nzjevhdvoat-choose"] = "弃1 獲得其它角色1牌",

  ["$nzjevhdvoat1"] = "羊毛出在羊身上喚作无厶",  --
}
nzjevhdvoat:addEffect(fk.EventPhaseEnd, {
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(nzjevhdvoat.name) and player.phase==Player.Draw 
    and not player:isNude()
    end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets = table.filter(room.alive_players, 
      function(p)
      return not p:isAllNude() and  p~=player
      end)
      local to, discard =  room:askToChooseCardsAndPlayers(player, {
        min_card_num = 0,
        max_card_num = 0,
        min_num = 1,
        max_num = 1,
        targets = targets,
        prompt = "#nzjevhdvoat-choose",
        skill_name = nzjevhdvoat.name,
        will_throw = true,
        cancelable = true,
      })

      if #to==0 then return end
      local get = room:askToChooseCard(player,{
        target = to[1],
        flag = "hej",
        skill_name = nzjevhdvoat.name,
        })
      event:setCostData(self, {discard=discard, get = {get}, area=room:getCardArea(get),tos=to})
      return true
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local dat=event:getCostData(self)
    -- if player.dead then return end
    -- room:throwCard(dat.discard, nzjevhdvoat.name, player, player)
    if player.dead then return end
    -- if  #room.logic:moveCardsHoldingAreaCheck(dat.get)==0 then return end
    --迻動檢測
    if dat.area==room:getCardArea(dat.get) and room:getCardOwner(dat.get[1]) == dat.tos[1] then
    room:moveCardTo(dat.get, dat.area, player, fk.ReasonPut, nzjevhdvoat.name, nil, false, player.id)
    end
  end,
})


return nzjevhdvoat
