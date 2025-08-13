---
layout: single
title: "A Personal Experiment: Orchestrating AI Agents for Development"
date: 2025-08-13
categories: [development, ai-tools, workflow]
tags: [claude-code, orchestrator-pattern, issue-driven-development, ai-agents]
excerpt: "My experience building a structured approach to AI-assisted development. What works, what doesn't, and honest limitations of trying to systematize AI code generation."
header:
  teaser: /assets/images/orchestrator-workflow.png
---

I've been experimenting with treating Claude Code as an orchestrator that delegates to specialized agents rather than asking it to code directly. This post documents what I've learned from implementing this approach on a small personal project (this blog), including the configuration, workflow, and honest assessment of where it works and where it falls short.

**Important caveat**: This is a personal experiment on a simple blog codebase. I don't have metrics from large teams or complex production systems. The patterns described here may not scale beyond hobby projects.

## The Problem I Was Trying to Solve

When I ask Claude Code directly for code changes, I often get solutions that:
- Work in isolation but don't match my existing patterns
- Break things I forgot to mention in my prompt
- Require multiple back-and-forth iterations to get right
- Miss edge cases or testing requirements

I don't have precise metrics on this (I wasn't tracking before the experiment), but subjectively it felt inefficient. The core issue seemed to be that AI lacks persistent context about my project's conventions and architectural decisions.

## Technical Implementation: What "Orchestration" Actually Means

Rather than asking Claude Code directly for solutions, I structure interactions through role-based prompting with enforced constraints.

### Prompt Structure
```markdown
# Orchestrator role prompt
You are acting as a project orchestrator. Your constraints:
- NEVER write code directly
- Break down requirements into discrete tasks
- Delegate each task to appropriate specialist
- Enforce two-stage review (Draft PR → Ready PR)
- Ensure each task has clear acceptance criteria

# Specialist role prompt (example)
You are acting as a frontend-developer specialist. Your constraints:
- ONLY work on UI/CSS/JavaScript implementation
- Must match existing patterns in codebase
- Add tests for new components
- Create draft PR when complete
```

### Actual Workflow Implementation
```bash
# My current process (from CLAUDE.md):
1. Create GitHub issue with requirements
2. Prompt: "Acting as orchestrator, implement issue #N"
3. Claude analyzes issue, creates task breakdown
4. For each task: "Acting as [specialist], implement task X"
5. Each specialist uses constrained tool set (Read/Edit/Grep only)
6. Orchestrator reviews output, requests fixes
7. Final review before marking PR ready
```

### Why This Might Work
The role constraints force more systematic thinking:
- **Orchestrator** can't shortcut to implementation
- **Specialists** can't expand scope beyond their domain
- **Two-stage review** catches integration issues early

This is essentially structured prompting with artificial constraints, not true multi-agent orchestration.

## Example: Creating This Blog Post

To demonstrate how this actually works, here's what happened when creating this post:

