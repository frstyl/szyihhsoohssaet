local cardSkill = fk.CreateSkill {
  name = "quac_boa_szyet_mooj",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#tvoans_liac_dzyet_quan_skill",
  target_num = 1,
  mod_target_filter = Util.TrueFunc,
  target_filter = Util.CardTargetFilter,
  offset_func= Util.FalseFunc,
  -- can_use =Util.FalseFunc,
  can_use =Util.FalseFunc,
  about_to_effect = function(self, room, effect)  
    if not effect.from or not effect.to then return end
    local targets= table.filter(room.alive_players,function(p)
    return p~=effect.from and p~=effect.to end)
    if #targets==0 then return end  ---true or false
    effect.subTargets = room:askToChoosePlayers(effect.from, {
      targets = targets,
      min_num = 1,
      max_num = 1,
      prompt = "#quac_boa_szyet_mooj-subTarget:"..effect.to.id,
      skill_name = cardSkill.name,
      cancelable=false,
    })
    room:sendLog{
        type = "#CardUseCollaborator",
        from = effect.to.id,
        to = table.map(effect.subTargets, Util.IdMapper),
        arg = effect.card,
      }
  end,
  on_effect = function(self, room, effect)
    if not (effect.subTargets and effect.subTargets[1]) then return end
    room:swapAllCards(effect.from, {effect.to,effect.subTargets[1]}, "quac_boa_szyet_mooj","he")
    if not effect.to:isNude() and not effect.from.dead then
      local cid = room:askToChooseCard(effect.from, { target = effect.to, flag = "he", skill_name = cardSkill.name })
      room:obtainCard(effect.from, cid, false, fk.ReasonPrey, effect.from, cardSkill.name)
    end
  end,
})


cardSkill:addEffect(fk.Death, {
  -- global = true,
  mute = true,
  priority = 0,  --同旹自選 用牌?
  can_trigger = function(self, event, target, player, data)
    if  player.seat==1
      and data.damage
      and data.damage.from
      and data.damage.from~=data.who
      and not data.damage.from.dead
    then
              return  true

    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room

      local params={
      skill_name = "quac_boa_szyet_mooj",
      pattern="quac_boa_thoeom_hsoojh_szyet_piuc_dzjec",
      cancelable=true,
      prompt="#quac_boa_szyet_mooj:"..data.who.id,
      skip=true,
      extra_data = {
        must_targets={data.damage.from.id},
        exclusive_targets=={data.damage.from.id},
        quac_boa_szyet_mooj = true,
      }
    }
      local use = S.askToUseKoarbiukCard(S.getHolders("quac_boa_thoeom_hsoojh_szyet_piuc_dzjec"), params) 
      if use then
        room:useCard(use)
      end

  end,
})

cardSkill:addEffect(fk.AfterCardsMove, {
  priority = 0,  --同旹自選 用牌?
  can_trigger = function(self, event, target, player, data)
    local tos={}
    for _, move in ipairs(data) do
      if move.from and (move.to==Card.DiscardPile) then
        for _, info in ipairs(move.moveInfo) do
          local card = info.beforeCard
          if info.fromArea == Card.PlayerEquip and card.sub_type ==  Card.SubtypeArmor then
            table.insertIfNeed(tos,move.from)
          end
        end
      end
    end

    if #tos>0 then
      event:setCostData(self,{targets=tos})
      return true
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room

    local params={
      players=event:getCostData(self).players,
      skill_name = "cio_szyih_tszi_hsvoan",
      pattern="quac_boa_thoeom_hsoojh_szyet_piuc_dzjec",
      cancelable=true,
      prompt="#cio_szyih_tszi_hsvoan-invoke",
      skip=true,
      min_num=1,
      max_num=1,
      include_equip=false,
      -- will_throw=false,
      -- extra_data = {
      --   cio_szyih_tszi_hsvoan = true,
      -- }
    }
    local p,cid = S.askToChooseCardExclusively(S.getHolders("quac_boa_thoeom_hsoojh_szyet_piuc_dzjec"), params, fk.ReasonDiscard)  --彊化選擇req
    if not p or #cid~=1 then return end
    room:throwCard(cid,"cio_szyih_tszi_hsvoan",p, p)
    room:recover{
      who = event:getCostData(self).targets[1],
      num = 1,
      recoverBy = p,
      skillName = "cio_szyih_tszi_hsvoan",
    }
  end,
})

return cardSkill
