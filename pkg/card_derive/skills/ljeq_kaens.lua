local cardSkill = fk.CreateSkill {
  name = "lje_kaens_skill",
}

Fk:loadTranslationTable{
  ["lje_kaens_skill"] = "離閒",
  ["#lje_kaens_skill"] = "選擇1其它角色A与A与A拼點目幖B,對A使用. AB拼點 未贏者受對方1傷",

}

local U = require "packages.utility.utility"

cardSkill:addEffect("cardskill", {
  prompt = "#lje_kaens_skill",
  offset_func= Util.FalseFunc,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return true  --離閒自己
  end,
  target_filter = Util.CardTargetFilter,
  target_num = 2, 
  on_action = function(self, room, use, finished)
    if not finished or not use.extra_data or not  use.extra_data.lje_kaens or   #use.extra_data.lje_kaens<2  then return end
    local tos = table.filter(use.extra_data.lje_kaens,function(p)
      return not p.dead
    end)
    if #tos<2 then return end
    local all=table.simpleClone(tos)
    local from=tos[1]--不應有
    table.remove(tos,1)
    local pindian=U.jointPindian(from, tos, cardSkill.name)

    -- for p, t in ipairs(results) do
    --   t.toCard
    -- end
    for _, p in ipairs(all) do
      if p~=pindian.winner then
      room:damage({
        from = nil,
        to = p,
        damage = 1,
        skillName = cardSkill.name,
        card = use.card,  --算直接傷害?
      })
      end
    end
  end, 
  on_effect = function(self, room, effect) --必需useEvent
    local use = effect.use
    if not use then return end
    use.extra_data=use.extra_data or {}
    use.extra_data.lje_kaens=    use.extra_data.lje_kaens or {}
    table.insertIfNeed(use.extra_data.lje_kaens, effect.to)
  end,
})

return cardSkill
