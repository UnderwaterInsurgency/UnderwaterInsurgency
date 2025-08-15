--[[
    This example shows how to create a script that zooms out the camera when aiming with a weapon that has the "zoom" tag, currently only the lua revolver has this tag.
--]]

if SERVER then return end

local function lerp(a,b,t)
    return a * (1 - t) + b * t
end

Hook.Patch("Barotrauma.Character", "ControlLocalPlayer", function (instance, ptable)
    local character = instance

    if not character then return end
    if not character.Inventory then return end

    local headset = character.Inventory.GetItemInLimbSlot(InvSlotType.Headset)
    local rightHand = character.Inventory.GetItemInLimbSlot(InvSlotType.RightHand)
    local leftHand = character.Inventory.GetItemInLimbSlot(InvSlotType.LeftHand)
    local item = rightHand or leftHand

    if item and character.AnimController.IsAiming and (item.HasTag("megazoom") or item.HasTag("zoom") or item.HasTag("minizoom")) then
        if item.HasTag("megazoom") then
            Screen.Selected.Cam.OffsetAmount = lerp(Screen.Selected.Cam.OffsetAmount, 1000, 1.0)
        elseif item.HasTag("zoom") then
            Screen.Selected.Cam.OffsetAmount = lerp(Screen.Selected.Cam.OffsetAmount, 1000, 0.5)
        elseif item.HasTag("minizoom") then
            Screen.Selected.Cam.OffsetAmount = lerp(Screen.Selected.Cam.OffsetAmount, 1000, 0.12)
        end
    elseif headset and (headset.HasTag("zoom") or headset.HasTag("minizoom")) then
        if headset.HasTag("zoom") then
            Screen.Selected.Cam.OffsetAmount = lerp(Screen.Selected.Cam.OffsetAmount, 1000, 0.5)
        elseif headset.HasTag("minizoom") then
            Screen.Selected.Cam.OffsetAmount = lerp(Screen.Selected.Cam.OffsetAmount, 1000, 0.12)
        end
    end
end, Hook.HookMethodType.After)