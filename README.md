# homebrew-ports-cli

Homebrew tap for [`ports`](https://github.com/erdemylmaz/ports-cli) — a small
macOS CLI that shows which ports are listening, which project each one
belongs to, lets you kill them by port number, and can keep long-running
dev servers or AI-agent workflows awake with macOS `caffeinate`.

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
ports uncaffeinate 3000               # stop watcher, keep process running
```

Useful for Claude Code, Codex, local AI agents, Vite/Next.js previews,
API stacks, tunnels, and background tool servers. For lid-closed runs, keep
the Mac on power in a supported clamshell setup; `caffeinate` prevents idle
sleep while macOS permits it, but it does not bypass every closed-lid sleep
rule.

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
