local hzaahjiak = fk.CreateSkill {
  name = "hzaahjiak",
}
Fk:loadTranslationTable{
["hzaahjiak"] = "下藥",
[":hzaahjiak"] = "主動.伱可將黑桃手牌轉化爲瞞天過海使用發動.本轉內,伱對迷狀態角色致傷歬,伱可發動,流失等傷害值量體力,伱獲取其1牌.伱使用瞞天過海可額外指定1目幖",
["#hzaahjiak"]="下藥 將黑桃手牌轉化爲瞞天過海使用",

["#hzaahjiak-invoke"] = "下藥 防止對 %src 傷害",
["@@hzaahjiak-turne"] = "下藥",

["$hzaahjiak"] = "倒倒下矣",

}
hzaahjiak:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "sjevs_lih_dzoac_toav",
  prompt = "#hzaahjiak",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and Fk:getCardById(to_select).suit == Card.Spade and table.contains(player:getCardIds("h"),to_select)
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("sjevs_lih_dzoac_toav")
    c.skillName = hzaahjiak.name
    c:addSubcard(cards[1])
    return c
  end,
  -- before_use = function (self, player, use)
  --   player.room:addPlayerMark(player,"@@hzaahjiak-turn",1)
  -- end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = Util.FalseFuncFunc,
})

hzaahjiak:addEffect(fk.PreDamage, {
  anim_type = "offensive",
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return target==player 
    and --player:getMark("@@hzaahjiak-turn") >0
    player:usedSkillTimes(hzaahjiak.name, Player.HistoryTurn) > 0 
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    if not room:askToSkillInvoke(player, {
      skill_name = hzaahjiak.name,
      prompt = "#hzaahjiak-invoke:"..data.to.id,
    }) then return end
    local n= data.damage
    data:preventDamage()  --无旹機
    player.room:loseHp(data.to, n, hzaahjiak.name,player)
    local cid = room:askToChooseCard(player, { target = data.to, flag = "he", skill_name = hzaahjiak.name })
    room:obtainCard(player, cid, false, fk.ReasonPrey, player, hzaahjiak.name)
  end,
})

hzaahjiak:addEffect("targetmod", {

  extra_target_func = function(self, player, skill, card)
    if player:hasSkill(hzaahjiak.name) and card.trueName=="sjevs_lih_dzoac_toav" then
      return 1
    end
  end,
})
return hzaahjiak
