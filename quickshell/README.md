# Quickshell / Omarchy

Snapshot of the user-owned Kanagawa bar configuration for Omarchy.

Included:

- `shell.json`: three grouped sections with the Kanagawa layout.
- `bar/scripts/scratchpad-status`: scratchpad indicator used by the bar.
- `plugins/charlieras262.floating-bar`: grouped capsule bar.
- `plugins/vlad.media`: Kanagawa-styled MPRIS widget.
- `plugins/vlad.workspaces`: focused-workspace styling.

The layout also expects these separately installed plugins: `davidjm.rain`,
`community.workspace-stage`, `io.github.devasstated.workspace-stash`,
`io.github.ricky.ghstats`, and `davidjm.scripture`.

## Restore

From the repository root:

```sh
cp ~/.config/omarchy/shell.json ~/.config/omarchy/shell.json.bak.$(date +%s)
mkdir -p ~/.config/omarchy/quickshell/bar/scripts ~/.config/omarchy/plugins
cp quickshell/shell.json ~/.config/omarchy/shell.json
cp quickshell/bar/scripts/scratchpad-status ~/.config/omarchy/quickshell/bar/scripts/
cp -a quickshell/plugins/. ~/.config/omarchy/plugins/
chmod +x ~/.config/omarchy/quickshell/bar/scripts/scratchpad-status
omarchy-shell shell rescanPlugins
omarchy restart shell
```
