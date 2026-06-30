local ddwenqszio = fk.CreateSkill {
  name = "ddwenqszio",
}
Fk:loadTranslationTable{
  ["ddwenqszio"] = "傳書",
  [":ddwenqszio"] = "主旹,預打出1牌發動。全體角色得1空｡輪終,全體角色可將空轉化爲殺使用",

  ["#ddwenqszio-use"] = "傳書 將空牌轉化爲殺",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

ddwenqszio:addEffect("active", {
  anim_type = "offensive",
  prompt = "#ddwenqszio",
  card_num = 1,
  target_num = 0,
  max_phase_use_time=1,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(ddwenqszio.name, Player.HistoryGame) == 0
  -- end,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 
    and  not player:prohibitResponse(to_select)
  end,
  on_use = function(self, room, effect)
    S.playCard(effect.from,effect.cards,ddwenqszio.name)

    for _, to in ipairs(room:getAlivePlayers()) do
      room:moveCards({
        ids = S.getKhouc(room,1),
        to = to,
        toArea = Card.PlayerHand,
        moveReason = fk.ReasonJustMove,
        proposer = effect.from,
        skillName = ddwenqszio.name,
        moveVisible = true,
      })
    end
    room:setPlayerMark(effect.from,"@@ddwenqszio-round",1)
  end,
})
ddwenqszio:addEffect(fk.RoundEnd, {
  is_delay_effect=ture,
  can_trigger = function(self, event, target, player, data)
    -- return player:usedSkillTimes(ddwenqszio.name,Player.HistoryRound)>0
    return player:getMark("@@ddwenqszio-round") > 0
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local exe = function(to)
      if to.dead then return end
        local n=999  --上限?
        local ddwenqszio_tos = {}
          for _, p in ipairs(room:getAlivePlayers(to,false)) do
            if  not p:isRemoved() then
              if to:distanceTo(p)==n then
                table.insert(ddwenqszio_tos,p)
              elseif to:distanceTo(p)<n then
                ddwenqszio_tos={p}
              end
            end
          end
        ddwenqszio_tos=table.map(ddwenqszio_tos,Util.IdMapper)
        local use = room:askToUseVirtualCard(to, {
          name="ssaet",
          card_filter={
            n=1,
            pattern = "khouc",
          },
          skill_name = ddwenqszio.name,
          prompt = "#ddwenqszio-use",
          extra_data = {
            include_targets = ddwenqszio_targets,
            bypass_times = false,
            extraUse = false,
          },
          cancelable=true,
          skip=true,
        })
        if use then
          room:useCard(use)
        end
    end

    exe(player)
    for _, to in ipairs(room:getOtherPlayers(player)) do
      exe(to)
    end
  end
})

return ddwenqszio
