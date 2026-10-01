local puanhmiuk = fk.CreateSkill {
  name = "puanhmiuk",
  -- tags = { Skill.Compulsory },
  related_skills={"tsziukzzyit_puanhdoan"}

}

Fk:loadTranslationTable{
  ["puanhmiuk"] = "反目",
  [":puanhmiuk"] = "➀伱回復體力後,伱可使用1腳色(伱或1女脚色)發動:伱爲其附加咒術｢反彈｣.➁伱失去｢反彈｣後,伱可發動:伱體力上限-1,爲伱附加｢反彈｣",

  ["#puanhmiuk-choose"] = "反目 選擇目幖",

  ["$puanhmiuk1"] = "曲有误，不可不顾。",
  ["$puanhmiuk2"] = "兀音曳绕梁，愿君去芜存菁。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

puanhmiuk:addEffect(fk.HpRecover, {
  anim_type = "support",
  can_trigger = function (self, event, target, player, data)
    return target==player and  player:hasSkill(puanhmiuk.name)
  end,
  on_cost= function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = table.filter(player.room.alive_players, function(p)
      return p==player or S.isFamle(p)
      end),  --
      skill_name = puanhmiuk.name,
      prompt = "#puanhmiuk-choose",
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    S.addTsziukzzyitBuff(event:getCostData(self).tos[1],  "puanhdoan",player)
  end,
})

-- puanhmiuk:addEffect(fk.HpRecover, {
--   anim_type = "support",
--   can_trigger = function (self, event, target, player, data)
--     return target==player and  player:hasSkill(puanhmiuk.name)
--   end,
--   on_use = function (self, event, target, player, data)
      -- player.room:changeMaxHp(player,-1)
--     S.addTsziukzzyitBuff(event:getCostData(self).tos[1],  "puanhdoan",player)
--   end,
-- })

return puanhmiuk