### The Issue
I created [GitHub issue #3](https://github.com/eligrumman/eligrumman.github.io/issues/3) asking for a blog post about the orchestrator workflow.

### What Actually Happened
1. **Planning**: I (acting as orchestrator) broke down the task:
   - Research existing CLAUDE.md configuration
   - Draft blog post content
   - Add code examples
   - Create PR for review

2. **Implementation**: I delegated to myself (wearing different "agent" hats):
   - Content creation for blog structure
   - Technical writing for code examples
   - Editing for flow and clarity

3. **Reality Check**: This is still me doing all the work, just with more structure.

### What This Actually Demonstrates
- The workflow forces me to think through requirements before coding
- Breaking tasks into stages helps avoid missed steps
- The two-stage PR process (Draft → Ready) creates natural review checkpoints
- But it's still fundamentally one person following a checklist

### Limitations of This Example
- No real agent delegation (it's all me)
- Simple content creation, not complex software
- No team collaboration or code review
- Missing the complexity of real business requirements

## Configuration: CLAUDE.md Structure

The orchestrator configuration uses a declarative format that enforces workflow constraints:

```yaml
# ~/.claude/CLAUDE.md
version: 2.0
mode: orchestrator

workflow:
  trigger: issue_number
  stages:
    - name: analysis
      agents: [search-specialist]
      output: technical_requirements.json
    - name: implementation
      agents: [frontend-developer, backend-architect]
      parallel: true
      output: draft_pr
    - name: testing
      agents: [test-automator]
      requires: [implementation]
      output: test_report.json
    - name: review
      agents: [code-reviewer]
      requires: [testing]
      output: review_checklist.md

constraints:
  branch_strategy: feature_branch_per_issue
  pr_strategy: draft_then_ready
  merge_requirements:
    - all_tests_passing
    - no_linter_warnings
    - approved_review
    - no_merge_conflicts

agent_capabilities:
  orchestrator:
    tools: [Task, TodoWrite]
    restrictions: [no_code_modification, no_file_creation]
  
  implementation_agents:
    tools: [Read, Edit, MultiEdit, Grep, Bash]
    restrictions: [no_direct_commits, must_match_patterns]
```

## What I've Observed (Small Sample)

**Disclaimer**: These observations are from ~15 blog posts and minor features over 2 months, not a rigorous study.

### Subjective Improvements
- **Fewer iterations**: The orchestrator approach typically gets closer to what I want on the first try
- **Better pattern matching**: Code more consistently follows existing conventions
- **Less context switching**: I specify requirements once rather than correcting details repeatedly

### What I Can't Measure
- Time savings (I wasn't tracking before)
- Actual quality improvements (no automated testing on this blog)
- Whether this would work on complex business logic
- How it would perform with a team (this is a solo project)

### Honest Limitations
- Only tested on simple CRUD operations and static content
- Haven't tried it on performance-critical code
- No experience with debugging AI-generated edge case handling
- Blog posts are much simpler than real software features

## Setup and Usage

### Prerequisites

```bash
# Required tools
gh --version  # GitHub CLI 2.0+
git --version # Git 2.28+

# Claude Code with Max plan recommended
# (Orchestrator workflows consume 40-60M tokens per feature)
```

### Basic Configuration

```bash
# Global orchestrator config
cat > ~/.claude/CLAUDE.md << 'EOF'
mode: orchestrator
workflow:
  stages: [analysis, implementation, testing, review]
  branch_strategy: feature_branch_per_issue
  merge_strategy: squash_and_merge
EOF

# Project-specific overrides
cat > ./CLAUDE.md << 'EOF'
extends: ~/.claude/CLAUDE.md
project:
  language: typescript
  test_framework: jest
  linter: eslint
EOF
```

### Execution

```bash
# Standard feature implementation
gh issue create --title "Implement user authentication" \
  --body "JWT-based auth with refresh tokens"
# Returns: Created issue #42

# Invoke orchestrator
echo "Implement issue #42" | claude-code --mode orchestrator

# Monitor progress
gh pr list --state draft  # Watch draft PR creation
gh pr checks              # Monitor CI/CD
```

### Parallel Execution with Git Worktrees

```bash
# Setup parallel development environments
git worktree add -b issue-42-auth ../project-auth main
git worktree add -b issue-43-api ../project-api main

# Execute in parallel
(cd ../project-auth && echo "Implement issue #42" | claude-code --mode orchestrator) &
(cd ../project-api && echo "Implement issue #43" | claude-code --mode orchestrator) &
wait

# Results: Two PRs created simultaneously without conflicts
```

## Honest Assessment: Where This Works and Where It Doesn't

### Where I Think It Might Help
- **Simple, well-defined tasks**: Adding a contact form, updating styles, basic CRUD operations
- **Solo projects**: When you need structure but don't have a team for code review
- **Learning**: Forces you to think through requirements and decompose problems

### Where It Probably Doesn't Scale
- **Complex business logic**: AI still struggles with domain-specific requirements
- **Performance-critical code**: You need deep understanding, not pattern matching
- **Team environments**: Real code review and collaboration are more valuable than AI orchestration
- **Exploratory development**: When you don't know what you're building yet

### Token Usage Reality Check
I don't have precise measurements, but this approach does use significantly more tokens than direct coding:
- Multiple agent conversations per task
- Context switching between different "specialists"
- Review cycles that re-read code multiple times

The Claude Code subscription helps avoid usage anxiety, but this probably isn't cost-effective for most developers if paying per-token.

### Rough Performance Estimates
While I don't have rigorous metrics, I can provide ballpark observations:

**Time per blog post:**
- Before: ~2-3 hours (writing, editing, formatting, review)  
- After: ~1.5-2 hours (includes orchestration overhead)
- Net savings: ~30% reduction in iteration cycles, not total time

**Quality improvements** (subjective):
- Fewer forgotten steps (tests, formatting, links)
- More consistent structure across posts
- Less context switching during writing

**Overhead costs:**
- ~15% more token usage due to role-switching
- ~5 minutes setup time per task for prompting
- Mental overhead of maintaining role constraints

### What I Still Don't Know
- Whether this scales to complex business logic
- How it performs with multiple developers
- If the constraints actually improve outcomes vs. placebo effect
- Whether other developers would find this valuable

## Future Work: How to Test This Properly

To move beyond personal anecdote, here's what would need rigorous evaluation:

### Controlled Experiments
```yaml
experimental_design:
  participants: 20 developers (10 control, 10 treatment)
  tasks: identical feature implementations
  metrics: [time_to_completion, iteration_count, code_quality_score, test_coverage]
  duration: 4 weeks
  codebases: [react_app, django_api, node_service]
```

### Proposed Metrics
- **Efficiency**: Lines changed per hour, PR cycle time
- **Quality**: Test coverage delta, linting violations, post-deployment bug rate  
- **Consistency**: Pattern adherence score (automated analysis)
- **Developer Experience**: Survey data on cognitive load, learning curve

### Research Questions
1. **Does role constraint improve outcomes vs placebo effect?**
   - A/B test: structured prompting vs unstructured
   - Measure: task completion quality and time

2. **What types of tasks benefit most from orchestration?**
   - Categorize: CRUD, algorithms, UI, integration, refactoring
   - Find: optimal orchestration complexity per task type

3. **How does this scale with team size?**
   - Test: 1, 3, 5, 10 person teams using shared orchestration
   - Measure: coordination overhead, merge conflicts, productivity

## Conclusion

This experiment in structured AI interaction shows promise as a workflow optimization, but the technical community needs more rigorous evaluation before drawing broader conclusions.

**Current status:**
- Personal productivity improvement (~30% fewer iterations)
- Works well for content creation and simple feature development
- Requires further testing on complex software and team environments

**Technical contribution:**
- Demonstrates role-based prompting with artificial constraints
- Shows two-stage review process reducing integration issues
- Provides foundation for controlled experiments in AI-assisted development

**Next steps:**
- Implement quantitative measurement framework
- Test across multiple codebases and complexity levels
- Evaluate team collaboration scenarios

The complete implementation (CLAUDE.md configuration, workflow scripts, and example issues) is available in [the repository](https://github.com/eligrumman/eligrumman.github.io) for replication and improvement.

If you experiment with this approach, particularly in team environments or complex codebases, I'd be interested in your results - especially failure modes and scalability challenges.