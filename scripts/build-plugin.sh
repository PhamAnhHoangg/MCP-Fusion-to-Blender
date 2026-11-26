#!/usr/bin/env bash
# Builds dist/<name>.plugin (a zip) from this repo.
set -euo pipefail
cd "$(dirname "$0")/.."
name=$(python3 -c 'import json;print(json.load(open(".claude-plugin/plugin.json"))["name"])')
mkdir -p dist
rm -f "dist/$name.plugin"
zip -r -q "dist/$name.plugin" .claude-plugin skills .mcp.json README.md CHANGELOG.md -x "*.DS_Store"
echo "Built dist/$name.plugin"
