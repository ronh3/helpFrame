helpFrame.helpSplash = {
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
}