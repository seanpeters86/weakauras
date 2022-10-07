-- yOffset = -299
function(newPositions, activeRegions)
    -- 2 row config: limit=6, rows=2, spacing=4, total=12, rowPadding=3
    -- 3 row config: limit=6, rows=3, spacing=4, total=17, rowPadding=3
    local limit = 6 -- limit of icons per row (default: 6)
    local rows = 2 -- total rows (default: 2)
    local spacing = 4 -- spacing between icons (default: 4)
    local total = 12 -- how many icons in total you'd like (use #activeRegions for all) (default: 12)
    local rowPadding = 3 -- padding between rows (default: 3)
    ----------------------
    local check = true
    local xCount = 0
    local yCount = 0
    local tCount = 0
    
    local xOffset = 0;
    local yOffset = 0;
    local missingIcons = 0;
    local missingPadding = 0;
    
    if #activeRegions < total then
        missingIcons = total - #activeRegions; 
    end
    
    
    for i, regionData in ipairs(activeRegions) do
        local region = regionData.region
        
        local regionsLeft = total - tCount
        local rowTotal = 1
        
        if total <= limit then
            rowTotal = total
        elseif (regionsLeft < limit and xCount < 1) or not check then
            check = false
            rowTotal = regionsLeft
        elseif yCount >= rows-1 then
            rowTotal = regionsLeft
        elseif total > limit then
            rowTotal = limit
        end
        
        -- Apply a smaller size to the icons in the bottom row
        -- NOTE: this just overwrites the actual aura so we need to set the others back to 40
        if yCount > 0 then   
            activeRegions[i].region:SetRegionHeight(35);
            activeRegions[i].region:SetRegionWidth(35);
            -- If you have less icons than the total adjust their xOffset so they are centered
            if yCount == rows-1 then
                missingPadding = missingIcons * 20;
            end
        else 
            activeRegions[i].region:SetRegionHeight(40);
            activeRegions[i].region:SetRegionWidth(40);
            missingPadding = 0;
        end
        
        
        xOffset = 0 - (region.width + spacing) / 2 * (rowTotal-1) + (xCount * (region.width + spacing)) + missingPadding;
        yOffset = 0 - (region.height + spacing + rowPadding) * yCount -- change '-' to '+' after 0 to grow up instead of down
        
        xCount = xCount + 1
        
        if yCount < rows-1 and check then
            tCount = tCount + 1
            if xCount >= limit then
                xCount = 0
                yCount = yCount + 1
            end
        end
        
        
        -- only display auras up to the total
        if i > total then
            break;
        end
        
        newPositions[i] = {xOffset, yOffset}
    end
end