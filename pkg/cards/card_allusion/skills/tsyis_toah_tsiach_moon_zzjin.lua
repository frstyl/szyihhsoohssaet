local cardSkill = fk.CreateSkill {
  name = "tsyis_toah_tsiach_moon_zzjin_skill",
}
-- Fk:loadTranslationTable{
--   ["#khfar_hzvoat_ljim"] = "快活林 令伱下1殺傷害基數+1",
--   ["#muo_tsiuh_piu_hsvoan"] = "无酒不歡 已醉打蔣門神 置換%arg",
--   ["@khfar_hzvoat_ljim-turn"] = "快活林",
--   ["#muo_tsiuh_piu_hsvoan-choose"] = "无酒不歡 選擇1酒",
-- }

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt="#khfar_hzvoat_ljim",
  -- prompt = function(self, _, _, _, extra_data)
  --   return extra_data.khfar_hzvoat_ljim and "#khfar_hzvoat_ljim"  
  -- or "#muo_tsiuh_piu_hsvoan"  --extra?
  -- end,
  mod_target_filter = Util.TrueFunc,
  -- fix_targets=function(self,player,card,extra_data) --on_use?
  --   return {player}
  -- end,
  -- on_use = function(self, room, effect)
  --   effect.to=effect.from
  -- end,
  target_num=1,
  target_filter = Util.CardTargetFilter,
  can_use =Util.FalseFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    room:addPlayerMark(effect.to,"@khfar_hzvoat_ljim-turn",1)  --計數  --additionalDrank
  end,
})

cardSkill:addEffect(fk.CardEffectFinished, {
  -- global = true,
  can_trigger = function(self, event, target, player, data)
    return data.from == player
    and data.to==player
    and data.card
    and data.card.trueName=="tsiuh"
    and not (data.use and data.use.extra_data and data.use.extra_data.tsiuhRecover)  --no use
    and not data.isCancellOut and not data.nullified
    -- and #S.getHolders("tsyis_toah_tsiach_moon_zzjin",{player})>0
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    local params={
      skill_name = "khfar_hzvoat_ljim",
      pattern = "tsyis_toah_tsiach_moon_zzjin",
      prompt = "#khfar_hzvoat_ljim",
      cancelable = true,
      skip=true,
        extra_data = {  --不計次?
          khfar_hzvoat_ljim = true,
          -- fix_targets={player.id},
          -- must_targets=
          exclusive_targets={data.from.id},
        }
    }
    local use = S.askToUseKoarbiukCard(data.from, params, nil, nil, #S.getHolders("tsyis_toah_tsiach_moon_zzjin",{data.from})==0, true)
    if use then
      -- use.extra_data=use.extra_data or{}
      -- use.extra_data.fix_targets={player.id}
      room:useCard(use)
    end
  end,
})

cardSkill:addEffect(fk.PreCardUse, {
  -- global = true,
  can_refresh = function(self, event, target, player, data)
    return target == player and data.card.trueName == "ssaet" and player:getMark("@khfar_hzvoat_ljim-turn") > 0
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    data.additionalDamage = (data.additionalDamage or 0) +  player:getMark("@khfar_hzvoat_ljim-turn")
    data.extra_data = data.extra_data or {}
    data.extra_data.khfar_hzvoat_ljim =  true --player:getMark("@khfar_hzvoat_ljim-turn")
    room:setPlayerMark(player,"@khfar_hzvoat_ljim-turn",0)
  end,
})




cardSkill:addEffect(fk.AfterCardsMove, {
  -- global = true,
  can_trigger = function(self, event, target, player, data)
    local room=player.room
    if player~=player.room.alive_players[1] then return end --能否問死
    local ids={}
      for _, move in ipairs(data) do  --data move info
        if  move.toArea == Card.DiscardPile then
          for _, info in ipairs(move.moveInfo) do
            if  Fk:getCardById(info.cardId).trueName == "tsiuh" then
              table.insertIfNeed(ids, info.cardId)
            end
          end
        end
      end
    ids = table.filter(ids, function (id)
      return table.contains(player.room.discard_pile, id)
    end)
    ids = player.room.logic:moveCardsHoldingAreaCheck(ids)  --單此?
    if #ids==0 then return end
    local players=table.filter(S.getHolders("tsyis_toah_tsiach_moon_zzjin", room.alive_players,fk.ReasonExchange), function(p)
      return room:getCurrent()~=p
    end)
    if #players==0 then return end
    event:setCostData(self,{players=players,ids=ids})
    return  true
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local ids=event:getCostData(self).ids
    local cardid=ids[1]
    local params={
      players=event:getCostData(self).players,
      skill_name = "muo_tsiuh_piu_hsvoan",
      pattern="tsyis_toah_tsiach_moon_zzjin",
      cancelable=true,
      prompt="#muo_tsiuh_piu_hsvoan:::"..Fk:getCardById(cardid):toLogString(),
      skip=true,
      min_num=1,
      max_num=1,
      include_equip=false,
      -- will_throw=false,
      -- extra_data = {
      --   muo_tsiuh_piu_hsvoan = true,
      -- }
    }
    local p,cid = S.askToChooseCardExclusively(event:getCostData(self).players, params, fk.ReasonExchange)  --彊化選擇req
    if not p or #cid~=1 then return end

    if #ids~=1 then--再檢測?
      cardid= room:askToChooseCard(p,{
            target = p,
            flag = { card_data = {{ "toObtain", ids }} },
            skill_name = cardSkill.name,
            prompt = "#muo_tsiuh_piu_hsvoan-choose",
          })
    end

    room:swapCardsWithPile(p,cid,{cardid},"muo_tsiuh_piu_hsvoan","discardPile",true)
    -- local moveInfos={}

    -- table.insert(moveInfos,{  --改判
    --   ids = cid, --id list
    --   from = p,
    --   toArea = Card.DiscardPile,
    --   moveReason = fk.ReasonExchange,
    --   skillName = "muo_tsiuh_piu_hsvoan",
    --   proposer = p,
    -- })

  
    -- table.insert(moveInfos,{---@type CardsMoveInfo
    --   ids = {cardid},
    --   to =  p ,
    --   toArea =  Card.PlayerHand,
    --   moveReason =  fk.ReasonExchange,
    --   skillName = "muo_tsiuh_piu_hsvoan",
    --   proposer = p,
    -- } )

    -- room:moveCards(table.unpack(moveInfos))

  end,
})

return cardSkill


