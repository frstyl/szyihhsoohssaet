local ttiachloak = fk.CreateSkill{
  name = "ttiachloak",
}


Fk:loadTranslationTable{
["ttiachloak"] = "漲落",
[":ttiachloak"] = "每輪始旹,(若當輪此技能未發動)伱可發動:全體角色各將1牌迻出.當牌自局外(武將牌上武將牌㫄除外區)進入弃牌堆後,伱可發動至多x次,伱抽1",

["#ttiachloak-choose"] = "漲落 選擇牌迻出",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

ttiachloak:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  trigger_times = function (self, event, target, player, data)
    if not player:hasSkill(ttiachloak.name)  then return 0  end
    local n = event:getCostData(self)
    if  n~=nil and n.n then return n.n else n = 0 end
      for _, move in ipairs(data) do
        if move.toArea == Card.DrawPile  then
          for _, info in ipairs(move.moveInfo) do
            if table.contains({Card.Void,  Card.PlayerSpecial}, info.fromArea) then
              n=n+1
            end
          end
        end
      end
    if n>0 then
      event:setCostData(self,{n=n})
    end
      return n
  end,
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(ttiachloak.name)
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1,ttiachloak.name)
  end,
})
ttiachloak:addEffect(fk.RoundStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(ttiachloak.name) and     player.room:getBanner("ttiachloak-round")~=1
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:setBanner("ttiachloak-round",1)
    local n=room:askToNumber(player, {
      min=1,
      max=player.hp,
      cancelable=false,
    })
    local param={
     players =room.alive_players,
     min_num =n, 
     max_num =n,
     include_equip=true,
     skill_name=ttiachloak.name,
     cancelable=false,
    --  pattern=".",
     prompt="#ttiachloak-choose",
    }
    local req=room:askToJointCards(player,param)
    for _, p in ipairs(room.alive_players) do
      if req[p] and  req[p][1] then
        p:addToPile("ttiachloak_ddxev", req[p], true, ttiachloak.name)
      end
    end
  end,
})

ttiachloak:addEffect(fk.RoundEnd, {
  is_delay_effect=true,
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player.room:getBanner("ttiachloak-round")==1
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    room:setBanner("ttiachloak-round",0)
    player:drawCards(5)
    for _, p in ipairs(room.alive_players) do
      local c=S.getNextOne(p,-1):getPile("ttiachloak_ddxev")[1]
      if  c then
        room:obtainCard(p, c, true, fk.ReasonPut, nil, ttiachloak.name)
      end
    end
  end,
})

return ttiachloak
