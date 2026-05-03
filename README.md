# homebrew-ports-cli

Homebrew tap for [`ports`](https://github.com/erdemylmaz/ports-cli) — a small
macOS CLI that shows which ports are listening, which project each one
belongs to, lets you kill them by port number, and can keep long-running
dev servers or AI-agent workflows awake with macOS `caffeinate`. It can also
find local Codex, Claude Code, and Gemini app/agent/session PIDs that do not
bind a port, plus Cursor process groups when you want to keep an AI IDE awake.
`--follow` can keep newly spawned matching agent children awake too.

## Install

```sh
brew tap erdemylmaz/ports-cli
brew install ports
```

That's it. `ports --help` for usage.

## Caffeinate / keep awake

`ports caffeinate` resolves a port to its owning PID and starts macOS's own
`/usr/bin/caffeinate -dimsu -w <pid>` watcher in the background. `ports`
then shows the watcher in the `CAFFEINATE` column.

```sh
ports caffeinate 3000                 # keep the process on :3000 awake
ports --caffeinate 12345              # keep a PID awake directly
ports caffeinate --dir ~/code/agent   # keep project listeners awake
ports caffeinate --dir ~/code/agent --strict-dir
                                      # skip shared PIDs that cross projects
ports --find codex "claude code" gemini
                                      # find AI app/agent/session PIDs
ports caffeinate codex                # keep matching Codex processes awake
ports caffeinate codex --dir ~/code/agent --strict-dir --follow
                                      # keep future Codex children in that project awake
ports caffeinate --find cursor        # explicit AI selector
ports caffeinate --pid 93633          # keep an exact PID awake
ports uncaffeinate 3000               # stop watcher, keep process running
ports decaffeinate                    # stop all caffeinate watchers found
```

Useful for Claude Code, Codex, local AI agents, Vite/Next.js previews,
API stacks, tunnels, and background tool servers. For lid-closed runs, keep
the Mac on power in a supported clamshell setup; `caffeinate` prevents idle
sleep while macOS permits it, but it does not bypass every closed-lid sleep
rule.

`ports find` / `ports --find` prints identity, role, workspace/CWD, age,
listener ports, caffeinate watcher PIDs, parent chain, and the exact
`ports caffeinate --pid <PID>` / `ports uncaffeinate --pid <PID>` commands.
Use `--verbose` for the full session detail. The same AI names can be used
directly with `ports caffeinate <name>` or `ports uncaffeinate <name>`:
`codex`, `"claude code"`, `gemini`, `cursor`, or `ai`.

With `--follow`, `ports` starts a small background watcher that keeps rescanning
the same selector and attaches `/usr/bin/caffeinate -w <pid>` to new matches.
Combine AI names with `--dir` to constrain matches to a project workspace. Run
`ports decaffeinate <selector> --follow` to stop both current PID watchers and
the follow watcher. Run `ports decaffeinate` with no target to stop every active
caffeinate watcher discovered on the machine, even if it was started manually.

`--strict-dir` is intentionally conservative. macOS caffeinate works at PID
scope, so if one shared PID owns listeners in multiple project directories,
`--strict-dir` skips that PID instead of pretending it can caffeinate only
selected ports inside it.

## Update

```sh
brew update
brew upgrade ports
```

## Uninstall

```sh
brew uninstall ports
brew untap erdemylmaz/ports-cli
```

## License

The formula is MIT (matches the upstream project).
