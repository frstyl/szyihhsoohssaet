local tvoanspjes = fk.CreateSkill({
  name = "tvoanspjes",
  tags={Skill.Limited},
})

Fk:loadTranslationTable{
  ["tvoanspjes"] = "斷臂",
  [":tvoanspjes"] = "局限1.其它角色失去冣後手牌後,伱可發動.伱體力上限-2,予其2傷,選擇其1技能其失去",

  ["#tvoanspjes-invoke"] = "斷臂： %dest ",
  ["#tvoanspjes-choice"] = "斷臂： %dest ",

  ["$tvoanspjes1"] = "善因得善果，恶因得恶报！",
  ["$tvoanspjes2"] = "私我者赠之琼瑶，厌我者报之斧钺！",
}

tvoanspjes:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not (player:hasSkill(tvoanspjes.name) and player:usedSkillTimes(tvoanspjes.name, Player.HistoryGame) == 0) then return end
    for _, move in ipairs(data) do
      if move.from and move.from~=player and move.from:isKongcheng() then
        for _, info in ipairs(move.moveInfo) do
          if info.fromArea == Card.PlayerHand then
            return true
          end
        end
      end
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local targets = {}
    for _, move in ipairs(data) do
      if move.from and move.from~=player and move.from:isKongcheng() then
        for _, info in ipairs(move.moveInfo) do
          if info.fromArea == Card.PlayerHand then
            table.insertIfNeed(targets, move.from)
          end
        end
      end
    end

        player.room:sortByAction(targets)
    for _, p in ipairs(targets) do
      if not (player:hasSkill(tvoanspjes.name) and player:usedSkillTimes(tvoanspjes.name, Player.HistoryGame) == 0)  then break end
      if not p.dead then
        event:setCostData(self, {tos = {p}})
        self:doCost(event, target, player, data)
      end
    end
  end,
  on_cost = function(self, event, target, player, data)
    local to = event:getCostData(self).tos[1]
    return player.room:askToSkillInvoke(player, {
      skill_name = tvoanspjes.name,
      prompt = "#tvoanspjes-invoke::"..to.id,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    room:changeMaxHp(player,-2) --,tvoanspjes.name
    local to = event:getCostData(self).tos[1]
    room:damage{
      to =  to,
      damage = 2,
      -- damageType = fk.ThunderDamage,
      skillName = tvoanspjes.name,
    }
    if player.dead then return end
    local choice = room:askToChoice(player, {
      choices = to:getSkillNameList(),
      skill_name = tvoanspjes.name,
      prompt = "#tvoanspjes-choice::"..to.id,
      detailed = true,
    })
    room:handleAddLoseSkills(to, "-"..choice)
  end,
})

return tvoanspjes
