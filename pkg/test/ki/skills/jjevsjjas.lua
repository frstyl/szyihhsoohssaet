
local jjevsjjas = fk.CreateSkill {
  name = "jjevsjjas",
}

Fk:loadTranslationTable{
["jjevsjjas"] = "燿夜",
[":jjevsjjas"] = "主旹弃y牌發動.伱予坐次爲x脚色y點火傷.(x=Σ所弃牌點數 mod 存活脚色數,0爲末位.y至少爲1,至多爲存活脚色數)",
--區分伱已此法所起動 与 此牌?
["#jjevsjjas-active"] = "隨機傷一脚色",

["$jjevsjjas1"] = "來一个,殺一个.來一對,殺一雙",
["$jjevsjjas2"] = "絳霞影裏,卷一道凍地仌霜",
}

jjevsjjas:addEffect("active", {
  prompt = "#jjevsjjas-active",
  target_num = 0,
  -- max_phase_use_time = 1,
  -- min_card_num = 1,
  card_num = 0,
  -- target_filter = function(self, player, to_select, selected)
  --   return not player:prohibitDiscard(to_select) and #selected<#Fk.alive_playes
  -- end,
  can_use= function (self, player)
    return player:usedSkillTimes(jjevsjjas.name,Player.HistoryGame) < 1+player:getMark("jjevsjjas-times-phase")
  end,
  on_use = function (self, room, effect)
    local player =effect.from
    local judge = {
      who = player,
      reason = jjevsjjas.name,
      pattern = ".|.|.",
    }
    room:judge(judge)

    local x= judge.card.number
      local cards = room:askToCards(player, {
        min_num = 1,
        max_num = 999,
        include_equip = true,
        prompt = "#jjevsjjas-recast",
        skill_name = jjevsjjas.name,
        cancelable = true,
      })
    local n= #cards
    for _, id in ipairs(cards) do
      x=x+Fk:getCardById(id).number
    end
    x=x% #(room.alive_players)
    if x==0 then x =#(room.alive_players) end
    -- room:throwCard(cards, jjevsjjas.name, from, from)
    room:recastCard(cards, player, jjevsjjas.name)
    local to = room:getPlayerBySeat(x)
    room:damage{
        -- from = player,
        to = to,
        damage = 1,
        damageType = fk.FireDamage,
        skillName = jjevsjjas.name,
      }
    if to == player then 
      player:addPlayerMark(player,"jjevsjjas-times-phase",1)
    end
  end,
})

return jjevsjjas

