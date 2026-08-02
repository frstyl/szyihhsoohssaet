local ttwiqhqrach = fk.CreateSkill {
  name = "ttwiqhqrach",
  -- tags={Skill.Compulsory}
}

Fk:loadTranslationTable{
  ["ttwiqhqrach"] = "追影",
  [":ttwiqhqrach"] = "伱失去牌後,可起動1牌發動",

  ["$ttwiqhqrach1"] = "破阵杀敌，愿献犬马之劳！",
  ["$ttwiqhqrach2"] = "虎啸既响，追影当附！",
}
local S = require "packages/szyihhsoohssaet/szyih_guos"

ttwiqhqrach:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger= function(self, event, target, player, data)
    if not player:hasSkill(ttwiqhqrach.name)  then return false end

    for _, move in ipairs(data) do
      if move.from ==player and (move.to~=player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) then
        for _, info in ipairs(move.moveInfo) do
          if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)   then
            return true
          end
        end
      end
    end

  end,
  on_cost = function(self, event, target, player, data)
    local use = player.room:askToPlayCard(player, {
      skill_name = ttwiqhqrach.name,
      prompt = "#ttwiqhqrach-use",
      cancelable = true,
      extra_data = {
        bypass_distances = false,
        bypass_times = false,
        extraUse = false,
      },
      skip = true,
    })
     if use then  event:setCostData(self,{use=use}) return true end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
   room:useCard(event:getCostData(self).use)   --所起動牌不在元処也會進入処理區
  end,
})

return ttwiqhqrach
