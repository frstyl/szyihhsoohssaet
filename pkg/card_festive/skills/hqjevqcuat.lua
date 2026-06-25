local hqjevqcuat = fk.CreateSkill{
  name = "&hqjevqcuat",
  tags = {Skill.Compulsory },
  dynamic_desc = function (self, player)
    local n=0
    if player:getMark("cuat_pjech") >0 then
      n=player:getMark("cuat_pjech")
    end
      return "hqjevqcuat_inner:"..n
  end,
}

Fk:loadTranslationTable{
  ["&hqjevqcuat"]= "邀月",
  [":hqjevqcuat"]= "鎖定.伱額定手牌數+1",
  [":hqjevqcuat_inner"]= "鎖定.伱額定手牌數+{1}",
  ["$hqjevqcuat1"] = "昨夜嫦娥弄玉纖,也應掐月作花鈿",
  ["$hqjevqcuat2"] = "海上生明月天涯共此旹",
}


hqjevqcuat:addEffect("maxcards", {
  correct_func = function(self, player)
    if player:hasSkill(hqjevqcuat.name) then
      return 
      -- 1
        player:getMark("cuat_pjech")
    end
  end,
})


return hqjevqcuat
