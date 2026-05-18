local function merge(dst, src)
  return vim.tbl_deep_extend("force", dst or {}, src)
end

return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    local readonly_view = vim.o.write == false and vim.bo.modifiable == false
    if not readonly_view then
      return
    end

    opts.picker = opts.picker or {}
    opts.picker.win = opts.picker.win or {}
    opts.picker.win.input = opts.picker.win.input or {}
    opts.picker.win.input.bo = merge(opts.picker.win.input.bo, {
      modifiable = true,
    })

    opts.picker.sources = opts.picker.sources or {}
    opts.picker.sources.explorer = opts.picker.sources.explorer or {}
    opts.picker.sources.explorer.win = opts.picker.sources.explorer.win or {}
    opts.picker.sources.explorer.win.list = opts.picker.sources.explorer.win.list or {}
    opts.picker.sources.explorer.win.list.keys = merge(opts.picker.sources.explorer.win.list.keys, {
      ["a"] = false,
      ["d"] = false,
      ["r"] = false,
      ["c"] = false,
      ["m"] = false,
      ["p"] = false,
    })
  end,
}
