local actions = require'distant.nav.actions'

require'distant'.setup {
  ['linux.student.cs.uwaterloo.ca'] = {
    launch = {
      distant = '/u6/mmashhud/.local/bin/distant',
    }
  },
  ['*'] = {
    launch = {
      extra_server_args = '"--shutdown-after 30"',
    },
    file = {
      mappings = {
        ['-']         = actions.up,
      },
    },
    dir = {
      ['<Return>'] = actions.edit,
      ['-'] = actions.up,
      ['A'] = actions.mkdir,
      ['a'] = actions.newfile,
      ['R'] = actions.rename,
      ['d'] = actions.remove,
    }
  },
}
