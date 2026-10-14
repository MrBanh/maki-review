# maki-review

A `/review` command for maki: a TUI for reviewing working-tree changes vs
`HEAD`, leaving inline comments on diff lines, and sending them back to a new
maki session that fixes them.

Ported to a maki package from [maki-review](https://github.com/Asaf51/maki-review)
by Asaf51, with key handling updated to maki's canonical key spellings
(`<CR>`, `<Esc>`, `<Up>`, etc.).

## Features

- **Files** — changed files vs `HEAD` (staged, unstaged, untracked) as a collapsible tree
- **Commits** — recent commits; drill into a commit's files
- **Comments** — every review comment written so far
- **Diff pane** — syntax-highlighted diff with full-row tints; comment a line (`c`),
  select a range first (`v`), delete (`d`)
- **Submit** — `s` sends all comments to a new focused maki session that addresses them
- After each turn, a status flash reminds you when files changed

## Keys

Defaults (press `?` in the TUI for a popup that always reflects your config):

| Key                                   | Action                                 |
| ------------------------------------- | -------------------------------------- |
| `Tab` / `Shift+Tab`                   | cycle left panels forwards / backwards |
| `Enter` / `l`                         | open dir / focus diff / open commit    |
| `h` / `Esc`                           | collapse / back                        |
| `j` / `k`, `PgUp` / `PgDn`, `g` / `G` | move, page, jump to top / bottom       |
| `c`                                   | comment on the current diff line       |
| `v`                                   | start range selection                  |
| `d`                                   | delete comment                         |
| `s`                                   | submit comments to maki                |
| `r`                                   | refresh                                |
| `?`                                   | show keybinds                          |
| `q`                                   | quit                                   |

## Install

In your global `init.lua` (normally `~/.config/maki/init.lua`), declare the
package with
[`maki.pack.add`](https://maki.sh/docs/packages/#install-from-git):

```lua
maki.pack.add({
  {
    src = "https://github.com/MrBanh/maki-review",
  },
})
```

Maki shows one install prompt on the terminal before the UI starts and writes
the selected commit to `pack-lock.json` in your config directory — commit that
file to pin the same revision on other machines. See
[Lua packages](https://maki.sh/docs/packages/) for `version` pins,
`/packupdate`, and `/packdel`.

By hand instead: clone this repo into
`<maki-data>/site/pack/<group>/start/maki-review/` (any `<group>` except
`core`). A hand-placed copy loads with default options via its
`plugin/review.lua` entry.

## Configure

Pass options to `setup()`. Each action takes one key or a list of keys in
[maki key notation](https://maki.sh/docs/lua-api/#maki-keymap-normalize)
(`"?"`, `"<Tab>"`, `"<S-Tab>"`, `"<CR>"`, `"<C-n>"`, ...). Anything not listed
keeps its default. The `?` popup and the panel footers always show the
effective bindings.

```lua
require("review").setup({
  keymaps = {
    cycle_forwards  = "<Tab>",    -- cycle left panels forwards
    cycle_backwards = "<S-Tab>",  -- cycle left panels backwards
    help            = "?",
    open            = "<CR>",     -- open dir / focus diff / open commit
    collapse        = "h",        -- collapse dir / leave commit
    back            = "<Esc>",    -- back / close
    move_up         = "k",
    move_down       = "j",
    page_up         = "<PageUp>",
    page_down       = "<PageDown>",
    jump_top        = "g",
    jump_bottom     = "G",
    comment         = "c",
    range_select    = "v",
    delete_comment  = "d",
    submit          = "s",
    refresh         = "r",
    quit            = "q",
  },
})
```

`open`, `collapse`, `move_up`/`move_down`, `jump_top`/`jump_bottom`, and `quit`
also keep their built-in alternates (`l` / arrows / `Home` / `End` / `<C-c>`),
so navigation still works alongside your overrides.

With a managed install, `setup()` is called by the loader, so pass options via
a custom `load` function in your `init.lua`:

```lua
maki.pack.add({
  {
    src = "https://github.com/MrBanh/maki-review",
    data = {
      module = "review",
      keymaps = { comment = "C", quit = "X" },
    },
  },
}, {
  load = function(package)
    require(package.spec.data.module).setup(package.spec.data)
  end,
})
```
