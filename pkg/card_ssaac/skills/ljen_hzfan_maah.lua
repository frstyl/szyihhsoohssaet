local ljen_hzfan_maah = fk.CreateSkill {
  name = "#ljen_hzfan_maah_skill",
  tags = { Skill.Compulsory },
  attached_equip = "ljen_hzfan_maah",
}


ljen_hzfan_maah:addEffect("maxcards", {
  correct_func = function(self, player)
    if   player:hasSkill(ljen_hzfan_maah.name)  then
      return  2
    end
  end,
})
return ljen_hzfan_maah
