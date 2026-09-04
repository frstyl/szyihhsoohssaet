local keekjyer = fk.CreateSkill {
  name = "keekjyer",
}

Fk:loadTranslationTable{
  ["keekjyer"] = "擊銳",
  [":keekjyer"] = "伱對A致傷旹,若A之x>0,伱可發動,傷害值+x(x爲A符合項數:體力值/手牌區牌數/裝僃區牌數/全場冣大)",

  ["#keekjyer-invoke"] = "擊銳 是否對 %src 發動 0牌确定則其弃牌",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

keekjyer:addEffect(fk.DamageInflicted, {  --
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if  data.from==player and player:hasSkill(keekjyer.name) then
      local n=0
      local room=player.room
      local tos=room:getOtherPlayers(data.to)

      local num=data.to.hp
      if  table.every(tos, function(p)
        return p.hp< num
      end)
      then n=1 
      end

      local num=#data.to:getCardIds("h")
      if       table.every(tos, function(p)
        return p:getHandcardNum()< num
      end)
      then n=n+1 
      end

      local num=#data.to:getCardIds("e")
      if table.every(tos, function(p)
        return #p:getCardIds("e")< num
      end)
      then n=n+1 
      end

      if n>0 then
        event:setCostData(self,{n=n})
        return true
      end
    end
  end,

  on_use = function(self, event, target, player, data)
    S.changeDamage({damageData=data,num=event:getCostData(self).n,skillName=keekjyer.name})
  end,
})


return keekjyer
