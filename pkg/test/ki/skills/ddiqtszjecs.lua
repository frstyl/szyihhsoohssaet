local ddiqtszjecs = fk.CreateSkill {
  name = "ddiqtszjecs",
}

Fk:loadTranslationTable{
  ["ddiqtszjecs"] = "持正",
  [":ddiqtszjecs"] = "應動｡當伱對其它脚色致傷旹,伱可發動,伱与其同旹各弃1,若不同色,傷害值+1.伱受到其它脚色傷旹,伱可發動,伱与其各抽1展示,若同色,傷害值-1",

  ["ddiqtszjecs-choose"] = "持正",
  ["draw1"] = "抽1",
  ["ddiqtszjecs-discard"] = "弃 %src 1牌",
  ["Cancel"] = "否",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 



ddiqtszjecs:addEffect(fk.DamageCaused,{
  can_trigger = function(self, event, target, player, data)
    if  data.from  == player and player:hasSkill(ddiqtszjecs.name) and data.to and data.to~=player then
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local to =data.to
    local c1,c2
    local room=player.room
    if not player.dead then 
      c1 = room:askToDiscard(player, {
        min_num = 1,
        max_num = 1,
        include_equip = true,
        skill_name = ddiqtszjecs.name,
        prompt = "#ddiqtszjecs-invoke",
        cancelable = false,
        skip = true,
      })
    end

      local t=room:askToJointCards(player,{
        players={player,to},
        min_num = 1,
        max_num = 1,
        include_equip=false,
        skill_name = ddiqtszjecs.name,
        pattern = ".",
        prompt = "#ddiqtszjecs-discard",
        cancelable = false,
        will_throw=true,
        -- expand_pile
      })
    
      local moveInfos = {}
      table.insert(moveInfos, {
        from = player,
        ids = t[player] or {},
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonDiscard,
        proposer = player,
        skillName = ddiqtszjecs.name,
      })
      table.insert(moveInfos, {
        from = to,
        ids = t[to] or {},
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonDiscard,
        proposer = to,
        skillName = ddiqtszjecs.name,
      })
    
    room:moveCards(table.unpack(moveInfos))
    if not  t[player][1] or not t[to][1] then return end
    local color1 = t[player][1] and Fk:getCardById(t[player][1]).color or nil
    local color2 = t[to][1] and Fk:getCardById(t[to][1]).color or nil
    -- if (color1 ==nil and color2~=Card.NoColor )
    -- or (color2 ==nil and color1~=Card.NoColor )
    -- or (color1==color2 and color2~=Card.NoColor) 
    if color1~=Card.NoColor and color2~=Card.NoColor and color1~=color2    then
    S.changeDamage({damageData=data,num=1,skillName=ddiqtszjecs.name})
    end
  end,
  }   
) --

ddiqtszjecs:addEffect(fk.DamageInflicted, {
  can_trigger = function(self, event, target, player, data)
    if target == player and player:hasSkill(ddiqtszjecs.name) and data.from and data.from~=player then
      return true    
    end
  end,
  on_use = function(self, event, target, player, data)
    local c1,c2
    if not player.dead then c1= player:drawCards(1,ddiqtszjecs.name) end
    if not data.from.dead then c2=data.from:drawCards(1,ddiqtszjecs.name) end
    player:showCards(c1)
    data.from:showCards(c1)
    if not c1[1] or not c2[1] or Fk:getCardById(c1[1]):compareColorWith(Fk:getCardById(c2[1])) then  --抽牌被阻也比
    S.changeDamage({damageData=data,num=-1,skillName=ddiqtszjecs.name})
    end
  end,

})



return ddiqtszjecs
