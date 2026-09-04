local hzeeplik = fk.CreateSkill {
  name = "hzeeplik",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["hzeeplik"] = "協力",
  [":hzeeplik"] = "其它腳色選擇牌旹,伱可演練1牌,+1",

  ["#hzeeplik-ask"] = "協力 %src 起動 %arg 伱可助力",

  ["$hzeeplik1"] = "在昰里本官說已算",
  ["$hzeeplik2"] = "昰个卻正是反詩汝若里得來",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzeeplik:addEffect(fk.CardUsing, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return   data.from ~= player
   and player:hasSkill(hzeeplik.name) 
   and table.contains({"ssaet","nziuk","tsiuh",}, data.card.trueName) 
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local respond = room:askToResponse(to, {--?? SkillEffectDataSpec
      skill_name = hzeeplik.name,
      pattern = data.card.trueName,
      prompt = "#hzeeplik-ask:" .. data.to.id .. ":::"  .. data.card.trueName,
      cancelable = true,
      extra_data={}
      -- event_data = {
      --   to=to,
      --   from=player,
      -- },--skill card
    })
    if respond then
      respond.extra_data=respond.extra_data or {}
      respond.extra_data.skill_effect_event={who=player,skill_name=hzeeplik.name}
      room:responseCard(respond)
      
      if data.card.is_damage_card then
        data.additionalDamage = (data.additionalDamage or 0) + 1
      elseif data.card.name == "nziuk" then
        data.additionalRecover = (data.additionalRecover or 0) + 1
      elseif data.card.name == "tsiuh" then
        if data.extra_data and data.extra_data.tsiuhRecover then
          data.additionalRecover = (data.additionalRecover or 0) + 1
        else
          data.extra_data = data.extra_data or {}
          data.extra_data.additionalDrank = (data.extra_data.additionalDrank or 0) + 1
        end
      end

    end
  end,
})

return hzeeplik
