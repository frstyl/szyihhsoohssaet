local keetddxins = fk.CreateSkill {
  name = "keetddxins",
}

Fk:loadTranslationTable{
  ["keetddxins"] = "結敶",
  [":keetddxins"] = "游戲始旹,伱轉始旹，伱可選1項發動➀選擇1不同隊角色,邀其入敶,其使用1防具牌(額外牌)➁令1同隊角色獲得1護甲",

  ["#keetddxins-choose"] = "結敶：選擇角色 入敶或+1護甲",


  -- ["$keetddxins1"] = "帥其卽軍心",--大旗在此軍心不亂
  -- ["$keetddxins2"] = "大其飄揚軍威雄壯",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec ={
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local tos = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room.alive_players,
      skill_name = keetddxins.name,
      prompt = "#keetddxins-choose",
      cancelable = true,
    })
    if #tos>0 then 
      event:setCostData(self,{tos=tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local tos =event:getCostData(self).tos
    -- local tos =S.inviteToJoinSquad(room,player,tos,keetddxins.name)
    if not S.isSameSquad(player,tos[1]) then
      S.joinSquad(room,player,tos)
      local names={"svoah_tsih_kaap","nioh_shield","eight_diagram","boos_nzjin_kaap"}
      local card= room:printCard(table.random(names))
      local use={
        from = tos[1],
        tos = tos,
        card = card,
      }
      room:useCard(use)
    else
      room:changeShield(tos[1], 1)
    end
  end,
}
keetddxins:addEffect(fk.GameStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if player:hasSkill(keetddxins.name) then
      return true
    end
  end,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})

keetddxins:addEffect(fk.TurnStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if target == player and player:hasSkill(keetddxins.name) then
      return true
    end
  end,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})


return keetddxins
