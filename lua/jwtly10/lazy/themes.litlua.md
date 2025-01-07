<!-- @pragma output:themes.lua -->
<!-- @pragma force:true -->

# How you feeling today?
```lua
local feeling = "happy"  -- you can change this to "sad" or anything else
```


## Neovim theme config
Since everything just gets transpiled to Lua, you can have dynamic configuration
as well!

### One Dark
https://github.com/olimorris/onedarkpro.nvim
```lua
return {
{
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
        if feeling == "happy" then
            vim.cmd("colorscheme onedark")
        end
    end
},
```
### Nord
https://github.com/gbprod/nord.nvim
```lua
{
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        if feeling == "sad" then
            vim.cmd("colorscheme nord")
       end
        if feeling ~= "sad" and feeling ~= "happy" then
            print("What is happy then", feeling)
            vim.cmd("colorscheme default")
        end
    end
}
}
```
