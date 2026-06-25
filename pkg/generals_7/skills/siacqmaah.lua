local siacqmaah = fk.CreateSkill {
  name = "siacqmaah",
}

Fk:loadTranslationTable{
  ["siacqmaah"] = "相馬",
  [":siacqmaah"] = "主旹,伱聲名1花色發動,伱自弃牌堆牌堆隨機獲得1所聲明花色之坐騎牌,肰後伱可發動1次荐馬.",

  ["#siacqmaah"] = "相馬 隨機獲得1此花色坐騎牌",
  ["#siacqmaah-choose"] = "相馬 選擇1角色 發動荐馬",

  ["$siacqmaah1"] = "好一匹棗紅馬",
}

siacqmaah:addEffect("active", {
  anim_type = "control",
  prompt = "#siacqmaah",
  can_use = function(self, player)
    return player:usedSkillTimes(siacqmaah.name, Player.HistoryPhase) == 0
  end,
  interaction = function(self)
    return UI.ComboBox {
      choices = {"log_spade", "log_club", "log_heart", "log_diamond"},
    }
  end,
  on_use = function(self, room, effect)
    local suits={"spade", "club", "heart", "diamond"}
    local suit=suits[table.indexOf({"log_spade", "log_club", "log_heart", "log_diamond"}, self.interaction.data)]

    local pattern =".|.|"..suit.."|.|.|defensive_ride,offensive_ride"
      local cards=room:getCardsFromPileByRule(pattern,1,"allPiles")  --待改 過濾非馬
      if #cards==0 or effect.from.dead  then return end
      room:moveCards({
        ids = cards,
        to = effect.from,
        toArea = Card.PlayerHand,
        moveReason = fk.ReasonJustMove,
        proposer = effect.from,
        skillName = siacqmaah.name,
      })
      if not effect.from.dead then
        local to = room:askToChoosePlayers(effect.from, {
          targets = room.alive_players,
          min_num = 1,
          max_num = 1,
          prompt = "#siacqmaah-choose",
          skill_name = siacqmaah.name,
          cancelable = true,
        })
        if #to>0 then 

          local e=GameEvent.EnterDying
          local dyingDataSpec = {
          who = to,
          damage = nil,
          killer = nil,
        }

            local e = fk.EnterDying:new(room, to[1], dyingDataSpec)
          -- e:initialize(room,to,nil)
          e:setCostData(Fk.skills["dzeensmaah"], { cards=cards })
          -- Fk.skills["dzeensmaah"]:use(e, to[1], effect.from, nil)
          Fk.skills["dzeensmaah"]:doCost(e,to[1],effect.from,dyingDataSpec)
        --   room:useSkill(player, Fk.skills["dzeensmaah"],function()
        -- skill:use(self, SkillUseData:new {
        --   from = player,
        --   cards = selected_cards,
        --   tos = table.map(targets, Util.Id2PlayerMapper),
        -- }))
        end
      end
  end,
})



return siacqmaah
