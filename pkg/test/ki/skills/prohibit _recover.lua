local prohibit_recover = fk.CreateSkill {
  name = "prohibit_recover",
}

Fk:loadTranslationTable{

  ["@@prohibit_recover"] = "禁療",
  ["#PreventRecover"] = "%from 所受回復被防止",

}



prohibit_recover:addEffect(fk.PreHpRecover, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasMark("@@prohibit_recover")
  end,
  on_trigger = function(self, event, target, player, data)
    data.prevented=true
    player.room:sendLog{ type = "#PreventRecover", from = player.id}
    -- player.room:sendLog{ type = "#PreventRecoverBySkill", from = player.id, arg = "dook" }
  end,
})
return prohibit_recover
