local kiapliak = fk.CreateSkill{
  name = "kiapliak",
}

Fk:loadTranslationTable{
  ["kiapliak"] = "劫掠",
  [":kiapliak"] = "其它脚色{占卜牌生效後/牌被展示牌後},若其有手牌,伱可發動.伱取得其1手牌",

  ["kiapliak-invoke"] = "劫掠 昰否弃1牌埋伏%src",

  ["$kiapliak1"] = "板刀麪還是餛飩麪",
  ["$kiapliak2"] = "上已昰船可由不得伱矣",
}

local spec={  
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(kiapliak.name) then return end
    local to =(data.who or data.from) 
    return to~= player 
    and not to:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    local to =(data.who or data.from) 
    if     player.room:askToSkillInvoke(player, { skill_name = kiapliak.name ,prompt="#kiapliak-invoke"..to.id}) then
        event:setCostData(self,{tos={to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local cid = player.room:askToChooseCard(player, { target = target, flag = "h", skill_name = kiapliak.name })
    player.room:obtainCard(player, cid, false, fk.ReasonPrey, player, kiapliak.name)
  end,
}

kiapliak:addEffect(fk.CardShown, spec)

kiapliak:addEffect(fk.FinishJudge, spec)



return kiapliak
