# Spec'd ⚡

> ⚠️ Work in progress

<p align="center">
  <img src="assets/chad_specs.jpg" alt="Get Spec'd. Get Shit Done." width="700"/>
</p>

**Agentic spec-first development** — because great code starts with great specs (and you've got shit to do).

[![GitHub stars](https://img.shields.io/github/stars/MohamedAtta-AI/specd?style=social)](https://github.com/MohamedAtta-AI/specd)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

---

## What is Spec'd?

Spec'd is a set of AI agent skills for spec-first development. Instead of jumping straight to code, you run a short guided session that produces structured documentation — requirements, a roadmap, system design, and engineering standards. When you're ready to build a feature, a second skill turns that context into a precise, self-contained spec with interfaces and atomic tasks that agents can execute in parallel.

The skills are plain markdown files. They work with any agent tool that can read files and interact with users — Claude Code, Cursor, Codex, etc.

## The Core Phillosophy

Spec’d is designed with these principles in mind:

1. **Structured yet flexible requirements definition**:
   Establish a guided process for requirements elicitation and feature iteration, aligned with best practices from the Software Development Lifecycle (SDLC), while remaining adaptable to evolving product understanding.

2. **Maximized developer–agent alignment**:
   Unlike conventional frameworks, Spec’d does not assume users can fully articulate requirements upfront. Instead, it enforces an initial phase of targeted questioning and controlled recommendations, reducing ambiguity early. This improves alignment, preserves context efficiency, and enhances both agent performance and creative output.

3. **Minimized token overhead**:
   Rather than generating verbose, document-style outputs, Spec’d prioritizes concise, high-signal context optimized for agent execution. Formal documentation is treated as a downstream artifact, derived from the refined, structured knowledge produced by the framework.

4. **Upfront engineering alignment and parallel execution**:
  Following requirements elicitation, each feature is concretely defined with explicit contracts and interface boundaries. This enables safe parallelization across subagents, minimizing conflicts and rework. The process also yields high-quality engineering artifacts that support implementation, coordination, and future maintenance while discouraging vibe coding.

---

## How It Works

**Step 1 — Define your product** with `define-requirements`

A guided session that collects your problem, users, goals, constraints, tech stack, and standards. It synthesizes key use cases, proposes an MVP, and generates:

- `.specd/product/requirements.md`
- `.specd/product/roadmap.md`
- `.specd/product/system-design.md`
- `.specd/product/standards.md` _(if custom standards were specified)_

**Step 2 — Spec a feature** with `create-spec`

Reads your product docs silently, then asks only what it can't infer. Produces a spec folder for the feature containing interfaces (functions, API endpoints, data schemas) and atomic tasks with explicit dependency labels so subagents can run in parallel.

- `.specd/specs/YYYY-MM-DD--{feature-slug}/spec.md`
- `.specd/specs/YYYY-MM-DD--{feature-slug}/refs/` _(wireframes, API docs, etc.)_

**Step 3 — Implement**

Hand each task to an agent. Tasks are self-contained — each includes its goal, inputs, acceptance criteria, and relevant standards. Tasks labeled `[PARALLEL]` can run concurrently; tasks labeled `[AFTER: T-N]` declare their dependency explicitly.

---

## Skills

| Skill | File | Purpose |
|---|---|---|
| `define-requirements` | `define-requirements.md` | Requirements, roadmap, system design, standards |
| `create-spec` | `create-spec.md` | Feature spec with interfaces and atomic tasks |

---

## Installation

Clone the repo and run the install script. It auto-detects your installed tools and sets everything up.

```bash
git clone https://github.com/MohamedAtta-AI/specd.git
cd specd
bash install.sh
```

To install for specific tools only:

```bash
bash install.sh --claude        # Claude Code
bash install.sh --codex         # Codex CLI
bash install.sh --antigravity   # Antigravity
bash install.sh --cursor        # Cursor
bash install.sh --all           # All of the above
```

### What the installer does

| Tool | Where skills are installed | How to invoke |
|---|---|---|
| **Claude Code** | `~/.claude/commands/` | `/define-requirements`, `/create-spec` |
| **Codex CLI** | `~/.codex/skills/` | Agent triggers from description |
| **Antigravity** | `~/.gemini/antigravity/skills/` | Agent triggers from description |
| **Cursor** | `~/.cursor/rules/` | Agent triggers from description |

The global default `standards.md` is always installed to `~/.specd/standards.md` regardless of which tools you select.

---

## Project Structure

No manual setup needed per project. Skills create everything automatically.

```
your-project/
└── .specd/
    ├── product/                      ← generated by define-requirements
    │   ├── requirements.md
    │   ├── roadmap.md
    │   ├── system-design.md
    │   └── standards.md              ← project-level override (optional)
    └── specs/                        ← generated by create-spec
        └── YYYY-MM-DD--{feature}/
            ├── spec.md
            └── refs/                 ← wireframes, API docs, schemas
```
---

## 📄 License

This project is licensed under the terms of the [Apache 2.0](https://github.com/MohamedAtta-AI/specd/blob/main/LICENSE) open source license.
