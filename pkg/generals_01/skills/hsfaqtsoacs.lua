Fk:loadTranslationTable{
  ["hsfaqtsoacs"] = "花葬",
  [":hsfaqtsoacs"] = "鎖定.伱死亾旹必發.全體角色選1項➀流失1體力(源自伱)➁自弃1牌.肰後弃牌點數至小者牢+1(未弃牌或牌无點視爲0)",



  ["$hsfaqtsoacs1"] = "哈哈哈哈哈哈哈哈！",
  ["$hsfaqtsoacs2"] = "伯符，且看我这一手！",
}

local hsfaqtsoacs = fk.CreateSkill{
  name = "hsfaqtsoacs",
  tags = { Skill.Compulsory,Skill.Permanent },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hsfaqtsoacs:addEffect(fk.Death, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(hsfaqtsoacs.name,false,true)
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local t={}
    local min=999
    -- local 
    for _, p in ipairs(room:getOtherPlayers(player)) do
      local cards=   room:askToDiscard(p, {
        min_num = 1,
        max_num = 1,
        include_equip = true,
        skill_name = hsfaqtsoacs.name,
        cancelable = true,
        prompt = "#hsfaqtsoacs-discard",
        skip = false,
      })
      local n = 0 
      if not cards[1] then
        room:loseHp(p,1,player)
        n=0
      else
        n=Fk:getCardById(cards[1]).number
      end
      if n< min then
         min =n
         t={p}
      elseif n == min then
         table.insert(t,p)
      end
    end

    if t[1] then
      for _, p in ipairs(t) do
        room:addPlayerMark(p,"@loav",1)
      end
    end
  end,
})


return hsfaqtsoacs
