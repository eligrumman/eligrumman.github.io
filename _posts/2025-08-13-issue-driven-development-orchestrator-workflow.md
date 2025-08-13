---
layout: single
title: "Issue-Driven Development: The Orchestrator Pattern That Changed How I Code with AI"
date: 2025-08-13
categories: [development, ai-tools, workflow]
tags: [claude-code, orchestrator-pattern, issue-driven-development, ai-agents]
excerpt: "How I stopped fighting with AI code generation and started shipping complete features. A technical deep-dive into the orchestrator + sub-agents workflow that turns GitHub issues into merged PRs."
header:
  teaser: /assets/images/orchestrator-workflow.png
---

I used to waste hours fixing AI-generated code that didn't quite fit my codebase. Then I discovered a pattern that changed everything: treating Claude Code as an orchestrator that delegates to specialized agents, following a strict issue-to-PR workflow. Here's the system that now powers my entire development process.

## The Problem with Direct AI Coding

Most developers use AI tools like this:
1. Ask for code
2. Get something that mostly works
3. Spend time fixing integration issues
4. Debug why tests are failing
5. Manually create commits and PRs

This approach treats AI as a code generator, not a development partner. The orchestrator pattern flips this completely.

## The Orchestrator Pattern

Instead of you managing the AI, the AI orchestrator manages specialized sub-agents:

```yaml
Orchestrator (Project Manager):
  - Breaks down GitHub issues
  - Assigns work to specialists
  - Enforces process and standards
  - Reviews architecture decisions
  - Never writes code directly

Sub-Agents (Specialists):
  - frontend-developer: React, UI components
  - backend-architect: APIs, database design
  - test-automator: Unit/integration tests
  - code-reviewer: Architecture, security
  - python-pro, javascript-pro, etc.: Language experts
```

## Real Example: From Issue to Merged PR

Let me show you an actual issue from this blog's development:

### Step 1: Create the Issue

```bash
gh issue create --title "Add dark mode toggle to blog" \
  --body "Add a user-accessible dark mode toggle that persists across sessions" \
  --label "enhancement"
```

### Step 2: Orchestrator Takes Over

The orchestrator immediately:
1. Analyzes the codebase structure
2. Creates a task breakdown
3. Assigns specialized agents
4. Manages the entire workflow

Here's what actually happens:

```markdown
## Orchestrator Plan (Issue #3)

Tasks identified:
1. Research existing theme implementation
2. Design dark mode CSS variables
3. Implement toggle component
4. Add persistence logic
5. Test across browsers
6. Create PR with tests

Delegating to:
- search-specialist: Find theme files
- frontend-developer: Create toggle component
- test-automator: Write tests
- code-reviewer: Final review
```

### Step 3: Two-Stage Review Process

**Stage 1 - Implementation (Draft PR):**

```bash
# Orchestrator creates branch
git checkout -b issue-3-dark-mode

# Frontend agent implements
# Test agent adds tests
# Creates draft PR
gh pr create --draft --title "WIP: Add dark mode toggle" \
  --body "Implementation for #3"

# Code reviewer checks architecture
# Fixes applied by original agents
```

**Stage 2 - Final Review:**

```bash
# Convert to ready PR
gh pr ready

# Final review passes
# Orchestrator comments: "Implementation and tests approved, please merge @user"
```

## The Actual Workflow File

Here's a simplified version of my `CLAUDE.md` orchestrator configuration:

```markdown
# Orchestrator Rules

## Branch Management
- Always branch from fresh main
- One issue = one PR
- Never mix concerns

## Delegation Pattern
When user provides issue number:
1. Read issue completely
2. Search codebase for context
3. Create execution plan
4. Delegate to specialists
5. Never implement directly

## Review Stages
Stage 1 (Draft):
- Implementation by specialist
- Architecture review
- Fix cycles until clean

Stage 2 (Ready):
- Add comprehensive tests
- Final review
- Request merge

## Definition of Done
✓ Tests passing
✓ Linter clean
✓ Patterns matched
✓ AC met exactly
✓ No scope creep
```

