
local tseettszjer = fk.CreateSkill {
  name = "tseettszjer",
}

Fk:loadTranslationTable{
  ["tseettszjer"] = "節制",
  [":tseettszjer"] = "伱主段始旹,伱可選擇1腳色發動,其體力調爲x,伱弃置y手牌(x爲其實有技能數,y爲因此變化體力值,若爲0伱抽x)",

  ["tseettszjer-choose"] = "節制",
}

tseettszjer:addEffect(fk.EventPhaseStart, {  --EventPhaseStart
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tseettszjer.name)
     and data.phase == Player.Play
  end,
  on_cost = function(self, event, target, player, data)
  local tos = player.room:askToChoosePlayers(player, {
      targets = player.room.alive_players,
      min_num = 1,
      max_num = 1,
      prompt = "#tseettszjer-ask",
      skill_name = tseettszjer.name,
    })
    if #tos > 0 then
      event:setCostData(self, { tos = tos })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local to =event:getCostData(self).tos[1]
    local m=#to:getSkillNameList()
    local n = to:getHandcardNum()
    if n>m then
          player.room:askToDiscard(to, {
      min_num = n-m,
      max_num = n-m,
      include_equip = false,
      skill_name = tseettszjer.name,
      prompt = "#tseettszjer-discard",
      cancelable = false,
      skip = false,
    })
    else
      to:drawCards(m-n,tseettszjer.name )
    end

    n =m-to.hp
    if n==0 then 
      player:drawCards(m,tseettszjer.name)
    return end
    player.room:changeHp(to, n , nil,tseettszjer.name)
    -- player.room:askToDiscard(player, {
    --   min_num = math.abs(n),
    --   max_num = math.abs(n),
    --   include_equip = false,
    --   skill_name = tseettszjer.name,
    --   prompt = "#tseettszjer-discard",
    --   cancelable = false,
    --   skip = false,
    -- })
  end,
})

return tseettszjer

