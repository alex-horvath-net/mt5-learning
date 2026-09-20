# MT5 Learning Project

## Goal
The main business goal is to establish a working automated trading system on MT5.

Build toward this goal gradually, organically, iteratively, and incrementally, learning through working product increments.

Do not make unnecessary product, trading, risk, architecture, or automation decisions in advance.

Decisions should emerge only when the next product increment requires them.

## Learning and Evolving Guidance
- Learning trading concepts, terminology, and expressions is a secondary goal of building the system.
- The user is learning trading and may use imprecise wording. Explain the relevant terminology in plain language and clarify intent when ambiguity affects a decision; do not treat uncertain wording as a settled requirement.
- Teach concepts as they become relevant to the current increment, using concrete examples from the project. Keep explanations concise and proceed one step at a time.
- Refine this repository's `AGENTS.md` as understanding and agreed requirements evolve. Capture confirmed decisions, not assumptions; ask before changing product scope or trading safeguards.
- When a concrete need arises, suggest a subagent, skill, hook, or other agent customization and explain its purpose. Do not create or enable it without approval, or introduce it solely for hypothetical future needs.

## Business Requirement 0
Establish a professional foundation for learning and evolving the MT5 solution.

At this stage:
- no trading strategy is defined
- no risk model is defined
- no execution policy is defined
- no production architecture is fixed
- no automated trading behaviour is defined

## Product Increment 0
Create the smallest professional development foundation.

Current scope:
- local repository structure
- VS Code as the main editor
- MT5 / MetaEditor as runtime and compiler
- source code kept outside the MT5 data folder
- scripted deployment into MT5
- machine-specific configuration kept out of Git
- minimal EA compiles successfully
- no trading behaviour implemented

## Working Style
- Work in small increments.
- Prefer the smallest useful change.
- Do not overengineer.
- Do not introduce abstractions before they are needed.
- Do not invent requirements.
- Ask before introducing significant product or trading decisions.
- Keep each increment working before moving to the next one.

## Development Rules
- Repository files are the source of truth.
- Do not edit deployed MT5 files directly.
- Use automation for deployment and repeatable development tasks.
- Keep secrets and machine-specific configuration out of Git.
- Compile and verify changes before considering an increment complete.

## Deploy and Compile LearningEA

Run from the repository root in PowerShell. `config/local.ps1` supplies the
machine-specific `$Mt5DataPath`. The deployment script copies the EA and its
include files into that terminal's MQL5 folders.

Run the deployment and compilation script:

```powershell
.\scripts\deploy-and-compile.ps1
```

The script uses MetaEditor in the standard installation location under
`$env:ProgramFiles`. For another installation, pass `-MetaEditorPath` with its
local executable path. Do not commit machine-specific paths.

The script calls `scripts/deploy.ps1`, compiles the deployed EA with the terminal's
MQL5 folder as the include root, and saves a unique compiler log in `$env:TEMP`.
It requires `0 errors, 0 warnings` and a fresh, non-empty `.ex5` file, failing if
any check fails. It does not rely on MetaEditor's exit code alone, because a
verified successful compilation returned exit code `1`.

## AI Agent Rules
- Help evolve the product incrementally.
- Do not jump ahead.
- Do not assume future requirements.
- Do not introduce trading logic unless explicitly requested.
- Do not enable live trading unless explicitly requested.
- Prefer learning through working product increments over theoretical design.

## Communication
- Always be extremely concise when writing to the user, including progress updates and next-tool prompts. Give only essential information; avoid repetition and unsolicited detail. Keep necessary explanations and safety caveats brief.
- Temporarily omit the entire `Next tool:` footer and its follow-up prompt from all responses in this repository. Keep it disabled until the user changes this `AGENTS.md` rule again; a conversational request alone does not restore it.
- Prefer Codex for editing files, running commands, compiling, testing, and Git.
- Prefer GPT Chat for architecture, design decisions, reviews, explanations, and complex reasoning.
- When restored in this file, end responses with `Next tool: Codex` or `Next tool: GPT Chat`, followed immediately by a fenced text block containing a concrete, ready-to-use next-task prompt and relevant scope constraints.
