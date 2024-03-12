--Creating namespace
helpFrame = helpFrame or {}

-- Determines the longest command length
function helpFrame.calculateLongestCommandLength(entries)
    local longestLength = 0
    for command, _ in pairs(entries) do
        longestLength = math.max(longestLength, #command)
    end
    return longestLength
end

-- Creates the header for the helpfile
function helpFrame.createHeader(name, borderC, headerFooterColor, totalWidth)
    local headerLine = string.format("#%s┌─#%s%s#%s─┐#r", borderC, headerFooterColor, name, borderC)
    local bottomLine = "#" .. borderC .. string.rep("─", totalWidth)
    local header = string.format("#%s\n%s\n%s#r", borderC, headerLine, bottomLine)
    hecho(header .. "\n")
end

-- Creates the footer for the helpfile
function helpFrame.createFooter(name, borderC, headerFooterColor, totalWidth)
    local topLine = "#" .. borderC .. string.rep("─", totalWidth)
    local paddingLength = totalWidth - #name - 4 -- 4 accounts for "└─" and "─┘"
    local footerLine = string.format("#%s└─#%s%s#%s─┘", borderC, headerFooterColor, name, borderC)
    local paddedFooterLine = string.rep(" ", paddingLength) .. footerLine
    local footer = string.format("#%s%s\n%s#r", borderC, topLine, paddedFooterLine)
    hecho(footer .. "\n")
end

-- Creates an entry for the helpfile
function helpFrame.addEntry(command, description, cmdColor, descColor, separatorPosition, totalWidth)
    local commandStyled = string.format("#%s%s#r", cmdColor, command)
    local descriptionStyled = string.format("#%s%s#r", descColor, description)
    local commandSpacing = string.rep(" ", separatorPosition - #command + 3) -- 3 spaces after the longest command
    local line = commandStyled .. commandSpacing .. "| " .. descriptionStyled
    hecho(line .. "\n")
end

-- Creates a standard line of text for the helpfile
function helpFrame.addLine(text, textColor, totalWidth)
    local formattedText = string.format("#%s%s#r", textColor, text)
    hecho(formattedText .. "\n")
end

-- Processes entries for the helpfile, either a single category or multiple categories
function helpFrame.processEntries(entries, config, categoryName)
    if categoryName then
        local categoryNameFormatted = string.format("#%s[%s]#r", config.categoryColor, categoryName)
        hecho(categoryNameFormatted .. "\n")
    end

    local longestCommandLength = helpFrame.calculateLongestCommandLength(entries)
    local separatorPosition = longestCommandLength + 3 -- Three spaces after the longest command

    for key, value in pairs(entries) do
        if key == "addLine" then
            -- If the entry is specifically for adding a line of text, call addLine
            helpFrame.addLine(value, config.descriptionColor, config.width)
        else
            -- Otherwise, process as a command/description pair
            helpFrame.addEntry(key, value, config.commandColor, config.descriptionColor, separatorPosition, config.width)
        end
    end
    -- Optionally, print a separator or blank line after the entries for visual separation
    --echo("\n")
end

-- Pulls it all together, and creates and displays the helpfile/table.
function helpFrame.createHelp(helpData)
    local config = helpData.config
    if config.headerName then
        helpFrame.createHeader(config.headerName, config.borderColor, config.headerFooterColor, config.width)
    end
    local hasCategories = helpData.categories ~= nil
    if hasCategories then
        for categoryName, commands in pairs(helpData.categories) do
            helpFrame.processEntries(commands, config, categoryName)
        end
    else
        helpFrame.processEntries(helpData.entries, config)
    end
    helpFrame.createFooter(config.footerName, config.borderColor, config.headerFooterColor, config.width)
end


--Structured help file table example, no categories
--[[     helpFrame.sampleHelp1 = {
    config = {
        headerName = "Sample Commands", -- The text you want to have appear in the top tab
        footerName = "helpFrame", -- The text you want to have appear in the footer tab
        borderColor = "00557F", -- The color of the border work, given in hexadecimal
        commandColor = "B1D4E0", -- The color of the command/left entry given in hexadecimal
        descriptionColor = "FFFFFF", -- The folor of the description/right entry given in hexadecimal
        headerFooterColor = "F0F0F0", -- New color for header/footer text
        width = 100 -- How wide you want the file/table to be. If not set, will default to mudlet's main window width
    },
    entries = {
        ["helpFrame"] = "This will display the help file for helpFrame!",
        ["helpDesk"] = "This will display the help file for the made up item helpDesk!",
        -- Add more entries as needed
    }
} ]]

--Structured help file table example, with categories
--[[ helpFrame.sampleHelp2 = {
    config = {
        headerName = "Sample Commands", -- The text you want to have appear in the top tab
        footerName = "helpFrame", -- The text you want to have appear in the footer tab
        borderColor = "00557F", -- The color of the border work, given in hexadecimal
        commandColor = "B1D4E0", -- The color of the command/left entry given in hexadecimal
        descriptionColor = "FFFFFF", -- The color of the description/right entry given in hexadecimal
        headerFooterColor = "F0F0F0", -- The color of the header/footer text given in hexadecimal
        categoryColor = "FFD700", -- The color of the category name given in hexadecimal
        width = 100 -- How wide you want the file/table to be. If not set, will default to mudlet's main window width
    },
    categories = {
        Category1 = {
            ["helpFrame"] = "This will display the help file for helpFrame!",
            ["helpDesk"] = "This will display the help file for the made up item helpDesk!",
            ["addLine"] = "This is just a line, no commands here."
            -- Add more entries as needed
        },
        Category2 = {
            ["helpFrames"] = "This will display the help file for helpFrames!",
            ["helpDesks"] = "This will display the help file for the made up item helpDesks!",
            -- Add more entries as needed
        },
    }
} ]]