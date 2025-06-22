require("nvim-navic").setup({
  highlight = true,
  separator = " > ",
  depth_limit = 5,
  icons = {
    File          = " ",
    Module        = " ",
    Namespace     = " ",
    Package       = " ",
    Class         = " ",
    Method        = " ",
    Property      = " ",
    Field         = " ",
    Constructor   = " ",
    Enum          = " ",
    Interface     = " ",
    Function      = " ",
    Variable      = " ",
    Constant      = " ",
    String        = " ",
    Number        = " ",
    Boolean       = " ",
    Array         = " ",
    Object        = " ",
    Key           = " ",
    Null          = " ",
    EnumMember    = " ",
    Struct        = " ",
    Event         = " ",
    Operator      = " ",
    TypeParameter = " "
  }
})

-- Setup winbar to show breadcrumbs
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
