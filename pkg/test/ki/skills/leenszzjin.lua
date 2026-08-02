local noaqmjens = fk.CreateSkill {
  name = "noaqmjens",
}

-- local U = require "packages.utility.utility"

Fk:loadTranslationTable{
  ["noaqmjens"] = "儺面", --游學
  [":noaqmjens"] = "此技能登場旹/伱轉始前,伱選擇其它腳色1技能,自游戲外將面具置入伱寶物瀾,面具復刻所選技能",

  ["#noaqmjens-skill"] = "儺面 選擇 %src 技能",

  ["@noaqmjens_mjens"] = "",

  ["$noaqmjens1"] = "太丘道广，广则不周。仲举性峻，峻则少通。",
  ["$noaqmjens2"] = "君生淸平则为奸逆，处乱世当居豪雄。",
}

--自帶技能

local S = require "packages/szyihhsoohssaet/szyih_guos"



local spec={
  -- priority=2,
  can_trigger = function (self, event, target, player, data)
    return (target==nil or target==player)
    and  player:hasSkill(noaqmjens.name)
  end,
  on_cost = function (self, event, target, player, data)
    local room=player.room
    local getSkills=function(p)  --將牌上
    local t={}
     for _, skill_name in ipairs(Fk.generals[p.general]:getSkillNameList())  do
      if not  Fk.skills[skill_name]:hasTag(Skill.Proprietary) and not table.contains(player:getSkillNameList()) then
        table.insert(t,skill_name)
      end
     end
      local deputy = Fk.generals[p.deputyGeneral]
      if deputy then
        for _, skill_name in ipairs(deputy:getSkillNameList())  do
          if not  Fk.skills[skill_name]:hasTag(Skill.Proprietary) and not table.contains(player:getSkillNameList()) then
            table.insertIfNeed(t,skill_name)
          end
        end
      end
     return t
    end

    local targets =table.filter(room.alive_players,function(p)return #getSkills(p)>0 end)
    if #targets== 0 then return end
    local tos = room:askToChoosePlayers(player, {
      targets = targets,
      min_num = 1,
      max_num = 1,
      prompt = "#noaqmjens-invoke",
      skill_name = noaqmjens.name,
    })
    if #tos > 0 then
      local choice = room:askToChoice(player, {
      choices = getSkills(tos[1]),
      skill_name = noaqmjens.name,
      prompt = "#noaqmjens-skill::" .. tos[1].id,
      detailed = true,
    })

      event:setCostData(self, { tos = tos,choice=choice })
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room=player.room
    local card = room:printCard("noaqmjens_mjens")
    local choice=event:getCostData(self).choice
    room:addTableMark(card,"@noaqmjens_mjens", choice)
    -- room:addTableMark(player,"@noaqmjens_mjens", choice)
    -- room:moveCards({
    --   ids = {card.id},
    --   to = player,
    --   toArea = Card.PlayerHand,
    --   moveReason = fk.ReasonJustMove,
    --   proposer = player,
    --   skillName = noaqmjens.name,
    --   moveVisible = true,
    -- })
    room:moveCardIntoEquip(player, card, noaqmjens.name, true, player)

  end,
}
noaqmjens:addEffect(fk.GamePrepared, spec)
noaqmjens:addEffect(fk.AfterPropertyChange, spec)
noaqmjens:addEffect(fk.BeforeTurnStart, spec)
-- noaqmjens:addEffect(fk.EventAcquireSkill, spec)

noaqmjens:addEffect("filter", {
  equip_skill_filter = function(self, skill, player) --視爲裝僃技能
    if not player then return end
    local cards =player:getEquipCards()
    if #cards==0 then return end
      for _, card in ipairs(cards) do
        if card.trueName=="noaqmjens_mjens"  and table.contains(card:getTableMark("noaqmjens_mjens"), skill.name)  then
          return "noaqmjens_mjens"
        end
      end
    
  end,
})



return noaqmjens
