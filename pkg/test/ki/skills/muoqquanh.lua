local muoqquanh = fk.CreateSkill {
  name = "muoqquanh",
}
Fk:loadTranslationTable{
  ["muoqquanh"] = "无遠",
  [":muoqquanh"] = "｡｡｡伱攻程无限大",


}

muoqquanh:addEffect("atkrange", {
  correct_func = function(self, player)
    if player:getMark("@@muoqquanh") ~=0 then
      return   999
    end
  end
})
return muoqquanh
