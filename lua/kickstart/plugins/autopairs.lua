-- autopairs
-- https://github.com/windwp/nvim-autopairs

---@module 'lazy'
---@type LazySpec
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    local npairs = require('nvim-autopairs')
    npairs.setup {}

    -- Disable ' auto-pairing in lisp-family languages where ' is quote, not a string delimiter
    local cond = require('nvim-autopairs.conds')
    local lisp_fts = { 'racket', 'scheme', 'lisp', 'clojure', 'fennel' }
    for _, rule in ipairs(npairs.get_rules("'")) do
      rule:with_pair(cond.not_filetypes(lisp_fts))
    end

    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
