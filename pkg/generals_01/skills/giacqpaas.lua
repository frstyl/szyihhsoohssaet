local giacqpaas = fk.CreateSkill {
  name = "giacqpaas",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["giacqpaas"] = "彊霸",
  [":giacqpaas"] = "伱末段終旹,伱可預弃1牌選擇1其它男角色發動.伱予其1傷,伱伱未損,改爲2傷",

  ["#giacqpaas-choose"] = "彊霸 選擇牌与目幖 予其%arg傷",

  ["$giacqpaas1"] = "曲有误，不可不顾。",
  ["$giacqpaas2"] = "兀音曳绕梁，愿君去芜存菁。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

giacqpaas:addEffect(fk.EventPhaseStart, {
  anim_type = "support",
  can_trigger = function (self, event, target, player, data)
    return target==player and  player:hasSkill(giacqpaas.name) and data.phase==Player.Finish
  end,
  on_cost= function(self, event, target, player, data)
    local n =(player:isWounded() and 1 or 2)
    local tos, cards = player.room:askToChooseCardsAndPlayers(player, {
      min_card_num = 1,
      max_card_num = 1,
      include_equip=true,
      -- will_throw=true,
      min_num = 1,
      max_num = 1,
      targets = table.filter(player.room.alive_players, function(p)
      return p~=player and p.gender == General.Male
      end),  --
      -- targets=player.room.alive_players,
      pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)
      return not player:prohibitResponse(Fk:getCardById(id))
    end)}),
      skill_name = giacqpaas.name,
      prompt = "#giacqpaas-choose:::"..n,
      cancelable = true,
    })
    if #tos > 0 and #cards > 0 then
      event:setCostData(self, {tos = tos, cards = cards,n=n})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    -- local to =event:getCostData(self).tos[1]
    -- player.room:throwCard(event:getCostData(self).cards, giacqpaas.name, player,player)
      player.room:responseCard({
				card=Fk:getCardById(event:getCostData(self).cards[1]),
				from=player,
				attachedSkillAndUser={muteCard=true},
			})
    player.room:damage{
        from = player,
        to = event:getCostData(self).tos[1],
        damage =  event:getCostData(self).n,
        skillName = giacqpaas.name,
      }
  end,
})


return giacqpaas
