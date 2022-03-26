require('lspsaga').init_lsp_saga{
  -- default value
  use_saga_diagnostic_sign = true,
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  code_action_icon = ' ',
  diagnostic_header_icon = '   ',
  finder_definition_icon = ' ',
  finder_reference_icon = ' ',
  code_action_prompt = {
    enable = true,
    sign = false,
    virtual_text = false,
  },
  code_action_keys = { quit = '<Esc>',exec = '<CR>' },
  finder_action_keys = {
    open = '<CR>', vsplit = 'v',split = 'h', quit = '<Esc>',scroll_down = '<C-f>', scroll_up = '<C-b>'
  },
  rename_prompt_prefix = '>',
  border_style = "round",
}
