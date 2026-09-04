
local tszjechkun = fk.CreateSkill{
  name = "tszjechkun",
}

Fk:loadTranslationTable{
["tszjechkun"] = "整軍",
[":tszjechkun"] = "一腳色起動終旹,伱選擇1腳色發動,其抽1,弃置1",  --全部牌當閃

["#tszjechkun-invoke"] = "整軍 選擇目幖項發動",


}

local S = require "packages/szyihhsoohssaet/szyih_guos" 



tszjechkun:addEffect(fk.CardUseFinished, {
  can_refresh= function(self, event, target, player, data)
    return  player:hasSkill(tszjechkun.name,true)

  end,
  on_refresh= function(self, event, target, player, data)
      player.room:setPlayerMark(player,"@tszjechkun-turn", player:getMark("@tszjechkun-turn")==0 and 1 or 0 )
  end,
  can_trigger = function(self, event, target, player, data)
    return   layer:hasSkill(tszjechkun.name) 
    and player:getMark("@tszjechkun-turn")==1
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = room.alive_players,
      skill_name = tszjechkun.name,
      prompt = "#tszjechkun-invoke",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local to=event:getCostData(self).tos[1]
    to:drawCards(1,tszjechkun.name)
    to:askToDiscard(to,{
      min_num=1,
      max_num=1,
      include_equip=true,
      pattern=".",
      skip=false,
    })
  end,
})


return tszjechkun
