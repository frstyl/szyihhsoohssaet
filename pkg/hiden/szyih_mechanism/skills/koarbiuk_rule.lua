local koarbiuk_rule = fk.CreateSkill {
  name = "#koarbiuk_rule",
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
    and target.phase == Player.Judge) then return nil 
    end   --應爲單獨旹機
    return #S.getPlayerKoarbiukCards({target},".")>0
  end,

  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local cardNames ={"hzaac_tshjes","thou_liac_hzvoans_dduoh","szyih_kouc"} 
    while true do

      local ids=S.getPlayerKoarbiukCards({target})
      if #ids==0 then return end
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
        -- local use = S.askToUseKoarbiukCard(room, players,  params, nil, expand)  --不同角色不同
        local use = room:askToUseRealCard(target,params)
        if use then
          -- room:addTableMark(use.from, "koarbiuk-phase", use.card.trueName)  --每个牌名1次?

          use.extra_data = use.extra_data or {}
          use.extra_data.koarbiuk = true
          -- use.from:removeVirtualEquip(use.card.id)
          room:useCard(use)
          
          table.removeOne(cardNames,use.card.name)
          if #cardNames==0 then return end
        else
          Fk.currentResponseReason = nil
          room:moveCardTo(ids, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, koarbiuk_rule.name, nil, true, nil)  --弃 廢
          return --畢 false 
        end

    end
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
