local cardSkill = fk.CreateSkill {
  name = "lih_doeojs_doav_kiac_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  can_use = Util.FalseFunc,
  on_use = function (self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
    cardUseEvent.toCard = use.card  --无目幖
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.responseToEvent then
      room:loseHp(effect.from,1,cardSkill.name)
      S.preventDamage({damageData=effect.responseToEvent,skillName=cardSkill.name})  --skill??
      if not effect.from.dead then effect.from.drawCards(1,cardSkill.name) end
    end
  end,
})

cardSkill:addEffect(fk.DamageInflicted, {  --合并諸牌
  -- global = true,
  -- mute = true,
  priority = 0.001, 
  can_trigger = function(self, event, target, player, data)
    if  player.seat~=1  then return end
      local players=S.getHolders("lih_doeojs_doav_kiac")
      local card=Fk:cloneCard("lih_doeojs_doav_kiac")
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
      skill_name = "lih_doeojs_doav_kiac",
      pattern="lih_doeojs_doav_kiac",
      cancelable=true,
      prompt="#lih_doeojs_doav_kiac",
      skip=true,
      extra_data = {
        lih_doeojs_doav_kiac = true,
      }
      -- event_data = data,
    }
    local use = S.askToUseKoarbiukCard(room,event:getCostData(self).players,params)
    if use then
      use.responseToEvent = data
      room:useCard(use)
    end

  end,
})

return cardSkill
