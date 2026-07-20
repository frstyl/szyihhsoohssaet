local koarbiuk_rule = fk.CreateSkill {
  name = "koarbiuk_rule",
}

Fk:loadTranslationTable{
  ["#koarbiuk_rule"] = "葢伏",
  ["#koarbiuk-use"] = "預段 你可以使用葢伏牌",

  ["koarbiuk"] = "葢伏",

  ["@@koarbiuk-inarea"] = "葢伏",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

--EventPhaseStart
koarbiuk_rule:addEffect(fk.EventPhaseProceeding, {  --手牌可用之牌 葢牌何用
  priority = 0,
  can_trigger = function(self, event, target, player, data)
    if not ( target==player --同旹 止問1次
      and target.phase == Player.Judge) 
    then 
      return nil 
    end   --應爲單獨旹機
    return true
  end,

  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local cardNames ={"mae_biuk","thou_liac_hzvoans_dduoh","szyih_kouc"} 
    while true do

      local ids=S.getPlayerKoarbiukCards({target})
      if #ids==0 then break end
      local params={
        pattern = ids,
        skill_name = "koarbiuk_rule",  --提示
        prompt = "#koarbiuk-use",
        cancelable = true,
        expand_pile = ids,
        skill_name="koarbiuk",
        skip = true,
        -- event_data = data,
        extra_data = {
          -- exclusive_targets = {target.id},  --又用Id矣
          bypass_distances = true,  --葢伏特性
          bypass_times = false,
          extraUse = false,
          -- not_passive=false,
          koarbiuk_rule=true,
        }
      }

        Fk.currentResponseReason = "koarbiuk_rule"
        -- local use = S.askToUseKoarbiukCard(room, players,  params, nil, expand)  --不同脚色不同
        local use = room:askToUseRealCard(target,params)
        if use then
          -- room:addTableMark(use.from, "koarbiuk-phase", use.card.trueName)  --每个牌名1次?

          use.extra_data = use.extra_data or {}
          use.extra_data.koarbiuk = true
          -- use.from:removeVirtualEquip(use.card.id)
          room:useCard(use)
          
          table.removeOne(cardNames,use.card.name)
          if #cardNames==0 then break end
        else
          Fk.currentResponseReason = nil
          room:moveCardTo(ids, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, koarbiuk_rule.name, nil, true, nil)  --弃 廢
          break
          -- return --畢 false 
        end

    end

    local cards = player:getCardIds(Player.Judge)
    while #cards > 0 do
      if data.phase_end then break end
      local cid = table.remove(cards)
      if not cid then return end
      local card = player:getVirtualEquip(cid)
      if not card then
        card = Fk:getCardById(cid)
      end

      if  not table.contains({"hqjin_szjer_ljis_doavs","tshoak_hsvoah_tsjek_sjin","koarbiuk_card"},card.trueName)
      and 
      table.contains(player:getCardIds(Player.Judge), cid) and card.skill and card.skill.name ~= "default_card_skill"
      then
        room:moveCardTo(card, Card.Processing, nil, fk.ReasonPut, "phase_judge")
        if card:isVirtual() then
          room:sendCardVirtName({cid}, card.name)
        end

        local effect_data = CardEffectData:new {
          card = card,
          to = player,
          tos = { player },
        }
        room:sendLog{
          type = "#CardEffect",
          from = player.id,
          arg = card:toLogString(),
        }
        room:doCardEffect(effect_data)
        if effect_data.isCancellOut then
          card.skill:onNullified(room, effect_data)
        end
      end
    end
    data.phase_end = true
  end,
})

koarbiuk_rule:addEffect("visibility", {
  card_visible = function (self, player, card)
    -- local owner = Fk:currentRoom():getCardOwner(card)
    -- if owner and (#card:getTableMark("@@koarbiuk-inarea")>0
    -- (or owner:getVirualEquip(card.id) and owner:getVirualEquip(card.id).name == "koarbiuk_card")) then
    --   return player == owner
    -- end
    if table.contains(S.getPlayerKoarbiukCards(player),card.id ) then
      return true
    elseif table.contains(S.getAllKoarbiukCards(),card.id ) then
       
        return false
    end
  end,
  -- move_visible = function (self, player, info, move)
  --   local cid = info.cardId
  --   if move.from and move.toArea == Card.PlayerJudge then
  --     local from = Fk:currentRoom():getPlayerById(move.from)
  --     if #Fk:getCardById(cid):getTableMark("@@koarbiuk-inarea")>0 or (from:getVirualEquip(cid) and from:getVirualEquip(cid).name == "koarbiuk_card") then
  --       return false
  --     end
  --   end
  -- end,
})


return koarbiuk_rule
