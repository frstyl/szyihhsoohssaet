Fk:loadTranslationTable{
  ["ssiuqkfat"] = "搜𠜜",
  [":ssiuqkfat"] = "補段始旹,伱可選1~4其它有手牌角色發動.伱獲取其各1手牌,牢+1",

  -- ["ssiuqkfat-invoke"] = "搜𠜜 昰否",

  ["$ssiuqkfat1"] = "岳丈大人生辰將至待吾籌昰生辰綱",
  ["$ssiuqkfat2"] = "管它輩是死是𣴠昰是要獻給太師之賀禮",
  ["$ssiuqkfat3"] = "一章兩章還是不彀",
}

local ssiuqkfat = fk.CreateSkill{
  name = "ssiuqkfat",
}

ssiuqkfat:addEffect(fk.EventPhaseStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(ssiuqkfat.name) and target.phase == Player.Draw
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local tos = room:askToChoosePlayers(player,{
      min_num = 1,
      max_num = 4,
      targets = table.filter(room:getOtherPlayers(player),function(p)
      return not p:isKongcheng()
      end),
      skill_name = ssiuqkfat.name,
      prompt = "#ssiuqkfat-choose",
      cancelable = true,
    })
    if #tos ~= 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    for _, p in ipairs(event:getCostData(self).tos) do
      if not p.dead and not p:isAllNude() then
        local id = room:askToChooseCard(player, {
          target = p,
          flag = "h",
          skill_name = ssiuqkfat.name,
        })
        room:obtainCard(player, id, false, fk.ReasonPrey, player, ssiuqkfat.name)
        if player.dead then return end
      end
    end
    -- player:turnOver()
    room:addPlayerMark(player,"@loav",1)
  end,
})

return ssiuqkfat
