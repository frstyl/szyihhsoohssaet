local liuqsziuh = fk.CreateSkill {
  name = "liuqsziuh",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["liuqsziuh"] = "畱守",
  [":liuqsziuh"] = "➀伱受傷旹,若伱有牢,必發,防止之,傷害結算後,伱可褈鑄1裝僃｡➁伱失去裝僃區牌後,必發,伱淸除牢",

  ["#liuqsziuh-recast"] = "畱守 褈鑄裝僃",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

liuqsziuh:addEffect(fk.DamageInflicted, {
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(liuqsziuh.name) 
    -- and    data.card.trueName == "ssaet"
    and    player:getMark("@loav")>0
  end,
  on_use = function(self, event, target, player, data)
    S.preventDamage({damageData=data,skillName=liuqsziuh.name})
    data.extra_data= data.extra_data or {}
    data.extra_data.liuqsziuh=player.id
  end
})

liuqsziuh:addEffect(fk.DamageFinished, {
  can_trigger = function(self, event, target, player, data)
    return  data.extra_data and  data.extra_data.liuqsziuh
    and  data.extra_data.liuqsziuh==player.id
    and S.hasEquip(player,nil,true,false)
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:recastCard( player.room:askToCards(player,{min_num=0,max_num=1,include_equip=true,pattern=".|.|.|equip"}), player, liuqsziuh.name) 

  end
})
liuqsziuh:addEffect(fk.AfterCardsMove, {
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(liuqsziuh.name) then return end
    for _, move in ipairs(data) do
      if move.from == player then
        for _, info in ipairs(move.moveInfo) do
          if info.fromArea == Card.PlayerEquip then
            return true
          end
        end
      end
    end
  end,
  -- trigger_times = function(self, event, target, player, data)
  --   local i = 0
  --   for _, move in ipairs(data) do
  --     if move.from == player then
  --       for _, info in ipairs(move.moveInfo) do
  --         if info.fromArea == Card.PlayerEquip then
  --           i = i + 1
  --         end
  --       end
  --     end
  --   end
  --   return i
  -- end,
  on_use = function(self, event, target, player, data)
    -- S.setLoav(player,0,liuqsziuh.name)
    player.room:setPlayerMark(player,"@loav",0)  --all?
  end,
})

return liuqsziuh
