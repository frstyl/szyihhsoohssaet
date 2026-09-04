local dzeetliac = fk.CreateSkill {
  name = "dzeetliac",
}

Fk:loadTranslationTable{
  ["dzeetliac"] = "𢧵糧",
  [":dzeetliac"] = "其它腳色補段始旹,伱可与其賭鬥發動,(行動>戰技>實體>行動)若伱:贏,伱執行此段,;平,越過此段;輸,伱弃置1手牌",

  ["#dzeetliac-invoke"] = "𢧵糧 %src 補段 是否發動",

}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

dzeetliac:addEffect(fk.EventPhaseChanging, {
  can_trigger = function(self, event, target, player, data)
    return target ~= player and player:hasSkill(dzeetliac.name) 
    and data.phase==Player.Draw
    and player:canPindian(data.who)
  end,
  on_cost = function(self, event, target, player, data)
    if player.room:askToSkillInvoke(player,{skill_name="dzeetliac",prompt="#dzeetliac-invoke:"..data.who.id}) then
      event:setCostData(self,{tos={data.who}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = data.who
    local pindian = player:pindian({to}, dzeetliac.name)
    local c2= pindian.results[to].toCard 
    local c1=  pindian.fromCard
    if not c1 or not c2 then return end
    c1=S.getCardSuptypeByName(c1)
    c2=S.getCardSuptypeByName(c2)
    if c1==0 or c2==0 then return end
    if c1==c2 then
      data.skipped=true
    elseif  c1-c2==-1 or c1-c2==2 then
      data.who=player
    else
      room:askToDiscard(player, {
      min_num = 1,
      max_num = 1,
      include_equip = false,
      skill_name = dzeetliac.name,
      cancelable = true,
      pattern = ".",
      skip=false,
      })
    end
  end,
})

return dzeetliac
