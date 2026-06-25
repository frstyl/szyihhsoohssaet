local kiapliak = fk.CreateSkill{
  name = "kiapliak",
}

Fk:loadTranslationTable{
  ["kiapliak"] = "劫掠",
  [":kiapliak"] = "其它角色判定牌生效後,若其有手牌,伱可發動.伱獲得其1手牌",
--加彊?

  ["kiapliak-invoke"] = "劫掠 昰否弃1牌行刺%src",

  ["$kiapliak1"] = "板刀麪還是餛飩麪",
  ["$kiapliak2"] = "上已昰船可由不得伱矣",
}

kiapliak:addEffect(fk.FinishJudge, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target ~= player 
    and not target:isKongcheng()
  end,
  on_use = function(self, event, target, player, data)
    local cid = player.room:askToChooseCard(player, { target = target, flag = "h", skill_name = kiapliak.name })
    player.room:obtainCard(player, cid, false, fk.ReasonPrey, player, kiapliak.name)
  end,
})


return kiapliak
