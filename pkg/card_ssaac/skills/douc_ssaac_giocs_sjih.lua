local cardSkill = fk.CreateSkill {
  name = "douc_ssaac_giocx_sjih_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#douc_ssaac_giocx_sjih_skill",
  max_turn_use_time = 1,
  can_use = function(self, player, card, extra_data)
    return Util.GlobalCanUse(self, player, card, extra_data)
     and S.magicCanUse(player, card)
    end,

  on_use = function (self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
    Util.AoeCardOnUse(self, cardUseEvent.from, cardUseEvent, true)
  end,
  mod_target_filter = Util.TrueFunc,
  on_action = function(self, room, use, finished)
    if finished 
      and  use and use.extra_data and  use.extra_data.douc_ssaac_giocx_sjih then
      room:setBanner("@@douc_ssaac_giocx_sjih",use.extra_data.douc_ssaac_giocx_sjih)
    end
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if not effect.use then return end
    effect.use.extra_data=effect.use.extra_data or {}
    effect.use.extra_data.douc_ssaac_giocx_sjih=effect.use.extra_data.douc_ssaac_giocx_sjih or {}
    table.insert(effect.use.extra_data.douc_ssaac_giocx_sjih,effect.to.id)
  end,

})

cardSkill:addEffect(fk.HpChanged, {
  global=true,
  priority=0,
	can_trigger = function(self, event, target, player, data)
    return target==player 
    and player.room:getBanner("@@douc_ssaac_giocx_sjih")  --return nil
    and table.contains(player.room:getBanner("@@douc_ssaac_giocx_sjih"),player.id)
  end,
	on_trigger = function(self, event, target, player, data)
    local room=player.room
    local pids = room:getBanner("@@douc_ssaac_giocx_sjih")
    table.removeOne(pids,player.id)
    room:setBanner("@@douc_ssaac_giocx_sjih",nil)
    for _, id in ipairs(pids) do
      room:changeHp(room:getPlayerById(id),data.num,nil,cardSkill.name,nil)
    end
  end,
})
return cardSkill
