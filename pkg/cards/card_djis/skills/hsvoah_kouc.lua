local cardSkill = fk.CreateSkill {
  name = "hsvoah_kouc_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- Fk:loadTranslationTable{
--   ["#hsvoah_kouc-show"] = "火攻 ",
--   ["#hsvoah_kouc-discard"] = "火攻",
-- }

cardSkill:addEffect("cardskill", {
  prompt = "#hsvoah_kouc_skill",
  target_num = 1,
  mod_target_filter = function(self, _, to_select, _, _, _)
    return not to_select:isKongcheng()
  end,
  target_filter = Util.CardTargetFilter,
  offset_func= Util.FalseFunc,
  on_action = function(self, room, use, finished)
    if not finished or not use.extra_data or not  use.extra_data.lje_kaens then return end
    local tos = table.filter(use.extra_data.lje_kaens,function(p)
      return not p.dead and not p:isKongcheng()
    end)
    if #tos<1 then return end
    local from=use.from

    local params = { ---@type askToJointCardsParams
      players = tos,
      min_num = 1,
      max_num = 1,
      include_equip = false,
      skill_name = cardSkill.name,
      cancelable = false,
      pattern = ".|.|.|hand",
      prompt = "#hsvoah_kouc-show:" .. from.id
    }
    local results=room:askToJointCards(from, params)

    params = {
      min_num = 1,
      max_num = 1,
      -- include_equip = true,
      skill_name = cardSkill.name,
      cancelable = true,
      pattern = ".|.|^nosuit",
      prompt = "#hsvoah_kouc-playcard",
      skip=false,
    }

    local  cards = S.askToPlayCard(from, params)
    if #cards > 0 then
      local suit = Fk:getCardById(cards[1]).suit
      S.playCard(cards,cardSkill.name,from)
      for _, to in ipairs(tos) do
        if results[to][1] and Fk:getCardById(results[to][1]).suit==suit then
          room:damage({
            from = from,
            to = to,
            card = use.card,
            damage = 1,
            damageType = fk.FireDamage,
            skillName = cardSkill.name,
            use_event_data= data,
          })
        end
      end
    end


  end, 
  on_effect = function(self, room, effect)
    local use = effect.use
    if  use then
      use.extra_data=use.extra_data or {}
      use.extra_data.lje_kaens=    use.extra_data.lje_kaens or {}
      table.insertIfNeed(use.extra_data.lje_kaens, effect.to)
      return
    end


    local from = effect.from
    local to = effect.to
    if to:isKongcheng() then return end

    local params = { ---@type AskToCardsParams
      min_num = 1,
      max_num = 1,
      include_equip = false,
      skill_name = cardSkill.name,
      cancelable = false,
      pattern = ".|.|.|hand",
      prompt = "#hsvoah_kouc-show:" .. from.id
    }
    local showCard = room:askToCards(to, params)[1]
    to:showCards(showCard)

    if not from then return end
    showCard = Fk:getCardById(showCard)
    params = {
      min_num = 1,
      max_num = 1,
      -- include_equip = true,
      skill_name = cardSkill.name,
      cancelable = true,
      pattern = ".|.|" .. showCard:getSuitString(),
      prompt = "#hsvoah_kouc-discard:" .. to.id .. "::" .. showCard:getSuitString(),
      skip=false,
    }
    -- local cards = room:askToDiscard(from, params)
    local  cards = S.askToPlayCard(from, params)
    if #cards > 0 and not to.dead then
      S.playCard(cards,cardSkill.name,from)
      room:damage({
        from = from,
        to = to,
        card = effect.card,
        damage = 1,
        damageType = fk.FireDamage,
        skillName = cardSkill.name,
        event_data= effect,
      })
    end
  end,
})

return cardSkill
