local loavqtszih = fk.CreateSkill {
  name = "loavqtszih",
}

Fk:loadTranslationTable{
["loavqtszih"] = "勞止",
[":loavqtszih"] = "輪終旹,若存活脚色當輪內受傷者不少于半(下整),伱可將1牌轉化爲｢修養生息｣起動發動",
["#loavqtszih-invoke"]="勞止 選擇1牌轉化爲｢修養生息｣起動 ",

}
loavqtszih:addEffect(fk.RoundEnd, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(loavqtszih.name) then return  end
    local t={}
    player.room.logic:getActualDamageEvents(nil,function(e)
            if e.data and e.data.to and not e.data.to.dead then table.insertIfNeed(t,e.data.to.id ) end
        end, Player.HistoryRound)
    
    return #t >= #player.room.alive_players //2
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local use = room:askToUseVirtualCard(player, {
      name = "hsiu_jiach_ssaac_sik",
      skill_name = loavqtszih.name,
      prompt = "#loavqtszih-invoke",
      cancelable = true,
      extra_data = {
        -- bypass_distances = true,
      },
      card_filter = {
        n = 1,
      },
      skip = true,
    })
    if use then
      event:setCostData(self, {use=use, tos=use.tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:useCard(event:getCostData(self).use)
  end,
})


return loavqtszih
