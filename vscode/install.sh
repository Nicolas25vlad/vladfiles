#!/usr/bin/env bash
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
install_root="${HOME}/.vladfiles/vscode"
user_dir="${VSCODE_USER_DIR:-${HOME}/.config/Code/User}"
backup_dir="${user_dir}/backups/vladfiles-$(date +%Y%m%d-%H%M%S)"

command -v code >/dev/null 2>&1 || { echo "O comando code não foi encontrado no PATH." >&2; exit 1; }
mkdir -p "${install_root}/css" "${install_root}/assets" "${backup_dir}"
cp -f "${repo}/css/"* "${install_root}/css/"
cp -f "${repo}/assets/wallpaper.jpg" "${install_root}/assets/wallpaper.jpg"

while IFS= read -r id; do
    [[ -z "${id}" || "${id}" == \#* ]] && continue
    code --install-extension "${id}" --force
done < "${repo}/config/extensions.txt"

python3 - "${repo}/config/settings.json" "${user_dir}/settings.json" "${install_root}" <<'PY'
import json
import pathlib
import shutil
import sys
from datetime import datetime

template_path, target_path, install_root = map(pathlib.Path, sys.argv[1:])
target_path.parent.mkdir(parents=True, exist_ok=True)
template = json.loads(template_path.read_text(encoding="utf-8"))
settings = template
if target_path.exists():
    backup = target_path.parent / "backups" / f"vladfiles-{datetime.now():%Y%m%d-%H%M%S}" / target_path.name
    backup.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(target_path, backup)
    try:
        settings = json.loads(target_path.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        print("Aviso: settings.json local inválido; o template será usado.")
for key, value in template.items():
    settings[key] = value
settings["vscode_custom_css.imports"] = [
    (install_root / "css" / name).as_uri()
    for name in ("liquid-glass-custom.css", "statusbar-minimal.css", "liquid-glass-motion.css")
]
settings["liquidGlass.wallpaperPath"] = str(install_root / "assets" / "wallpaper.jpg")
target_path.write_text(json.dumps(settings, indent=4, ensure_ascii=False) + "\n", encoding="utf-8")
PY

if [[ -f "${user_dir}/keybindings.json" ]]; then
    cp -f "${user_dir}/keybindings.json" "${backup_dir}/keybindings.json"
fi
cp -f "${repo}/config/keybindings.json" "${user_dir}/keybindings.json"
echo "VS Code configurado. Backup: ${backup_dir}"
