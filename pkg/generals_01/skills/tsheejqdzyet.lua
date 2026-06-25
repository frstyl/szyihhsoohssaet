Fk:loadTranslationTable{
  ["tsheejqdzyet"] = "悽絕",
  [":tsheejqdzyet"] = "伱死亾旹,伱可選1已死角色發動.令其2體力3牌復活",

  ["$tsheejqdzyet1"] = "哈哈哈哈哈哈哈哈！",
  ["$tsheejqdzyet2"] = "伯符，且看我这一手！",
}

local tsheejqdzyet = fk.CreateSkill{
  name = "tsheejqdzyet",
  -- tags = {Skill.Permanent },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tsheejqdzyet:addEffect(fk.Death, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(tsheejqdzyet.name,true,true)
  end,
  on_cost= function(self, event, target, player, data)
    local tos = table.map(table.filter(player.room.players, function(p) return p.dead and p~=player end), function(p) return tostring(p.seat) end)
    if #tos ==  0 then return end
    table.insert(tos,"Cancel")
    local id = player.room:askToChoice(player, {choices = tos, skill_name = tsheejqdzyet.name, prompt = "#revive-ask",cancelable=true})
    if id and id~="" and id~="Cancel" then
      -- id = tonumber(string.sub(id, 6))
      id =tonumber(id)
      player:drawCards(math.abs(id),tsheejqdzyet.name)
      event:setCostData(self, {id =id })
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room= player.room
    local id =event:getCostData(self).id
          -- for _, p in ipairs(room.players) do
          --   if p.seat == id then
          --     room:revivePlayer(p, true)
          --     break
          --   end
          -- end
    local to = room:getPlayerBySeat(id)
    S.revive({
      who=to,
      skill=tsheejqdzyet.name,
      from=player,
      drawN=3,
      recoverHp=2,
      -- fixMaxHp=2,
    })
    -- to:drawCards(3,tsheejqdzyet.name)
    -- room:revivePlayer(to, true, tsheejqdzyet.name)
    -- room:setPlayerProperty(to, "hp", 2)
  end,
})


return tsheejqdzyet
