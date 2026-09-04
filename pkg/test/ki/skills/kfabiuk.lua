local kfaqbiuk = fk.CreateSkill{
  name = "kfaqbiuk",
}

Fk:loadTranslationTable{
  ["kfaqbiuk"] = "蝸伏",
  [":kfaqbiuk"] = "恆續,其它腳色至伱距離按較長計",

  ["@kfaqbiuk_cards"] = "疾步",
  -- ["$kfaqbiuk1"] = "",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

kfaqbiuk:addEffect("distance", {  --應該0級fixed--getDirectFromAToB
  fixed_func = function(self, from, to)
    if from~=to and to:hasSkill(kfaqbiuk.name)  then
      local seat= S.getSeats(to)
      return math.max(table.indexOf(seat,from) -1, #seat+1-table.indexOf(seat,from) )
    end

  end,
})
return kfaqbiuk
