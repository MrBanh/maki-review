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

| Key | Action |
| --- | --- |
| `Tab` | cycle left panels |
| `Enter` / `l` | open dir / focus diff / open commit |
| `h` / `Esc` | collapse / back |
| `c` | comment on the current diff line |
| `v` | start range selection |
| `d` | delete comment |
| `s` | submit comments to maki |
| `r` | refresh |
| `q` | quit |

## Install

Install as a maki package (e.g. via `maki.pack.add`), or copy
`plugin/review.lua` and `lua/review/` into your maki plugins directory.
