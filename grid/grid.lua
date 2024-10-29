function(newPositions, activeRegions)
    -- 3 row config: limit=6, rows=3, spacing=4, total=17, rowPadding=3
    -- 4 row config: limit=6, rows=4, spacing=4, total=22, rowPadding=3
    local limit = 6 -- limit of icons per row (default: 6)
    local rows = 3 -- total rows (default: 3)
    local spacing = 4 -- spacing between icons (default: 4)
    local total = 17 -- how many icons in total you'd like (use #activeRegions for all) (default: 17)
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
    local rowCount = 1;
    local reduced = 0;
    
    local totalActiveIcons = 0
    for _ in pairs(activeRegions) do totalActiveIcons = totalActiveIcons + 1 end
    
    if totalActiveIcons > 22 then
        rowCount = 5
    elseif totalActiveIcons > 17 then
        rowCount = 4
    elseif totalActiveIcons > 11 then
        rowCount = 3
    elseif totalActiveIcons > 5 then
        rowCount = 2
    end
    
    if #activeRegions < total then
        missingIcons = total - #activeRegions; 
    end
    
    for i, regionData in ipairs(activeRegions) do
        -- first row has 5 and smaller spacing
        if yCount == 0 then
            limit = 5;
            spacing = 2.5;
        elseif yCount > 0 and yCount < 3 then
            limit = 6;
            spacing = 4;
        else
            limit = 5;
            spacing = 2.5;
        end
        
        -- check if missingIcons has a whole row in it        
        if (reduced == 0) and (missingIcons > limit) then
            missingIcons = missingIcons - limit;
            -- Only ever do this once
            reduced = 1
        end
        
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
        
        -- Apply a smaller size to the icons in the bottom row and larger to the top row
        -- NOTE: this just overwrites the actual aura so we need to set the others back to 40
        if yCount == 0 then
            activeRegions[i].region:SetRegionHeight(50);
            activeRegions[i].region:SetRegionWidth(50);
        elseif yCount > 1 then 
            activeRegions[i].region:SetRegionHeight(35);
            activeRegions[i].region:SetRegionWidth(35);
            -- If you have less icons than the total adjust their xOffset so they are centered
            if (yCount == rowCount-1) then
                missingPadding = missingIcons * 20;
            end
        else 
            activeRegions[i].region:SetRegionHeight(40);
            activeRegions[i].region:SetRegionWidth(40);
            if (yCount == rowCount-1) then
                missingPadding = missingIcons * 10;
            else
                missingPadding = 0;
            end
        end
        
        xOffset = 0 - (region.width + spacing) / 2 * (rowTotal-1) + (xCount * (region.width + spacing)) + missingPadding;
        yOffset = 0 - (region.height + spacing + rowPadding) * yCount -- change '-' to '+' after 0 to grow up instead of down
        
        -- Apply more padding between the 1st and 2nd rows to account for the resource bar
        if yCount > 0 then
            yOffset = yOffset - 26.5;
        end
        
        -- Apply an extra offset to everything after row 1
        if yCount > 1 then
            yOffset = yOffset - 4;
        end
        
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