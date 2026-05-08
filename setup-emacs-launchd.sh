#!/bin/bash
set -euo pipefail

required_vars=(
  EMACS_BIN
  EMACS_ORG_DIR
  EMACS_ORG_ROAM_DIR
  EMACS_ICLOUD_ORG_DIR
)

for var in "${required_vars[@]}"; do
  if [[ -z "${!var:-}" ]]; then
    echo "Error: environment variable $var is not set" >&2
    exit 1
  fi
done

PLIST_PATH="$HOME/Library/LaunchAgents/gnu.emacs.daemon.plist"

cat > "$PLIST_PATH" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>gnu.emacs.daemon</string>
    <key>ProgramArguments</key>
    <array>
        <string>${EMACS_BIN}</string>
        <string>--fg-daemon</string>
    </array>
    <key>ProcessType</key>
    <string>Interactive</string>
    <key>EnvironmentVariables</key>
    <dict>
        <key>PATH</key>
        <string>${PATH}</string>
        <key>COLORTERM</key>
        <string>truecolor</string>
        <key>EMACS_ORG_DIR</key>
        <string>${EMACS_ORG_DIR}</string>
        <key>EMACS_ORG_ROAM_DIR</key>
        <string>${EMACS_ORG_ROAM_DIR}</string>
        <key>EMACS_ICLOUD_ORG_DIR</key>
        <string>${EMACS_ICLOUD_ORG_DIR}</string>
    </dict>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/emacs-daemon.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/emacs-daemon.log</string>
</dict>
</plist>
EOF

echo "Generated: $PLIST_PATH"
echo ""
echo "To reload the daemon:"
echo "  launchctl unload $PLIST_PATH"
echo "  launchctl load   $PLIST_PATH"
