local oc = require("prototypes.modules.oc")
return {

    degrade_effect = function(category, effect)
        if effect == nil or category == nil then
            return {}
        end
        if category == "speed" then
            if effect.speed then
                effect.speed = effect.speed * 0.7
            end
            if effect.quality and effect.quality < 0 then
                effect.quality = effect.quality * 4
            end
        elseif category == "quality" then
            if effect.quality then
                effect.quality = effect.quality * 0.5
            end
            if effect.speed and effect.speed < 0 then
                effect.speed = effect.speed * 4
            end
        elseif category == "productivity" then
            if effect.productivity then
                effect.productivity = effect.productivity * 0.75
            end
            if effect.speed and effect.speed < 0 then
                effect.speed = effect.speed * 2
            end
            if effect.consumption and effect.consumption > 0 then
                effect.consumption = effect.consumption * 2
            end
            if effect.pollution and effect.pollution > 0 then
                effect.pollution = effect.pollution * 2
            end
        elseif category == "efficiency" then
            if effect.consumption then
                effect.consumption = effect.consumption * 0.5
            end
        elseif category == "overclock" then
            if effect.productivity then
                effect.productivity = effect.productivity * 0.75
            end

            if effect.speed and effect.speed < 0 then
                effect.speed = effect.speed * 2
            end
            if effect.consumption and effect.consumption > 0 then
                effect.consumption = effect.consumption * 2
            end
            if effect.pollution and effect.pollution > 0 then
                effect.pollution = effect.pollution * 2
            end
        elseif category == "pollution" then
            if effect.pollution then
                effect.pollution = effect.pollution / 2
            end
        end
        return effect
    end,



    overclock_effect = function(category, effect, level, d)
        local e = effect
        if effect == nil or category == nil then
            return {}
        end
        if category == "speed" then
            if e.speed then
                e.speed = d and e.speed * oc[level].db or e.speed * oc[level].b
            end
        elseif category == "quality" then
            if e.quality then
                e.quality = d and e.quality * oc[level].db or e.quality * oc[level].b
            end
        elseif category == "productivity" then
            if e.productivity then
                e.productivity = d and e.productivity * oc[level].db or e.productivity * oc[level].b
            end
        elseif category == "efficiency" then
            if e.consumption then
                e.consumption = d and e.consumption * oc[level].db or e.consumption * oc[level].b
            end
        elseif category == "overclock" then
            if e.productivity then
                e.productivity = d and e.productivity * oc[level].db or e.productivity * oc[level].b
            end
        elseif category == "pollution" then
            e.pollution = d and e.pollution * oc[level].db or e.pollution * oc[level].b
        end
        return effect
    end,


    hyper_effect = function(category, effect)
        local e = effect
        if effect == nil or category == nil then
            return {}
        end
        if category == "speed" then
            e.quality = (e.quality and (e.quality > 0 and e.quality * 2 or 0) or 0)
            e.consumption = (e.consumption and (e.consumption > 0 and (math.floor(e.consumption * 7.5) / 10) or e.consumption * 2) or 0)
            e.speed = e.speed and (e.speed > 0 and e.speed * 2 or e.speed / 2) or 0.20
            e.productivity = (e.productivity and (e.productivity > 0 and e.productivity * 2 or 0) or 0)
            e.pollution = (e.pollution and (e.pollution > 0 and 0 or e.pollution * 2) or 0)
        elseif category == "quality" then
            e.quality = (e.quality and (e.quality > 0 and e.quality * 2 or 0) or 0)
            e.consumption = (e.consumption and (e.consumption > 0 and (math.floor(e.consumption * 7.5) / 10) or e.consumption * 2) or 0)
            e.speed = e.speed and (e.speed > 0 and e.speed * 2 or 0) or 0.20
            e.productivity = (e.productivity and (e.productivity > 0 and e.productivity * 2 or 0) or 0)
            e.pollution = (e.pollution and (e.pollution > 0 and 0 or e.pollution * 2) or 0)
        elseif category == "productivity" then
            e.quality = (e.quality and (e.quality > 0 and e.quality * 2 or 0) or 0)
            e.consumption = (e.consumption and (e.consumption > 0 and (math.floor(e.consumption * 7.5) / 10) or e.consumption * 2) or 0)
            e.speed = e.speed and (e.speed > 0 and e.speed * 2 or e.speed / 2) or 0.20
            e.productivity = (e.productivity and (e.productivity > 0 and e.productivity * 2 or 0) or 0)
            e.pollution = (e.pollution and (e.pollution > 0 and 0 or e.pollution * 2) or 0)
        elseif category == "efficiency" then
            e.quality = (e.quality and (e.quality > 0 and e.quality * 2 or 0) or 0)
            e.consumption = (e.consumption and (e.consumption > 0 and (math.floor(e.consumption * 7.5) / 10) or e.consumption * 3) or 0)
            e.speed = e.speed and (e.speed > 0 and e.speed * 2 or e.speed / 2) or 0.20
            e.productivity = (e.productivity and (e.productivity > 0 and e.productivity * 2 or 0) or 0)
            e.pollution = (e.pollution and (e.pollution > 0 and 0 or e.pollution * 2) or -0.25)
        elseif category == "overclock" then
            e.quality = (e.quality and (e.quality > 0 and e.quality * 2 or 0) or 0)
            e.consumption = (e.consumption and (e.consumption > 0 and (math.floor(e.consumption * 7.5) / 10) or e.consumption * 2) or 0)
            e.speed = e.speed and (e.speed > 0 and e.speed * 2 or e.speed / 2) or 0.20
            e.productivity = (e.productivity and (e.productivity > 0 and e.productivity * 2 or 0) or 0)
            e.pollution = (e.pollution and (e.pollution > 0 and 0 or e.pollution * 2) or 0)
        elseif category == "pollution" then
            e.quality = (e.quality and (e.quality > 0 and e.quality * 2 or 0) or 0)
            e.consumption = (e.consumption and (e.consumption > 0 and (math.floor(e.consumption * 7.5) / 10) or e.consumption * 2) or (e.pollution > 0 and 0.20 or -0.20))
            e.speed = e.speed and (e.speed > 0 and e.speed * 2 or e.speed / 2)
            e.productivity = (e.productivity and (e.productivity > 0 and e.productivity * 2 or 0) or 0)
            e.pollution = (e.pollution and e.pollution * 2 or 0)
        end
        return effect
    end



}
