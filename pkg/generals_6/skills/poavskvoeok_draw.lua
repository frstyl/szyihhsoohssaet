local poavskvoeok_draw = fk.CreateSkill {
  name = "#poavskvoeok_draw",
}

Fk:loadTranslationTable{
["#poavskvoeok_draw"] = "報國",
[":poavskvoeok_draw"] = "➀當一其他角色受到傷害旹伱預弃x(x爲當轉伱發動此項次數)手牌發動,弃牌將此傷害轉与(受傷角色改爲伱,緟執行受傷旹機)伱.➁當伱受到傷害後發動,伱抽x(x爲伱已損體力值)",


["#poavskvoeok_draw-draw"]="報國 抽 %arg",

["$poavskvoeok_draw1"] = "大丈夫爲國䀆忠 死而无憾",

}

poavskvoeok_draw:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(poavskvoeok_draw.name) 
  end,
  on_cost= function(self, event, target, player, data)
     return 
     player.room:askToSkillInvoke(player, {
      skill_name = poavskvoeok_draw.name,
      prompt = "#poavskvoeok_draw-draw:::"..player:getLostHp()
    }) 
  end,
  on_use = function(self, event, target, player, data)
        -- local n=player:usedEffectTimes(self.name, Player.HistoryTurn)
    player:drawCards(player:getLostHp(), poavskvoeok_draw.name)

    -- if player:usedSkillTimes(poavskvoeok_draw.name, Player.HistoryTurn) ==1 then --on_use 後
    -- player:drawCards(1, poavskvoeok_draw.name)--  --抽1
    -- end
  end,
})

return poavskvoeok_draw
