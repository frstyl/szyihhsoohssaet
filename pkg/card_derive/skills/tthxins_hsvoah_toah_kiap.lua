local cardSkill = fk.CreateSkill {
  name = "tthxins_hsvoah_toah_kiap_skill",
}

Fk:loadTranslationTable{
["tthxins_hsvoah_toah_kiap_skill"] = "趁火打劫",
[":tthxins_hsvoah_toah_kiap_skill"] = "當其它角色受傷後,若其有牌,伱可對其使用｡伱獲取其1牌.",

["#tthxins_hsvoah_toah_kiap_skill-invoke"] = "謀財 獲取 %src 手牌",
}
cardSkill:addEffect("cardskill", {
  prompt = "#tthxins_hsvoah_toah_kiap_skill",
  offset_func= Util.FalseFunc,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)  --extra_data?
      return not to_select:isAllNude()
      and to_select ~= player 
  end,
  target_filter  = function(self, player, to_select, selected, _, card, extra_data)
    if not extra_data or not extra_data.tthxins_hsvoah_toah_kiap then return end
    return to_select == extra_data.tthxins_hsvoah_toah_kiap 
    and Util.CardTargetFilter(self, player, to_select, selected, _, card, extra_data)  --isProhibited

  end,
  target_num = 1,
  can_use = function(self, player, card, extra_data)  --主旹不能用 點名不能用 止牌自己旹機可用  --應動 因動
    if player:prohibitUse(card) then return end
    return extra_data and extra_data.tthxins_hsvoah_toah_kiap 
  end,
  on_effect = function(self, room, effect)
    if effect.from.dead or effect.to.dead or effect.to:isAllNude() then return end
    local cid = room:askToChooseCard(effect.from, { target = effect.to, flag = "he", skill_name = cardSkill.name })
    room:obtainCard(effect.from, cid, false, fk.ReasonPrey, effect.from, cardSkill.name)
  end,
})

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect(fk.Damaged, {  --合并諸牌  --于時機問牌skill判定是否可用 用牌前前調用牌処理相關
  -- global = true,
  -- mute = true,
  priority = 0.001, 
  can_trigger = function(self, event, target, player, data)
    if  player.seat~=1  then return end
      local players=S.getHolders("tthxins_hsvoah_toah_kiap")
      local card=Fk:cloneCard("tthxins_hsvoah_toah_kiap")
      card:setVSPattern(nil,nil,".")
      local ps={}
      for _, p in pairs(players) do
        if S.magicCanUse(p,card) then
          table.insert(ps,p)
        end
      end
      if #ps>0 then
        event:setCostData(self,{players=ps})
        return true
      end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
      local params={
      skill_name = "tthxins_hsvoah_toah_kiap",
      pattern="tthxins_hsvoah_toah_kiap",
      cancelable=true,
      prompt="#tthxins_hsvoah_toah_kiap",
      skip=true,
      extra_data = {
        tthxins_hsvoah_toah_kiap = target,
      }
      -- event_data = data,
    }
    local use = S.askToUseKoarbiukCard(room,event:getCostData(self).players,params)
    if use then
      room:useCard(use)
    end

  end,
})

return cardSkill