## Practical Benefits I've Measured

### Before Orchestrator Pattern
- 15-20 prompts per feature
- 2-3 hours debugging integration
- 40% of generated code needed significant rework
- Manual PR creation and management

### After Orchestrator Pattern
- 1 issue = complete implementation
- 10-15 minutes from issue to draft PR
- 95% of code follows existing patterns perfectly
- Automated PR workflow with proper reviews

## Getting Started

### 1. Create Your CLAUDE.md

Place in `~/.claude/CLAUDE.md` for global or `./CLAUDE.md` for project-specific:

```markdown
# Project Orchestrator Configuration

## Available Agents
- frontend-developer
- backend-architect
- test-automator
- code-reviewer
- [language]-pro agents

## Workflow
1. Issue first (mandatory)
2. Branch from main
3. Draft PR → Review → Ready PR
4. Tests required
5. Merge only when approved
```

### 2. Your First Orchestrated Issue

```bash
# Create issue
gh issue create --title "Add user authentication" \
  --body "Implement JWT-based auth with login/logout"

# Tell Claude Code
"Orchestrator: implement issue #1"

# Watch the magic happen
```

### 3. Advanced Patterns

**Parallel Development:**
```bash
# Multiple issues simultaneously
git worktree add ../feature-1 issue-1-auth
git worktree add ../feature-2 issue-2-payments

# Orchestrator handles each independently
```

**Complex Features:**
```markdown
For issue #5 (microservice refactor):
- Stage 1: Architecture review only
- Stage 2: Service extraction
- Stage 3: Migration plan
- Stage 4: Implementation per service
```

## Common Objections Addressed

**"This seems like overkill for simple changes"**

The orchestrator scales down perfectly. A typo fix:
1. Create issue
2. Orchestrator identifies as trivial
3. Single agent fixes
4. PR created
5. Done in under 60 seconds

**"What about creative problem-solving?"**

The orchestrator enhances creativity by removing mechanical tasks. You focus on architecture and requirements while agents handle implementation details.

**"How is this different from just using agents directly?"**

Separation of concerns. The orchestrator maintains project standards while agents focus on their specialties. This prevents the common problem of AI-generated code that works but doesn't fit your codebase.

## The Unexpected Benefits

### 1. Self-Documenting Development
Every feature has:
- GitHub issue with requirements
- PR with implementation details
- Review comments explaining decisions
- Test cases documenting behavior

### 2. Consistent Code Quality
The orchestrator enforces:
- Existing patterns
- Code style
- Test coverage
- Review standards

### 3. Reduced Cognitive Load
You think about "what" not "how":
- What should this feature do?
- What are the edge cases?
- What's the user experience?

Implementation details are handled systematically.

## Real Results from This Blog

This blog post itself was created using the orchestrator workflow:
- Issue #3 created with blog requirements
- Orchestrator delegated to content-marketer
- Code examples from actual usage
- Review by code-reviewer for technical accuracy
- PR created with proper review stages

The previous post about Claude Code pricing? Same workflow. Every feature on this site? Same workflow.

## Start Today

1. Copy the workflow configuration to your `CLAUDE.md`
2. Create your first GitHub issue
3. Tell Claude Code: "Orchestrator: implement issue #1"
4. Watch your development process transform

The orchestrator pattern isn't just about automation—it's about systematic, high-quality development where AI handles the implementation while you focus on what matters: solving problems for your users.

---

*Want to see this workflow in action? Check out the [GitHub repo](https://github.com/eligrumman/eligrumman.github.io) for this blog where every PR follows this pattern.*

## Resources

- [Full orchestrator configuration example](https://gist.github.com/eligrumman/orchestrator-claude-md)
- [Claude Code documentation](https://docs.anthropic.com/claude-code)
- [GitHub CLI for issue-driven development](https://cli.github.com/)