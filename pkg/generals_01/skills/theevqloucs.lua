local deevhloucs = fk.CreateSkill{
  name = "deevhloucs",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["deevhloucs"] = "誂弄",
  [":deevhloucs"] = "其它角色主段終旹,若其當段未因使用殺而致傷,伱可發動:伱爲其附加溷亂",

  ["#deevhloucs-invoke"] = "誂弄 是否對 %src發動",

  ["$deevhloucs1"] = "我欲行夏禹旧事，为天下人。",

}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

deevhloucs:addEffect(fk.EventPhaseEnd, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    if target~=player and player:hasSkill(deevhloucs.name) and not target.dead and data.phase==Player.Play then
      local es=player.room.logic:getActualDamageEvents(1, function (e)
        return e.data.from ==target and e.data.card and e.data.card.trueName=="ssaet"
      end, Player.HistoryPhase)
      return #es==0
    end
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = deevhloucs.name,
      prompt = "#deevhloucs-invoke:"..target.id,
    })
  end,
  on_use = function (self, event, target, player, data)
    S.addTsziukzzyitBuff(target,  "hsoonslvoans",player)
  end,
})



return deevhloucs
