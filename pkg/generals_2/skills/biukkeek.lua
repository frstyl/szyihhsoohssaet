Fk:loadTranslationTable{
  ["biukkeek"] = "伏擊",
  [":biukkeek"] = "每輪限1.其它角色伏段始旹,伱可預打出1牌發動.視爲伱對其使用行刺,若其伏區有延時牌,伱選擇1項➀伱流失1體力,此牌傷害基數+1➁此牌不可被抵消且此技能當輪可發動次數+1",
--加彊?

  ["#biukkeek-invoke"] = "伏擊 昰否打出1牌行刺 %src",

  ["#biukkeek-choose"] = "伏擊 選擇",
  ["biukkeek-damage"] = "行刺傷害基數+1",
  ["biukkeek-times"] = "伏擊 可發動次數+1",

  ["$biukkeek1"] = "太歲頭上也敢動土",
  ["$biukkeek2"] = "爺爺在此𠊱伱多旹了",
  ["$biukkeek3"] = "進了昰蘆葦港伱還跑的掉",
}

local biukkeek = fk.CreateSkill{
  name = "biukkeek",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

biukkeek:addEffect(fk.EventPhaseStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target~=player and player:hasSkill(biukkeek.name) and target.phase == Player.Judge
    and player:usedSkillTimes(biukkeek.name, Player.HistoryRound)<player:getMark("_biukkeek-round")+1
    and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local cards = S.askToPlayCard(player, {
		  min_num = 1,
		  max_num = 1,
		  include_equip = true,
		  skill_name = biukkeek.name,
		  cancelable = true,
      pattern = ".",
      prompt = "#biukkeek-invoke:"..target.id,
		  skip = true,
		})
    if #cards ~= 0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    S.playCard(player,event:getCostData(self).cards, biukkeek.name)
    local card = Fk:cloneCard("hzaac_tshjes")
    card.skillName = biukkeek.name
    local use={
      from = player,
      tos = {target},
      card = card,
    }
    if #S.getPlayerDelayCards(target)>0 then
      local choice =room:askToChoice(player,{
        skill_name=biukkeek.name,
        prompt="#biukkeek-choose",
        choices={"biukkeek-damage","biukkeek-times"},  --背水
      }) 
      if choice  =="biukkeek-damage" then
        room:loseHp(player,1,biukkeek.name,player)
        use.additionalDamage=1
      else
        use.unoffsetableList = table.simpleClone(room.players)
        room:setPlayerMark(player,"_biukkeek-round",1)
      end
    end
    room:useCard(use)
  end,
})

return biukkeek
