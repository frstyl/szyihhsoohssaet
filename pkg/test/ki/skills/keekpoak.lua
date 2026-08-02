local keekpoak = fk.CreateSkill {
  name = "keekpoak",
}

Fk:loadTranslationTable{
  ["keekpoak"] = "擊搏",
  [":keekpoak"] = "其它脚色始段始旹伱可發動.其可將1牌轉化爲殺起動,止指定伱爲目幖无視距離次數.若其未因此致傷,當轉內其不可起動非基本牌",

  ["#keekpoak-invoke"] = "擊搏：视为 %dest 对你起動【杀】，若未造成伤害则其本回合不可起動锦囊牌",
  ["#keekpoak-use"] = "擊搏 對 %src 起動 殺",
  ["@@keekpoak-turn"] = "擊搏",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 


keekpoak:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target ~= player and player:hasSkill(keekpoak.name) and target.phase == Player.Start 
    and not target.dead
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    if room:askToSkillInvoke(player, {
      skill_name = keekpoak.name,
      prompt = "#keekpoak-invoke::"..target.id,
    }) then
      event:setCostData(self, {tos = {target}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local use room:askToUseVirtualCard(target, {
        name = "ssaet",
        -- subcards = cards,
        skill_name = keekpoak.name,
        cancelable = true,
        prompt = "#keekpoak-use:"..player.id,
        extra_data = {
          bypass_times = true,
          extraUse = true,
          bypass_distances = true,
          exclusive_targets = {player.id},
        },
        card_filter = {
        n = 1,
      },
        cancelable = true,
        skip=false,
      })
    -- room:useCard(use)
    if not (use and use.damageDealt) and not target.dead then
      room:setPlayerMark(target, "@@keekpoak-turn", 1)
    end
  end,
})

keekpoak:addEffect("prohibit", {
  prohibit_use = function (self, player, card)
    return card and player:getMark("@@keekpoak-turn") > 0 and S.getCardTypeByName(card.trueName)~=1
  end,
})

return keekpoak
