local khouc = fk.CreateSkill {
  name = "khouc_skill",
}

Fk:loadTranslationTable{
  ["#khouc_skill"] = "空",
}

khouc:addEffect("cardskill", {
  can_use = Util.FalseFunc,
})

return khouc
