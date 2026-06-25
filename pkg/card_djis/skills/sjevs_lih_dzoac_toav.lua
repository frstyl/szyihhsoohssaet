local cardSkill = fk.CreateSkill {
  name = "sjevs_lih_dzoac_toav_skill",
}

Fk:loadTranslationTable{
-- ["sjevs_lih_dzoac_toav_skill"] = "笑裏藏刀",  --下藥
-- [":sjevs_lih_dzoac_toav_skill"] = "笑裏藏刀 選擇攻程內1角色 其不可使用打出殺閃",
["#sjevs_lih_dzoac_toav_skill"] = "笑裏藏刀 選擇攻程內1角色 其不能使用打出殺閃",
}

cardSkill:addEffect("cardskill", {
  prompt = "#sjevs_lih_dzoac_toav_skill",

  -- max_phase_use_time = 1,
  target_num = 1,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select:getMark("meej")==0
      and (
         (extra_data and extra_data.bypass_distances) 
      or self:withinDistanceLimit(player, true, card, to_select)  --zzinkeec
      or to_select==player
    )
  end,
  target_filter = Util.CardTargetFilter,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local to = effect.to
    -- effect.from:drawCards(1,cardSkill.naem)
    -- to:drawCards(1,cardSkill.naem)
    -- room:useVirtualCard("meej",nil,to,{to},cardSkill.name,true)

    
    local card = Fk:cloneCard("tsiuh")
    card.skill = Fk.skills["meej_skill"]
    local use = { ---@type UseCardDataSpec
    from = to,
    tos = {to},
    card = card,
    }
    room:useCard(use)
  end,
})




return cardSkill
