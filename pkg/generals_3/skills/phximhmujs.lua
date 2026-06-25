local phximhmujs = fk.CreateSkill {
  name = "phximhmujs",
}

Fk:loadTranslationTable{
  ["phximhmujs"] = "品味",
  [":phximhmujs"] = "置酒設筵亮出牌後,伱可發動,伱回x,抽x(x=1+所亮出酒肉牌數)",

  ["#phximhmujs-choose"] = "品味 選擇所用殺与所弃牌",

  ["$phximhmujs1"] = "好酒",
  ["$phximhmujs2"] = "美酒佳餚豈不玅哉",
}

-- local U = require "packages/utility/utility"

phximhmujs:addEffect(fk.AfterCardsMove, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if not  player:hasSkill(phximhmujs.name)  then return end

      local ids = {}
      for _, move in ipairs(data) do  --data MoveCards
        if move.skillName=="ttis_tsiuh_szjet_jjen_skill" and  move.toArea == Card.Processing then  
          return true
        end
      end

    end,

  on_use = function(self, event, target, player, data)
    -- local room = player.room
    if player.dead then return end
      local n=1
      for _, move in ipairs(data) do  --data MoveCards
        if move.skillName=="ttis_tsiuh_szjet_jjen_skill"        then  
          for _, info in ipairs(move.moveInfo) do
            if  table.contains({"nziuk","tsiuh"}, Fk:getCardById(info.cardId).trueName) then
               n=n+1
            end
          end
        end
      end
    if  player:isWounded() then
    player.room:recover{
      who = player,
      num = n,
      recoverBy = player,
      skillName = phximhmujs.name
    }
    end
    if player.dead then return end
    player:drawCards(n,phximhmujs.name)
end,
})

return phximhmujs
