local skill = fk.CreateSkill {
  name = "hsvoah_kouc_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- Fk:loadTranslationTable{
--   ["#hsvoah_kouc-show"] = "火攻 ",
--   ["#hsvoah_kouc-discard"] = "火攻",
-- }

skill:addEffect("cardskill", {
  prompt = "#hsvoah_kouc_skill",
  target_num = 1,
  mod_target_filter = function(self, _, to_select, _, _, _)
    return not to_select:isKongcheng()
  end,
  target_filter = Util.CardTargetFilter,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local from = effect.from
    local to = effect.to
    if to:isKongcheng() then return end

    local params = { ---@type AskToCardsParams
      min_num = 1,
      max_num = 1,
      include_equip = false,
      skill_name = skill.name,
      cancelable = false,
      pattern = ".|.|.|hand",
      prompt = "#hsvoah_kouc-show:" .. from.id
    }
    local showCard = room:askToCards(to, params)[1]
    to:showCards(showCard)

    showCard = Fk:getCardById(showCard)
    params = {
      min_num = 1,
      max_num = 1,
      -- include_equip = true,
      skill_name = skill.name,
      cancelable = true,
      pattern = ".|.|" .. showCard:getSuitString(),
      prompt = "#hsvoah_kouc-discard:" .. to.id .. "::" .. showCard:getSuitString(),
      skip=false,
    }
    -- local cards = room:askToDiscard(from, params)
    local  cards = S.askToPlayCard(from, params)
    if #cards > 0 and not to.dead then
      room:damage({
        from = from,
        to = to,
        card = effect.card,
        damage = 1,
        damageType = fk.FireDamage,
        skillName = skill.name,
        event_data= effect,
      })
    end
  end,
})

skill:addAI({
  on_effect = function(self, logic, effect)
    logic:damage({
      from = effect.from,
      to = effect.to,
      card = effect.card,
      damage = 1,
      damageType = fk.FireDamage,
      skillName = skill.name,
    })
  end,
}, "__card_skill")

return skill
