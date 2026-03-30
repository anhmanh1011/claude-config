# MANDATORY: Auto-Apply Language Skills

This rule is NON-NEGOTIABLE. Before writing, editing, or dispatching ANY code, you MUST invoke the language-specific skills listed in CLAUDE.md.

## Trigger

ANY of these actions:
- Writing new code files
- Editing existing code files
- Dispatching subagents to write code
- Reviewing code
- Creating implementation plans that include code

## Required Actions

1. DETECT project languages (check file extensions: .go, .py, .rs, .kt, .java, .ts, .js)
2. INVOKE all matching skills from CLAUDE.md BEFORE writing code
3. For SUBAGENTS: embed the skill guidelines into the subagent prompt
4. NEVER skip this even when other workflows (superpowers, brainstorming, etc.) are active

## Language → Skills Mapping (from CLAUDE.md)

- **Go**: golang-project-layout, golang-code-style, golang-naming, golang-error-handling, golang-testing, golang-design-patterns, golang-concurrency, golang-safety, golang-security, golang-performance, golang-linter
- **Python**: python-patterns, python-testing (+ django-patterns if Django)
- **Rust**: rust-patterns, rust-testing
- **Kotlin**: kotlin-patterns, kotlin-testing
- **Java**: java-coding-standards (+ springboot-patterns if Spring Boot)
- **TypeScript/JS**: frontend-patterns (+ nextjs-turbopack if Next.js, + bun-runtime if Bun)
- **Docker/DevOps**: docker-patterns, deployment-patterns

## Also Required (from CLAUDE.md General)

- security-review: when touching auth, API, or user input
- api-design: when creating REST/gRPC endpoints
- database-migrations: when modifying database schemas

## Violation

If you realize you wrote code WITHOUT invoking these skills, STOP immediately and run a review pass with all applicable skills before proceeding.
