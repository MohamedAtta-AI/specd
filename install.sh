#!/usr/bin/env bash
# Spec'd Installer
# Usage: bash install.sh [--claude] [--codex] [--antigravity] [--cursor] [--all]
# With no flags, auto-detects installed tools.

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_DIR="$HOME/.specd"

BOLD='\033[1m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RESET='\033[0m'

h1()   { echo -e "\n${BOLD}$1${RESET}"; }
ok()   { echo -e "  ${GREEN}✓${RESET}  $1"; }
info() { echo -e "  ${BLUE}→${RESET}  $1"; }
warn() { echo -e "  ${YELLOW}!${RESET}  $1"; }

# Prepend YAML frontmatter to a skill file and write it to a destination
make_skill() {
  local dest="$1" name="$2" description="$3"
  mkdir -p "$(dirname "$dest")"
  {
    printf -- "---\nname: %s\ndescription: \"%s\"\n---\n\n" "$name" "$description"
    cat "$REPO_DIR/$name.md"
  } > "$dest"
}

# ─── Header ──────────────────────────────────────────────────────────────────

echo ""
echo -e "${BOLD}Spec'd Installer${RESET}"
echo "────────────────────────────────────────────────"

# ─── Global files ─────────────────────────────────────────────────────────────

h1 "Global"
mkdir -p "$GLOBAL_DIR"
cp "$REPO_DIR/standards.md" "$GLOBAL_DIR/standards.md"
ok "~/.specd/standards.md  (global default standards)"

# ─── Tool selection ───────────────────────────────────────────────────────────

INSTALL_CLAUDE=false
INSTALL_CODEX=false
INSTALL_ANTIGRAVITY=false
INSTALL_CURSOR=false

# Parse flags
for arg in "$@"; do
  case $arg in
    --claude)      INSTALL_CLAUDE=true ;;
    --codex)       INSTALL_CODEX=true ;;
    --antigravity) INSTALL_ANTIGRAVITY=true ;;
    --cursor)      INSTALL_CURSOR=true ;;
    --all)         INSTALL_CLAUDE=true; INSTALL_CODEX=true; INSTALL_ANTIGRAVITY=true; INSTALL_CURSOR=true ;;
  esac
done

# Auto-detect if no flags were passed
if ! $INSTALL_CLAUDE && ! $INSTALL_CODEX && ! $INSTALL_ANTIGRAVITY && ! $INSTALL_CURSOR; then
  h1 "Auto-detecting installed tools"
  [ -d "$HOME/.claude" ]                   && INSTALL_CLAUDE=true      && info "Claude Code detected"
  [ -d "$HOME/.codex" ]                    && INSTALL_CODEX=true       && info "Codex CLI detected"
  [ -d "$HOME/.gemini/antigravity" ]       && INSTALL_ANTIGRAVITY=true && info "Antigravity detected"
  [ -d "$HOME/.cursor" ]                   && INSTALL_CURSOR=true      && info "Cursor detected"

  if ! $INSTALL_CLAUDE && ! $INSTALL_CODEX && ! $INSTALL_ANTIGRAVITY && ! $INSTALL_CURSOR; then
    warn "No supported tools detected."
    echo ""
    echo "  Run with explicit flags to install anyway:"
    echo "    bash install.sh --claude --codex --antigravity --cursor"
    echo "    bash install.sh --all"
    echo ""
    exit 0
  fi
fi

# ─── Claude Code ──────────────────────────────────────────────────────────────

if $INSTALL_CLAUDE; then
  h1 "Claude Code"
  COMMANDS_DIR="$HOME/.claude/commands"
  mkdir -p "$COMMANDS_DIR"
  cp "$REPO_DIR/define-requirements.md" "$COMMANDS_DIR/define-requirements.md"
  cp "$REPO_DIR/create-spec.md"         "$COMMANDS_DIR/create-spec.md"
  ok "Slash commands installed to ~/.claude/commands/"
  info "Usage: /define-requirements  and  /create-spec"
fi

# ─── Codex CLI ────────────────────────────────────────────────────────────────

if $INSTALL_CODEX; then
  h1 "Codex CLI"
  make_skill \
    "$HOME/.codex/skills/define-requirements/SKILL.md" \
    "define-requirements" \
    "Define product requirements, roadmap, system design, and engineering standards through a guided session"
  make_skill \
    "$HOME/.codex/skills/create-spec/SKILL.md" \
    "create-spec" \
    "Create a self-contained feature spec with interfaces and atomic tasks for parallel agent execution"
  ok "Skills installed to ~/.codex/skills/"
fi

# ─── Antigravity ──────────────────────────────────────────────────────────────

if $INSTALL_ANTIGRAVITY; then
  h1 "Antigravity"
  make_skill \
    "$HOME/.gemini/antigravity/skills/define-requirements/SKILL.md" \
    "define-requirements" \
    "Define product requirements, roadmap, system design, and engineering standards through a guided session"
  make_skill \
    "$HOME/.gemini/antigravity/skills/create-spec/SKILL.md" \
    "create-spec" \
    "Create a self-contained feature spec with interfaces and atomic tasks for parallel agent execution"
  ok "Skills installed to ~/.gemini/antigravity/skills/"
fi

# ─── Cursor ───────────────────────────────────────────────────────────────────

if $INSTALL_CURSOR; then
  h1 "Cursor"
  CURSOR_RULES_DIR="$HOME/.cursor/rules"
  mkdir -p "$CURSOR_RULES_DIR"

  {
    printf -- "---\ndescription: \"Define product requirements, roadmap, system design, and engineering standards. Invoke when the user asks to define requirements or start spec-driven development.\"\nalwaysApply: false\n---\n\n"
    cat "$REPO_DIR/define-requirements.md"
  } > "$CURSOR_RULES_DIR/specd-define-requirements.mdc"

  {
    printf -- "---\ndescription: \"Create a feature spec with interfaces and atomic tasks for parallel agent execution. Invoke when the user asks to spec or plan a feature.\"\nalwaysApply: false\n---\n\n"
    cat "$REPO_DIR/create-spec.md"
  } > "$CURSOR_RULES_DIR/specd-create-spec.mdc"

  ok "Rules written to ~/.cursor/rules/"
  warn "Cursor's global rules are UI-managed. If these aren't picked up automatically:"
  info "Cursor Settings → Rules for AI → paste the content of each .mdc file"
fi

# ─── Done ─────────────────────────────────────────────────────────────────────

echo ""
echo "────────────────────────────────────────────────"
echo -e "${BOLD}${GREEN}Done.${RESET}"
echo ""
echo "  Global standards  →  ~/.specd/standards.md"
echo "  Per-project docs  →  .specd/product/   (created on first run)"
echo "  Feature specs     →  .specd/specs/     (created on first run)"
echo ""
echo "  Open a project and run define-requirements to get started."
echo ""
