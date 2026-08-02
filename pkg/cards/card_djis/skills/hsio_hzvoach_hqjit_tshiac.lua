local hsio_hzvoach_hqjit_tshiac = fk.CreateSkill {
  name = "hsio_hzvoach_hqjit_tshiac_skill",
}

Fk:loadTranslationTable{
  ["#hsio_hzvoach_hqjit_tshiac_skill"] = "虛晃一槍 展示殺執行",
  ["#hsio_hzvoach_hqjit_tshiac-show"] = "虛晃一槍 展示殺",
  ["#hsio_hzvoach_hqjit_tshiac-ask"] = "虛晃一槍 是否令 %src 回1",
}
hsio_hzvoach_hqjit_tshiac:addEffect("cardskill", {
  prompt = "#hsio_hzvoach_hqjit_tshiac_skill",
  target_num = 1,
  mod_target_filter = function(self, player, to_select, selected, card)
    return
    player:canUseTo(Fk:cloneCard("ssaet"), to_select, {bypass_distances = false, bypass_times = true})
  end,
  target_filter = Util.CardTargetFilter,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local from = effect.from
    local to = effect.to
    -- if from.dead or to.dead or from:isKongcheng() then return end
    local params = { ---@type AskToCardsParams
      min_num = 1,
      max_num = 1,
      include_equip = false,
      skill_name = hsio_hzvoach_hqjit_tshiac.name,
      cancelable = true,
      pattern = "ssaet",
      prompt = "#hsio_hzvoach_hqjit_tshiac-show" 
    }
    local showCard = room:askToCards(from, params)[1]
    if not showCard then return  end
    room:showCards(showCard)
      -- room.logic:trigger(fk.CardShown, from, { cardIds = {showCard} })
    
    local choice=false
    if  from:isWounded() then 
      choice = room:askToSkillInvoke(to, { 
        prompt="#hsio_hzvoach_hqjit_tshiac-ask:"..from.id,
        skill_name = hsio_hzvoach_hqjit_tshiac.name,
      })
    end
    if choice == false then
    showCard=Fk:getCardById(showCard)
    local card = Fk:cloneCard(showCard.name, showCard.suit, showCard.number)  --虛牌鎖无色?
    -- card.color=showCard.color
    card.skillName = hsio_hzvoach_hqjit_tshiac.name
    room:useCard{
      from = from,
      tos = {to},
      card = card,
      extraUse =true,
    }
    else
      room:recover({
        who = from,
        num = 1,
        recoverBy = to,
        skillName = hsio_hzvoach_hqjit_tshiac.name,
        event_data= effect,
      })
    end
  end,
})


return hsio_hzvoach_hqjit_tshiac
