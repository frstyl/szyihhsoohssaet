local gianqkouc = fk.CreateSkill {
  name = "gianqkouc",
}

Fk:loadTranslationTable{
  ["gianqkouc"] = "赶工",
  [":gianqkouc"] = "任意角色越過段或轉後,額外段或轉始旹,伱可選1項發動.➀其抽1➁伱弃其1(需其有牌)➂其使用1牌(可虛擬可轉化有距離次數限制計次數),若不使用則展示全部牌",

  ["#gianqkouc-choose"] = "赶工 選擇目幖",
  -- ["#gianqkouc-use"] = "赶工 使用一牌",

}


local S = require "packages/szyihhsoohssaet/szyih_guos" 

gianqkouc:addEffect(fk.BeforeTurnStart,{--TurnStart
  can_trigger= function(self, event, target, player, data)
    return  target==player and player:hasSkill(gianqkouc.name)
    -- and not data.turn_end
  end,
  on_cost = function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
        targets = player.room:getAlivePlayers(false),
        min_num = 1,
        max_num = math.max(1,player:getLostHp()),
        prompt = "#gianqkouc-choose",
        skill_name = gianqkouc.name,
        cancelable = true,
      })
    if #tos>0 then
      event:setCostData(self, {tos=tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    -- data.turn_end=true
    local room=player.room

    local tos =event:getCostData(self).tos
    for _, p in ipairs(tos) do
      if not p.dead then p:drawCards(1,gianqkouc.name) end
    end

      local params={
        cancelable=false,
        skip=false,
        skill_name=gianqkouc.name,
        extra_data={
          bypass_distances=false,
          bypass_times=false,
          extraUse=false,
      }
    }
    for _, p in ipairs(tos) do
      if not p.dead then room:askToPlayCard(target, params) end
    end

    S.skipTurn(player,gianqkouc.name,data)  --手動
  end,
})

return gianqkouc
