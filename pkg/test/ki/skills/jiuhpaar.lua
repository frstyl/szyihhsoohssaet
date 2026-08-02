local jiuhpaar = fk.CreateSkill {
  name = "jiuhpaar",
  -- tags={Skill.Compulsory}
}

Fk:loadTranslationTable{
  ["jiuhpaar"] = "牖敗",
  [":jiuhpaar"] = "一腳色額外抽牌後,伱可發動,伱自牌堆底取得1",


  ["$jiuhpaar"] = "好一匹棗紅馬",
}
--
jiuhpaar:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(jiuhpaar.name)
  end,
  trigger_times = function(self, event, target, player, data)
    local room = player.room
    local ps={}
    for _, move in ipairs(data) do
      if move.to
        -- and move.to ~= player
        -- and move.to.phase ~= Player.Draw 
        and move.moveReason==fk.ReasonDraw 
        -- and move.skillName~=jiuhpaar.name
        and move.skillName~="phase_draw"
      then
          table.insert(ps, move.to.id)
      end
    end
    return #ps
  end,
  on_use = function(self, event, target, player, data)
    player.room:obtainCard(player, player.room:getNCards(1,"bottom"), false, fk.ReasonPrey, player, jiuhpaar.name) 
    -- player:drawCards(1,jiuhpaar.name)
  end,
})
return jiuhpaar
