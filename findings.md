# TerraStudio: Vibe-Coded App — Git History Findings

> Analysis of 338 commits over 33 days (Feb 19 – Mar 23, 2026), building a full desktop infrastructure-as-code visual editor + CLI from zero to v0.48.

---

## The Numbers

| Metric | Value |
|--------|-------|
| Total commits | 338 |
| Calendar days | 33 (with gaps) |
| Active development days | 26 |
| Avg commits/day (active) | 13.0 |
| Peak day (Feb 20) | 48 commits |
| Second peak (Mar 15) | 42 commits |
| Feature commits (`feat:`) | 130 (38.5%) |
| Bug fix commits (`fix:`) | 113 (33.4%) |
| Chore/CI (`chore:`) | 23 (6.8%) |
| Documentation (`docs:`) | 17 (5.0%) |
| Refactors (`refactor:`) | 5 (1.5%) |
| Tests (`test:`) | 3 (0.9%) |
| Merge/release automation | 48 (14.2%) |
| Version releases | v0.3.0 → v0.48.1 |
| Major features shipped | ~48 minor versions in 33 days |

---

## Timeline: Speed of Development

The entire app went from `docs: initial architecture and implementation plan` to a 39-feature desktop application in under 3 weeks.

### Day 1 (Feb 19): Foundation Sprint — 8 commits
- Scaffolded monorepo (types → core → plugin → Tauri app) in a single day
- Phases 1–5 all landed on day 1
- Hit immediate Tauri WebView2 drag-drop issues (3 consecutive fixes)

### Day 2 (Feb 20): The Marathon — 48 commits
- **20 feature commits in a single day** — the most productive day
- Shipped Phases 6–12 plus container nodes, icons, undo/redo, theming, welcome screen, project system, deployment status, export, and more
- 8 fix commits chasing behind the features
- This day alone produced ~20% of the entire codebase

### Days 3–7 (Feb 21–25): Resource Explosion
- Added 20+ Azure resources, templates, edge system, reference properties
- Entire edge styling system (4 versions in one day: v0.4.0 → v0.4.3)

### Days 8–12 (Feb 26–Mar 2): Architecture Hardening
- Cost estimation, MCP server, multi-window, modules
- Module system required the most fix iterations (6 consecutive fixes)

### Days 13–19 (Mar 3–9): Polish & AWS Expansion
- AWS plugin, i18n, accessibility, dependency graph, plan visualization
- 36 commits on Mar 8 alone — second biggest day

### Days 20–22 (Mar 12–13): UX Tightening
- 6 commits of pure fixes — grid snap drift, arrow key movement, project creation simplification
- Naming convention toggle replaced a confusing checkbox
- No new features — entirely fixing rough edges from the Mar 8 sprint

### Day 23 (Mar 15): The Second Marathon — 42 commits
- **Naming convention system collapsed**: 7 consecutive fix commits trying to get naming slug, label, and region inheritance to work together. Each fix broke something else (feedback loops, missing fields, desync between slug and label).
- **Platform architecture sprint**: Extracted `@terrastudio/project` package, scaffolded `@terrastudio/cli`, implemented full CLI with HCL generation, project creation, terraform commands, and binary packaging — all in one day
- **CI/release nightmare began**: First attempt at npm publish triggered 10+ fix commits across Mar 15–16 (OIDC, provenance, scoped package encoding, release-please tracking)

### Days 24–25 (Mar 16): Release Pipeline Hell — 11 commits
- **21 total CI/release fix commits** between Mar 15–16: npm OIDC trusted publishing, scoped package `%2f` encoding bug, Node 24 upgrade for provenance, release-please unblocking, version manifest sync
- Only 1 feature commit (structured logging) — the rest was fighting the release pipeline
- Version jumped from v0.41.0 to v0.41.7 in fix-commit churn

### Days 26–31 (Mar 21–22): Audit & Expansion — 29 commits
- **Resource audit**: 7 consecutive fix commits resolving ~30 tracked issues across all resource schemas (critical, high, and medium priority)
- **CLI hardening**: Fixed CJS/ESM crash with `import.meta.url`, switched to native OS builds instead of cross-compilation
- **Visual customization**: Node styling panel, right-side activity bar, custom sticky notes, visibility toggles
- **Azure AI plugin**: 8 new resources (Cognitive Services, OpenAI, Search, Bot Service, etc.)
- 28 commits on Mar 22 — third biggest day

### Days 32–33 (Mar 23): CLI Polish & New Peak
- Interactive CLI wizard for project creation
- Azure AI plugin improvements
- Dropped macOS x86_64 build (Apple Silicon only)
- Version reached v0.48.0

---

## What Went Well

### 1. Schema-driven architecture paid off massively
Adding new resources became mechanical: one schema + one HCL generator + one icon = full resource with palette entry, sidebar form, validation, and Terraform output. This is why **50+ Azure resources and 14+ AWS resources** were added in days, not weeks.

### 2. Plugin system enabled clean multi-cloud expansion
AWS support (`v0.21.0`) dropped in cleanly because the core was provider-agnostic from day 1. No core changes needed — just a new plugin package.

### 3. Rapid feature velocity
48 minor versions in 33 days. Features that would normally take sprints were shipped in hours:
- Full i18n with 6 languages — 1 commit
- Accessibility (WCAG AA, ARIA, font scaling) — 3 commits
- MCP server for AI integration — 1 commit
- Module system with templates — 2 feature commits + fixes
- Multi-window support — 2 commits
- Full CLI with HCL generation, terraform commands, binary packaging — 1 day
- Azure AI plugin with 8 resources — 2 commits

### 4. Terraform HCL generation quality
The `getPropertyExpression()` abstraction handled string/number/boolean/array/variable-mode formatting uniformly. Once the refactor landed (`964f5d5`), every generator benefited.

### 5. Conventional commits made this analysis possible
Consistent `feat:/fix:/chore:` prefixes with version tags made the entire history machine-parseable.

---

## What Went Horribly

### 1. Drag-and-drop was a nightmare (4 fixes before it worked)
```
fix: resolve drag-and-drop from palette to canvas
fix: move drag-drop handlers to DOM wrapper element
fix: enable HTML5 drag-drop in Tauri WebView2
fix: add DefaultResourceNode component so dropped nodes render on canvas
```
Tauri's WebView2 doesn't natively support HTML5 drag-and-drop the way browsers do. This was a multi-attempt debugging saga just to get the most basic interaction working.

### 2. Container node model flipped mid-development
```
fix: container nodes get explicit dimensions, subnet is now a container
fix: flip container relationship to canBeChildOf, fix nested nesting
fix: add canBeChildOf to NSG schema (Resource Group)
fix: dynamic reparenting on drag and scaled container defaults
```
The parent-child containment model was designed wrong initially (`canContain` on parents) and had to be inverted to `canBeChildOf` on children. This cascaded through every container resource.

### 3. Undo/redo required a complete rewrite
```
fix: undo/redo structuredClone error and select-all delete
fix: rewrite undo/redo to snapshot after mutations
fix: debounce property edits so typing coalesces into one undo step
```
The initial approach hit `structuredClone` errors with Svelte 5 reactive state (proxied objects can't be cloned). Had to rewrite the entire undo system to snapshot after mutations.

### 4. Module system: 6 consecutive fix commits
```
fix: module boundary visibility — use front viewport portal, remove negative z-index
fix: module boundary/collapsed node visibility, handle dedup & layout
fix: module HCL dedup, locals scope, stdin hang, draggable boundaries & file tree
fix: module instance expand/collapse — proper cloning, parenting & HCL isolation
fix: filter synthetic/transient nodes from all non-UI pipelines
```
Modules introduced "synthetic nodes" (transient UI-only nodes for collapsed/expanded views) that leaked into HCL generation, save/load, export, cost estimation — basically everywhere. Each pipeline needed explicit filtering.

### 5. TypeScript typecheck cascade (5 fixes in a row)
```
fix: add explicit types to implicit-any arrow function parameters
fix: resolve remaining typecheck errors — implicit any params and pluginRegistry export
fix: introduce IReactivePluginRegistry interface for correct typecheck resolution
fix: import IReactivePluginRegistry before using in declare statement
fix: resolve all typecheck errors — IReactivePluginRegistry interface propagation
```
Adding reactive plugin registry to the type system created a cascade of `implicit any` errors that took 5 attempts to fully resolve. Each fix exposed more type errors downstream.

### 6. Release-please version sync was a recurring headache
```
chore: restore version to 0.4.3 and sync release-please manifest
chore: sync release-please manifest to v0.18.0
chore: sync release-please manifest to v0.19.0
chore: restore version to 0.37.0 after release-please revert
chore: sync release-please manifest to v0.37.0
```
Release-please's manifest kept drifting from the actual app version (3 locations: package.json, tauri.conf.json, Cargo.toml). At least 5 commits were purely fixing version sync.

### 7. Naming convention system collapse (7 consecutive fixes)
```
fix: replace naming convention checkbox with toggle switch
fix: inherit env/region naming tokens from parent Resource Group (#28)
fix: remove redundant naming_region field and fix slug extraction feedback loop
fix: decouple naming convention slug from computed name/label
fix: restore naming_region shortcode field on Resource Group
fix: keep label in sync with naming slug, simplify canvas label derivation
fix: propagate RG naming overrides to nodes without a stored namingSlug
fix: derive naming region from RG location dropdown (v0.39.1)
```
The naming convention system created a **circular dependency**: slug derived from name, name derived from slug, label derived from both. Each fix broke a different direction of the cycle. Fields were removed then restored. The region shortcode was dropped, then added back. It took 7 attempts and a final refactor to `NamingTokenSource` to stabilize. This is the worst fix chain in the entire project — worse than modules (6 fixes) or containers (5 fixes).

### 8. npm publish / CI pipeline saga (21 fix commits across 2 days)
```
fix: use direct pkg binary path to avoid conflict with npm pkg command
fix: switch npm publish to OIDC trusted publishing (no token required)
fix: rename npm package to @afroze9/terrastudio-cli
fix: support manual release trigger in addition to release-please
fix: remove email address from package author fields
fix: track CLI package in release-please and bump to 0.41.2
fix: remove manual release trigger, restore clean release-please flow
fix: trigger build jobs when CLI package releases independently of desktop
fix: remove CLI from release-please tracking, gate all jobs on desktop release
fix: force release-please PR for pending fixes
fix: unblock release-please after tagging v0.41.3
fix: sync release-please manifest to v0.41.3
fix: trigger release after unblocking release-please
fix: use npm publish with job-level id-token permission for OIDC trusted publishing
fix: remove --provenance flag from npm publish (scoped package %2f encoding bug)
fix: use Node 24 for npm publish to fix OIDC provenance 404 on scoped packages
fix: trigger release to verify npm OIDC publish with Node 24
fix: add repository url to cli package.json for npm provenance verification
fix: bump version to 0.41.7 and align cli package version
fix: build CLI binaries on native OS instead of cross-compiling (#48)
fix: drop macOS x86_64 release build (v0.48.2)
```
Adding CLI publishing to the existing release pipeline was **the single most painful saga in the entire project**. The version jumped from v0.41.0 to v0.41.7 purely in fix churn — 7 patch versions with zero feature changes. Key issues: npm's `pkg` command conflicted with the binary packager, OIDC trusted publishing required specific job-level permissions, scoped packages (`@afroze9/`) caused URL encoding issues with `%2f`, provenance attestation needed Node 24, and release-please couldn't track two packages (desktop + CLI) without constant manual intervention. This was 21 fix commits for zero new functionality — pure infrastructure fighting.

### 9. Resource audit revealed systemic schema quality issues (7 fix commits)
```
fix: resolve critical resource audit findings (#59, #74, #75, #76, #82, #84, #85, #86)
fix: resolve high-priority resource audit findings (#77, #81, #83, #87)
fix: resolve high-priority resource audit findings (#63, #79, #80, #89)
fix: resolve high-priority resource audit findings (#62, #64, #90, #91)
fix: resolve high-priority resource audit findings (#60, #61, #88, #92)
fix: resolve resource audit findings (#51, #65, #66, #67)
fix: resolve all remaining medium-priority resource audit findings
```
A systematic audit of all resource schemas uncovered **~30 tracked issues** across critical, high, and medium severity. These weren't new bugs — they were issues that had existed since the resources were first added. The AI had generated schemas with incorrect defaults, missing required properties, wrong validation rules, and inconsistent naming across 64+ resources. The audit required 7 batched fix commits touching dozens of files. This proves the "ship fast" approach accumulated silent correctness debt that only appeared under systematic review.

---

## Bugs & Fixes Breakdown

### By Category

| Bug Category | Count | Examples |
|-------------|-------|---------|
| CI/release pipeline | 28 | npm OIDC, provenance, release-please tracking, version manifests, binary packaging |
| UI/rendering issues | 18 | Ghost handles, node widths, boundary visibility, panel height, visibility toggles |
| HCL generation bugs | 8 | String quoting, os_type casing, deprecated API refs, injection |
| Naming convention | 8 | Slug feedback loops, region inheritance, label desync |
| Resource schema quality | 7 | Incorrect defaults, missing properties, wrong validation (audit batch) |
| Drag-and-drop / canvas | 8 | WebView2 DnD, reparenting, containment, grid snap drift, arrow keys |
| Type system errors | 6 | Implicit any, interface propagation |
| Module system | 6 | Synthetic nodes, HCL dedup, boundary rendering |
| Undo/redo | 3 | structuredClone, debouncing, select-all |
| Variable system | 4 | Array storage, list(string) handling, variable mode guards |
| Data display | 3 | [object Object], edge defaults, contrast ratios |
| Platform quirks | 5 | Context menu blocking, F5 refresh, devtools gating, CJS import.meta.url, macOS x86_64 |
| Miscellaneous | 9 | Export alignment, edge categories, reference validation, lockfile sync |

### Fix-to-Feature Ratio by Phase

| Phase | Features | Fixes Following | Ratio |
|-------|----------|-----------------|-------|
| Phase 4-5 (Tauri scaffold) | 2 | 5 (DnD issues) | 2.5:1 |
| Phase 6 (Containers) | 1 | 5 (containment model) | 5:1 |
| Phase 9 (Undo/redo) | 1 | 3 (rewrite) | 3:1 |
| Phase 14-15 (Modules) | 2 | 6 (synthetic nodes) | 3:1 |
| Edge system (v0.4.x) | 6 | 5 (styling/routing) | 0.8:1 |
| Cost estimation (v0.5.0) | 2 | 5 (types + UI) | 2.5:1 |
| AWS plugin (v0.21+) | 5 | 2 (connection rules) | 0.4:1 |
| Naming conventions (v0.39) | 1 | 7 (slug/label/region cycle) | **7:1** |
| CLI + npm publish (v0.40–41) | 8 | 21 (CI/release pipeline) | **2.6:1** |
| Resource audit (v0.42) | 0 | 7 (schema quality) | **∞ (pure debt)** |
| Visual customization (v0.43+) | 4 | 2 (panel/toggle issues) | 0.5:1 |

**Takeaway**: Early foundation features (DnD, containers, undo) had the worst fix ratios initially. But the **CI/release pipeline and naming conventions proved even worse** in the extended timeline. The resource audit (7 fixes, 0 features) represents pure accumulated quality debt. Later UI features (visual customization, Azure AI) stayed clean — confirming the architecture stabilized for *application* features, while *infrastructure* and *cross-cutting concerns* remained brittle.

---

## Architectural Breaking Points

### Times the architecture was fundamentally changed: 9

1. **Container model inversion** (`canContain` → `canBeChildOf`) — Feb 20
   - Impact: Every container resource schema had to be updated
   - Why: Top-down containment didn't handle nested containers properly

2. **NSG edge → property reference replacement** — Feb 21
   - Impact: Removed edge-based NSG connections, replaced with property references
   - Why: NSG-to-Subnet isn't a visual connection — it's a data reference

3. **Undo/redo rewrite** (reactive snapshots → mutation snapshots) — Feb 20
   - Impact: Complete rewrite of history management
   - Why: Svelte 5 proxies broke structuredClone

4. **Reference edge approach** (`$state+effects` → `$derived`) — Feb 25
   - Impact: Changed how reference edges are reactively computed
   - Why: Effect-based approach caused stale/duplicate edges

5. **HCL generator refactor** (manual formatting → `getPropertyExpression`) — Mar 3
   - Impact: Every single HCL generator rewritten
   - Why: Variable toggle system needed uniform property expression handling

6. **App Service Plan: container → leaf node** — Mar 5
   - Impact: Changed ASP from container to regular node, rewired connections
   - Why: ASP doesn't visually "contain" app services — it's a billing/scale reference

7. **Naming convention model** (computed → inherited → schema-declared) — Mar 15
   - Impact: 7 fix commits, a refactor, and a new `NamingTokenSource` abstraction
   - Why: The naming slug, display label, and region token formed a circular dependency — each derived from the others

8. **Platform architecture extraction** (monolith → packages) — Mar 15
   - Impact: Extracted `@terrastudio/project`, deleted MCP bridge, scaffolded `@terrastudio/cli`
   - Why: CLI and future web version needed shared project logic without Tauri/Svelte dependencies

9. **Annotation system replacement** (built-in → plugin) — Mar 22
   - Impact: Deleted old annotation system, replaced with annotation plugin
   - Why: Annotations needed to follow the plugin architecture pattern for consistency

---

## Notable Patterns

### The "Ship Then Fix" Cadence
Nearly every major feature followed this pattern:
1. Land the feature in 1-2 big commits
2. Immediately discover 2-5 issues
3. Fix them in rapid succession
4. Move on to the next feature

This is visible in the fix chains: **16 instances** of 2+ consecutive fix commits following a feature. The extended timeline shows the pattern intensifying — the naming convention chain (7 fixes) and npm publish saga (21 fixes) are the longest in the project.

### Icon Replacement Happened 4 Times
```
feat: replace generated icons with official Azure SVGs, make icon optional
feat: replace resource icons with official Azure SVGs
feat: replace AWS icons with official AWS Architecture icons
fix: replace 12 placeholder icons with official Azure SVGs
```
Icons started as generated/placeholder, were replaced with official SVGs, then replaced again when better versions were found, then fixed again for stragglers. The lesson: don't bother with placeholder icons.

### Version Number Chaos (Got Worse)
- v0.3.3 appears twice (different commits)
- v0.23.0 appears twice (different commits)
- release-please created versions like `0.1.2`, `0.1.3`, `0.1.4` while the app was already at `0.3.x`
- At least 10+ commits exist purely to fix version drift (up from 5 pre-March 9)
- v0.41.0 through v0.41.7 are **7 patch versions with zero feature changes** — pure CI/release fix churn
- Version jumped from v0.43 to v0.47 (skipping v0.44–v0.46) due to release-please misalignment
- CLI package version had to be manually aligned with desktop version multiple times

### The 48-Commit Day
Feb 20 had 48 commits — that's one commit every 30 minutes for a 24-hour day (or every 18 minutes for a 14-hour day). This included:
- 20 feature commits
- Phases 6 through 17
- Container nodes, icons, undo/redo, theming, project system, deployment status, export, auto-CIDR, variable management
- 8 documentation updates

### Security Was Retrofitted
The HCL injection fix (`fee36bd`) came at v0.12.0 — after 12 versions of generating HCL without escaping user input. The security hardening commit was reactive, not proactive.

### Testing Was Almost Absent
Only 3 `test:` commits in 338 total (0.9%). The test infrastructure itself (`vitest + v8 coverage`) wasn't added until late in development. The resource audit (Mar 22) proved what missing tests cost: ~30 schema issues that had been silently accumulating across 64+ resources.

---

## Quality of Life Features (Chronological)

| Version | Feature | Impact |
|---------|---------|--------|
| v0.3.0 | Subscription picker, minimap, tab context menu | Basic navigation |
| v0.3.2 | Keyboard shortcuts + Help menu | Discoverability |
| v0.3.3 | Destroy confirmation, close protection, notifications | Safety nets |
| v0.5.0 | Cost estimation panel | Business value |
| v0.8.0 | Canvas alignment + auto-fit tools | Layout productivity |
| v0.9.0 | .tstudio file association | OS integration |
| v0.12.0 | Security hardening, about dialog | Trust |
| v0.26.0 | Canvas search with filters | Large diagram navigation |
| v0.27.0 | Connection wizard | Onboarding |
| v0.28.0 | i18n (6 languages) | Global reach |
| v0.29.0 | Validation dashboard | Error visibility |
| v0.32.0 | Accessibility (ARIA, font scale) | Inclusivity |
| v0.34.0 | Sticky note annotations | Documentation on canvas |
| v0.35.0 | Smart duplication with numbering | Power user efficiency |
| v0.38.0 | draw.io-style connections, space-to-pan | Familiar UX |
| v0.39.0 | Display Name field, multi-subscription HCL | Enterprise readiness |
| v0.40.0 | CLI with full HCL generation | Headless/CI usage |
| v0.41.0 | CLI binary packaging + npm publish | Distribution |
| v0.42.0 | Resource audit fixes, native CLI builds | Quality baseline |
| v0.43.0 | Node visual customization, activity bar | Designer workflow |
| v0.47.0 | Azure AI plugin (8 resources) | AI/ML cloud support |
| v0.48.0 | Interactive CLI wizard | Developer onboarding |

---

## Things That Were Broken by New Features

| New Feature | What It Broke |
|-------------|---------------|
| Module system (v0.14) | HCL generation (synthetic nodes leaked in), save/load, export, cost estimation |
| Variable toggle (v0.16) | Array property storage, sidebar display, tfvars generation |
| Compact node view | Node widths, label truncation, ASP container model |
| Multi-window (v0.10-11) | Settings sync, MCP state isolation, project targeting |
| Edge styling (v0.4.x) | Auto-layout weighting, default color display, visibility toggles |
| Cost estimation (v0.5) | Type system (5 typecheck fixes), badge positioning |
| Reference edges | Ghost handle routing, $state reactivity, handle positioning |
| AWS plugin (v0.21) | Connection rules, compact mode, icon system |
| Display Name field (v0.39) | Naming slug derivation, label sync, region inheritance — 7 fix chain |
| CLI packaging (v0.40–41) | npm publish pipeline, release-please tracking, OIDC auth, binary packaging — 21 fix chain |
| Node visibility toggles (v0.43) | Handle repositioning when toggling outputs on/off |
| Platform extraction (v0.40) | CLI crashed on `import.meta.url` in CJS context, cross-compilation failures |

---

## Summary: Vibe Coding Verdict

### Strengths
- **Incredible velocity**: 48 versions in 33 days, from zero to a full desktop app + CLI
- **Architecture-first paid off**: Schema-driven + plugin system made scaling resources trivial
- **Conventional commits**: Made the project self-documenting and analyzable
- **Iterative refinement worked**: Ship fast, fix fast, move on

### Weaknesses
- **33.4% of all commits were bug fixes** — the fix rate *increased* from 28% to 33% as the project grew
- **Testing was an afterthought** (0.9% of commits) — bugs were caught by manual testing and a late audit
- **Security was retrofitted** — HCL injection wasn't caught until v0.12
- **Platform quirks (Tauri/WebView2) ate significant time** — DnD, context menus, devtools, CJS/ESM
- **Release automation was the biggest time sink** — 28 CI/release fix commits, 21 in a single saga
- **9 architectural course corrections** — naming conventions (7 fixes) and platform extraction joined the hall of pain
- **Silent quality debt**: Resource audit at v0.42 revealed ~30 schema issues that had accumulated undetected across 64+ resources

### The Pattern
Vibe coding produces a distinctive commit pattern: **bursts of ambitious features followed by trails of fixes**. The fix ratio *did not* stabilize as expected — it actually worsened from 28% (first 19 days) to **47% (days 20–33)** as the project hit infrastructure complexity (CI pipelines, npm publishing, naming systems). Application features (visual customization, Azure AI) stayed clean, but cross-cutting concerns became fix magnets.

**Bottom line**: 338 commits, 33 days, one developer + AI. A desktop app + CLI with 72+ cloud resources, multi-cloud support, Terraform execution, modules, cost estimation, i18n, accessibility, an MCP server, and binary distribution. The fix rate rose from 28% to 33% overall, proving that AI velocity creates compounding debt when it outpaces testing and infrastructure maturity.

---

## Where AI Tools Still Failed — And What It Means

Despite delivering 48 versions in 33 days, the AI made specific, repeated, and sometimes dangerous mistakes. These failures aren't random — they reveal the structural boundaries of current AI-assisted development and have direct implications for the future of developers, architects, and the software industry.

### The Failure Categories

#### 1. Platform & Runtime Blind Spots — "It Doesn't Know What It Doesn't Know"

The AI generated standard HTML5 drag-and-drop code that doesn't work in Tauri's WebView2 environment. It took **4 consecutive fix commits** just to get the most basic interaction — dragging a resource onto a canvas — to function. Similarly, it used `structuredClone` on Svelte 5 reactive proxies (which can't be cloned), requiring a **complete rewrite of the undo/redo system**.

| Failure | Root Cause | Fixes Required |
|---------|-----------|----------------|
| Drag-and-drop broken | WebView2 ≠ browser DnD | 4 |
| Undo/redo broken | Svelte 5 proxies ≠ plain objects | 3 (full rewrite) |
| Context menu blocking | WebView2 default behavior | 1 |
| F5 refresh in prod | WebView2 allows refresh in release builds | 1 |
| CLI crash on install | `import.meta.url` doesn't work in CJS bundles | 2 (fix + native build switch) |
| macOS x86_64 build | Cross-compilation assumptions wrong | 1 (dropped target) |
| npm scoped package publish | `@scope/pkg` causes `%2f` encoding in OIDC URLs | 4+ (Node version, provenance flag, URL fix) |

**The pattern**: AI models train on web documentation and general framework guides. They lack deep knowledge of **runtime-specific behavior** — how Tauri's WebView2 diverges from Chrome, how Svelte 5's reactivity system mutates object identity, how NSIS installers differ from MSI, how CJS bundling breaks ESM-only APIs, how npm's OIDC implementation handles scoped packages. Every platform intersection was a failure point. The extended timeline shows this problem **getting worse, not better** — the CLI and npm publishing introduced an entirely new class of platform blind spots.

#### 2. Architectural Reasoning Failures — "It Can Build, But It Can't Design"

The AI made 9 fundamental architectural mistakes that required mid-development rewrites:

| Wrong Architecture | Correct Architecture | Impact |
|-------------------|---------------------|--------|
| `canContain` on parent nodes | `canBeChildOf` on child nodes | Every container schema rewritten; consumed an entire planned phase |
| Edge-based NSG connections | Property reference connections | Conceptual model was wrong — NSG-to-Subnet is data, not visual |
| `structuredClone` for undo | Post-mutation snapshots | Complete history system rewrite |
| `$state` + `$effect` for edges | `$derived` for edges | Caused stale/duplicate edge rendering |
| Manual HCL string formatting | Unified `getPropertyExpression()` | Every HCL generator rewritten |
| App Service Plan as container | App Service Plan as leaf node | Billing relationship ≠ visual containment |
| Computed naming slugs | Schema-declared `NamingTokenSource` with inheritance | 7 fix chain — slug/label/region formed circular dependency |
| Monolithic Svelte app | Extracted `@terrastudio/project` + CLI packages | Required deleting MCP bridge, rewriting project logic for headless use |
| Built-in annotations | Plugin-based annotation system | Old system deleted, replaced with plugin architecture |

These aren't bugs — they're **design errors**. The AI chose the wrong abstraction, the wrong data model, or the wrong relationship type. In each case, a human architect with domain knowledge would have caught the issue before writing a single line of code.

**The critical insight**: The container model inversion (`canContain` → `canBeChildOf`) is a textbook domain modeling error. Nested containers need children to declare what they fit inside, not parents to enumerate what they accept. This is the kind of reasoning that requires understanding the problem space, not just the code patterns.

#### 3. Security Was Invisible — "It Doesn't Think Like an Attacker"

HCL injection went undetected for **12 versions** (v0.0.1 → v0.12.0). The AI generated Terraform code by string-concatenating user input directly into HCL output — a classic injection vulnerability — without ever flagging the risk.

```
v0.1.0  → HCL generation ships with unescaped user input
v0.3.0  → 5 more resources added, all with same vulnerability
v0.5.0  → Cost estimation reads the vulnerable HCL
...
v0.12.0 → fix: escape all user-supplied strings in HCL generation
```

**12 versions of shipping vulnerable code.** The fix was reactive — discovered during use, not during generation. The AI never proactively considered: "What happens if a resource name contains `${malicious_code}`?"

This maps to a broader pattern: **AI tools optimize for functionality, not adversarial thinking.** They build what you ask for, not what an attacker would probe for.

#### 4. Cascading Blindness — "It Fixes Locally, Breaks Globally"

The module system introduced "synthetic nodes" (transient UI-only nodes for collapsed/expanded module views). The AI didn't anticipate that these nodes would leak into **every other pipeline**:

```
Module feature ships (2 commits)
  → HCL generation includes synthetic nodes  (fix 1)
  → Boundary visibility broken               (fix 2)
  → Node dedup and layout broken             (fix 3)
  → HCL dedup, locals scope, stdin hang      (fix 4)
  → Expand/collapse cloning broken           (fix 5)
  → Export, cost estimation, save/load all affected (fix 6)
```

Similarly, the TypeScript type cascade: adding one reactive interface created **5 sequential fix commits** as each fix exposed new downstream type errors. The AI couldn't see the full propagation graph.

The **naming convention system** (Mar 15) is the most vivid post-March 9 example: adding a "Display Name" field created a circular dependency between slug, label, and region tokens. Each of the 7 fixes broke a different direction of the cycle — removing a field that another subsystem depended on, creating feedback loops between computed values, desyncing what the canvas showed from what HCL generated. The AI fixed each symptom locally without seeing the circular data flow.

The **npm publish saga** shows cascading blindness in CI/CD: each fix to the release pipeline broke something else — adding manual triggers broke release-please flow, tracking CLI in release-please broke job gating, OIDC fixes broke provenance, provenance fixes required Node version bumps. 21 fixes chasing a single goal (publish an npm package) because the AI couldn't model the interactions between release-please, GitHub Actions OIDC, npm provenance, and scoped package URL encoding simultaneously.

**The pattern**: AI operates at the **local scope** — the file, the function, the immediate feature. It doesn't maintain a mental model of how a change ripples through the entire system. The module synthetic nodes should have been filtered from non-UI pipelines *from the start*, the naming convention system needed a dependency graph before implementation, and the CI pipeline needed a holistic understanding of the publish flow. Each of these required **system-level reasoning** the AI doesn't have.

#### 5. Testing as an Afterthought — "It Ships, But It Doesn't Verify"

| Metric | Value |
|--------|-------|
| Test commits | 3 out of 338 (0.9%) |
| When test infra was added | Commit 195 of 338 (58% through development) |
| Bugs caught by tests | ~0 (all caught manually or by late audit) |
| Fix commits that could have been prevented | ~50+ (UI/rendering, HCL, type errors, schema quality) |
| Resource audit findings | ~30 schema issues across 64+ resources — all undetected until manual review |

The AI never proactively wrote tests. It never said "this undo system needs a test for proxy objects" or "this HCL generator needs injection tests." Every bug was discovered by a human running the app.

#### 6. Documentation Decay — "It Documents the Plan, Not the Reality"

- **11 spec documents** were created as AI implementation guides — all deleted within 48 hours
- Architecture docs were updated **3 times**, then never again through 23 more versions
- By v0.48, the docs describe a v0.16 system — **32 versions of drift**
- The Gantt chart was abandoned after day 2

The AI treated documentation as disposable input, not living output. It consumed specs to build features, then moved on. No AI tool circled back to update the architecture docs when the architecture changed.

---

### What This Means for the Future

#### For Developers: You're Not Replaceable — You're Redefined

The data is unambiguous: AI produced incredible velocity (48 versions in 33 days) but required a human to catch every architectural mistake, security vulnerability, platform quirk, and cascading failure. The **33% fix rate** isn't a bug in the process — it's the cost of AI's blind spots — and it *increased* as the project grew more complex.

What changes for developers:
- **Code writing becomes cheaper, code review becomes critical.** When AI can ship 20 features in a day, the bottleneck shifts to *evaluating* whether those features are correct, secure, and architecturally sound.
- **Platform expertise becomes more valuable, not less.** The Tauri/WebView2 failures, CJS/ESM crashes, and npm OIDC saga show that knowing *how runtimes and toolchains actually behave* — beyond what documentation says — is exactly the knowledge AI lacks. The extended timeline proves this gap doesn't close over time.
- **CI/CD and infrastructure knowledge is the new moat.** The 21-commit npm publish saga is the clearest signal: AI cannot reason about the interaction between release-please, GitHub Actions, npm registries, OIDC auth, and package scoping. DevOps expertise is one of the hardest things for AI to replicate.
- **The "fix chain" is your new workflow.** Expect to ship AI-generated features and immediately chase 2–7 issues. The naming convention chain (7 fixes) and npm saga (21 fixes) show fix chains can be *much* longer than the 2–5 from early phases.
- **Reading code surpasses writing code as the core skill.** When AI writes 80% of the code, the developer's job is understanding what it wrote, why it's wrong, and what the second-order effects are.
- **Quality auditing becomes a mandatory practice.** The resource audit at v0.42 found ~30 issues that had been silently accumulating. AI-generated code needs periodic systematic review — not just fix-as-you-go.

#### For Architects: This Is Your Moment

Every major failure in this dataset was an **architecture failure**, not a code failure:

- Container model inversion → wrong domain model
- NSG edge vs. property → wrong relationship abstraction
- Undo rewrite → wrong framework interaction model
- Module node leaks → wrong boundary definition
- HCL injection → missing threat model
- App Service Plan → wrong visual metaphor for a billing concept
- Naming convention circular dependency → didn't model the data flow graph
- Monolithic app assumption → didn't anticipate platform extraction needs
- Annotation system → built a one-off instead of using the plugin pattern

AI can implement any architecture you give it — fast. But it chose the wrong architecture **9 out of 9 times** when left to its own judgment. It picked `canContain` because that's the obvious pattern; a human architect picks `canBeChildOf` because they've modeled nested hierarchies before and know the inversion is required. It computed naming slugs from labels because that's the direct path; a human architect sees the circular dependency before writing line one.

What changes for architects:
- **Upfront architecture decisions have 10x more leverage.** When AI builds at this velocity, a wrong architectural choice cascades into 5–7 fix commits within hours. Getting it right upfront eliminates entire fix chains. The naming convention system (7 fixes) could have been 0 fixes with a proper data flow diagram.
- **The architect's value proposition inverts.** Traditionally, architects designed systems that teams built slowly. Now, architects design systems that AI builds instantly — the quality of the design is exposed immediately, not over months.
- **"Architecture as prompt engineering" is real.** The 11 spec documents that guided AI implementation were essentially architectural prompts. They worked — features built from specs had lower fix ratios than ad-hoc features.
- **Cross-cutting concerns are the architect's domain now.** Security (injection), observability (logging added at Phase 22.1), error propagation (module node leaks), naming conventions, CI/CD pipeline design — these are the concerns AI systematically misses because they span the entire system.
- **Platform architecture extraction can't be an afterthought.** The Mar 15 sprint to extract `@terrastudio/project` and build the CLI proves that AI won't proactively plan for multi-platform distribution. An architect would have designed the package boundary on day 1.

#### For the Industry: The 33% Tax (And Rising)

The fix-to-feature ratio tells the real story:

| Phase | Fix Ratio | Interpretation |
|-------|-----------|----------------|
| Early (Phases 4-6) | 2.5:1 to 5:1 | AI + unfamiliar architecture = high failure rate |
| Mid (Phases 9-15) | 3:1 | AI + complex features = moderate failure rate |
| Late (Phases 21+) | 0.4:1 to 0.8:1 | AI + stable architecture = low failure rate |

**The fix rate for application features drops as the architecture stabilizes — but the overall fix rate *increases* as infrastructure complexity grows.** The extended timeline proves this: app features (visual customization, Azure AI) had low fix ratios, while infrastructure work (CI/CD, naming, CLI packaging) had the worst ratios in the entire project. AI is excellent at *extending* a well-designed system and poor at *establishing* one or *distributing* one.

- **AI-first development works best with human-designed foundations.** The schema-driven plugin system (designed upfront) made adding 72+ resources trivial. The container model (designed by AI) broke immediately. The naming convention system (designed by AI) created circular dependencies.
- **The cost of AI-assisted development isn't zero — it's ~33%.** For every 1.2 features, expect 1 fix. This is dramatically faster than traditional development, but it's not free. Teams need to budget for the fix tail — and the tail gets *longer* for infrastructure work.
- **Testing and security must be enforced by process, not by AI initiative.** The AI never volunteered tests. It never flagged injection risks. The resource audit at v0.42 found ~30 accumulated schema issues. These must come from external gates — CI pipelines, code review checklists, periodic audits, architectural decision records — not from AI judgment.
- **Documentation becomes either disposable or enforced.** The AI's natural mode is to write specs, consume them, and delete them. If living documentation matters, it must be enforced externally — the AI won't maintain it on its own.
- **CI/CD pipelines are the hardest thing for AI to get right.** The 21-commit npm publish saga and recurring release-please issues prove that multi-system pipeline orchestration is where AI reasoning breaks down most completely. Budget human time for infrastructure work.

#### The Developer of 2027

Based on this data, the high-value developer of the near future looks like this:

| Skill | Why |
|-------|-----|
| **System design / domain modeling** | AI picked the wrong abstraction 9/9 times — design is the irreplaceable skill |
| **Security thinking** | AI shipped injection vulnerabilities for 12 versions — adversarial reasoning is a human job |
| **Platform runtime knowledge** | AI's browser assumptions broke in WebView2, CJS/ESM, npm OIDC — deep runtime expertise is a moat |
| **CI/CD and DevOps engineering** | 21-commit npm saga proves pipeline orchestration is AI's weakest area |
| **Cross-system reasoning** | AI couldn't see module nodes leaking, naming cycles, or CI interactions — system-wide thinking is essential |
| **Code review & triage speed** | With 42 commits/day possible, reviewing and fixing AI output is the pace-setter |
| **Quality auditing** | Resource audit found 30 silent issues — periodic systematic review is a human responsibility |
| **Test strategy design** | AI won't write tests unprompted — defining what to test is a human responsibility |

What loses value:
- Writing boilerplate code (AI does this at near-zero cost — 50+ resources from schemas)
- Memorizing API surfaces (AI knows every API, just not how they interact at runtime)
- Manual refactoring (AI handles mechanical transforms like the HCL `getPropertyExpression` refactor)
- Documentation writing (AI generates docs, the problem is making it *maintain* them)

### The Cost Equation: AI vs. Hiring a Developer

What did TerraStudio actually cost to build with AI, and what would it have cost the traditional way?

#### AI-Assisted Development Cost (Actual)

| Cost Item | Estimate |
|-----------|----------|
| Claude Pro subscription (~1.5 months) | ~$300 |
| API usage overflow (if any) | ~$100–$800 |
| Developer time (26 active days × ~10–14 hrs) | 260–364 hours |
| **Total AI tooling cost** | **~$300–$1,100** |
| **Total human time** | **~260–364 hours (~1.5 months)** |

The developer still worked full-time — the AI didn't replace the human hours, it **multiplied what those hours produced**. One person shipped what would normally require a team.

#### Traditional Development Cost (Estimated)

For an equivalent app — desktop Electron/Tauri shell, visual canvas editor, 72+ cloud resources, Terraform generation, multi-cloud plugins, module system, i18n, accessibility, MCP server, CLI with binary distribution — scoped against industry benchmarks:

| Role | Duration | Rate (USD) | Cost |
|------|----------|------------|------|
| Senior full-stack developer | 4–6 months | $80–$150/hr | $51,200–$144,000 |
| UI/UX work (canvas, DnD, theming) | 2–3 months | $70–$130/hr | $22,400–$62,400 |
| DevOps/CI (Tauri builds, release-please, signing) | 1–2 months | $80–$140/hr | $12,800–$44,800 |
| Cloud architect (Azure/AWS schemas, HCL correctness) | 1–2 months | $90–$160/hr | $14,400–$51,200 |
| QA/testing | 2–3 months | $50–$90/hr | $16,000–$43,200 |
| **Total (solo dev, no overhead)** | **6–9 months** | — | **$116,800–$345,600** |
| **Total (small team of 2-3, parallel)** | **3–5 months** | — | **$150,000–$400,000** |

#### The Multiplier

| Metric | AI-Assisted | Traditional | Multiplier |
|--------|-------------|-------------|------------|
| Calendar time | 33 days | 3–9 months | **3–8x faster** |
| Tooling cost | ~$300–$1,100 | N/A | — |
| Human hours | ~300 hrs | ~1,500–3,000 hrs | **5–10x fewer hours** |
| Total cost (incl. developer salary) | ~$25,000–$45,000* | ~$120,000–$400,000 | **3–9x cheaper** |
| Bug rate | 33% fix commits | ~10–15% in mature teams | **~2–3x more bugs** |
| Test coverage | 0.9% | 40–70% (industry norm) | **Dramatically worse** |
| Security posture | Retrofitted at v0.12 | Shift-left (ideally) | **Worse** |
| Schema quality | 30 issues found in audit | Caught during review | **Worse** |

*\*Assuming the developer's loaded cost at ~$80–$120/hr for 300 hours.*

#### What the Numbers Actually Mean

The cost advantage is real but the comparison isn't apples-to-apples:

- **What you get faster**: A working product with broad feature coverage and a CLI. TerraStudio at v0.48 has more *features* than most teams ship in 6–9 months.
- **What you don't get**: Test coverage, security-by-design, maintainable architecture documentation, code review, clean CI/CD pipelines, and the institutional knowledge that a team builds. The 33% fix rate, 0.9% test coverage, and 30 audit findings are debts that compound.
- **The break-even question**: If you need a prototype, MVP, or internal tool — AI-assisted development is 3–9x cheaper and gets you there in weeks. If you need production-grade software with SLAs, compliance, and a team that can maintain it — the traditional approach's upfront cost pays for itself in lower maintenance burden. The extended timeline data shifts the multiplier down (from the initial 4–13x to 3–9x) because infrastructure work erodes the speed advantage.
- **The infrastructure tax**: The first 19 days were heavily feature-weighted (28% fixes). The next 14 days were heavily infrastructure-weighted (47% fixes). AI's cost advantage is strongest for *application features* and weakest for *tooling, CI/CD, and distribution*. Budget accordingly.
- **The hybrid sweet spot**: The data suggests the optimal approach is neither pure AI nor pure traditional — it's **architect-led, AI-accelerated development** with enforced quality gates. Human designs the architecture, security model, and CI pipeline. AI implements features at speed. CI enforces tests and linting. Human reviews before merge. Periodic audits catch accumulated quality debt.

---

### Could Agentic AI Have Caught These Failures?

The biggest question this dataset raises: if the AI had operated in a more autonomous, agentic mode — with the ability to run tests, validate its own output, and iterate before committing — would the 33% fix rate have been lower?

#### What Agentic Mode Could Have Caught

| Failure | Agentic Fix | Confidence |
|---------|-------------|------------|
| **TypeScript type cascade** (5 fixes) | Agent runs `tsc --noEmit` after each change, catches all type errors in one pass | **High** — this is mechanical verification |
| **HCL injection** (12 versions) | Agent runs a security linter or sanitization check on generated output | **Medium** — requires the agent to *know* to check for injection |
| **Drag-and-drop in WebView2** (4 fixes) | Agent launches the Tauri app, attempts the DnD interaction, observes failure | **Medium** — requires runtime testing capability |
| **Release-please version drift** (10+ fixes) | Agent validates version consistency across package.json, tauri.conf.json, Cargo.toml, CLI package.json before committing | **High** — simple file comparison |
| **Module synthetic node leaks** (6 fixes) | Agent runs the full pipeline (HCL gen, export, save/load) after adding modules | **Medium** — requires integration test awareness |
| **[object Object] display bugs** (3 fixes) | Agent renders the UI and checks for obvious display errors | **Low-Medium** — requires visual validation |
| **Container model inversion** | Agent models test cases with nested containers before implementing | **Low** — this is a design judgment, not a test |
| **Undo/redo structuredClone** | Agent tests undo on reactive state before shipping | **Medium** — if it knows to test edge cases |
| **Resource schema quality** (30 issues) | Agent runs conformance/validation checks against all schemas after generation | **High** — systematic validation |
| **CLI CJS/ESM crash** | Agent tests the bundled binary in a clean environment | **High** — simple smoke test |
| **Naming convention circular dependency** (7 fixes) | Agent traces data flow graph before implementing derived values | **Low** — requires design reasoning, not testing |
| **npm OIDC/provenance** (4+ fixes) | Agent runs the full publish workflow in a test environment | **Medium** — requires CI simulation |

#### What Agentic Mode Would NOT Have Caught

Some failures are **judgment problems**, not verification problems:

1. **Choosing `canContain` over `canBeChildOf`** — This is a domain modeling decision. An agent can verify that containers work, but it can't know the model is *wrong* until it hits nested containers. The test would need to be designed by someone who already knows the failure mode.

2. **NSG as edge vs. property reference** — This requires understanding that an NSG-to-Subnet relationship is a *data reference*, not a *visual connection*. No amount of automated testing reveals this — it's a UX/domain judgment.

3. **App Service Plan as container vs. leaf** — Same pattern: the AI modeled a billing concept as visual containment. The code *works* either way; the question is which model is *correct for the user's mental model*.

4. **Documentation maintenance** — An agent could be told to update docs, but it can't judge *when* architecture has drifted enough to warrant an update. The 23+ version documentation drift isn't a bug — it's a prioritization failure.

5. **Deciding to write tests in the first place** — Agentic AI follows instructions. If no one tells it "write tests for every feature," it won't. The 0.9% test rate isn't a capability gap — it's an *intent* gap. The agent would need a standing instruction: "never ship a feature without tests."

6. **Naming convention data flow design** — The circular dependency between slug, label, and region tokens is a design problem, not a testing problem. An agent could detect the cycle *after* implementation (by noticing infinite update loops), but it wouldn't preemptively design a unidirectional data flow.

7. **Platform extraction timing** — The decision to extract `@terrastudio/project` as a separate package on day 23 was a strategic architectural call. An agent wouldn't proactively decide "this app needs a headless core" — that requires anticipating future platform targets.

8. **CI pipeline interaction modeling** — The 21-commit npm publish saga involved interactions between release-please, GitHub Actions OIDC, npm provenance, and scoped package URL encoding. An agent could test individual steps but couldn't model the *interactions* between these systems before attempting them. This is emergent complexity — each tool works in isolation, but their combination creates failure modes that don't appear in any single tool's documentation.

#### The Agentic Estimate

If this project had used a fully agentic AI workflow with:
- Automatic `tsc` checks after every code change
- A security linting step on all generated HCL
- Version consistency validation pre-commit
- Integration test runs after each feature
- A standing rule to write tests alongside features
- Schema conformance checks after resource generation
- CLI smoke tests after bundling
- CI pipeline dry-run validation

| Metric | Actual (Non-Agentic) | Estimated (Agentic) | Reduction |
|--------|----------------------|---------------------|-----------|
| Fix commits | 113 (33%) | ~50–65 (~15–19%) | **42–56% fewer fixes** |
| Type cascade fixes | 5 | 0–1 | Eliminated |
| Security issues | Undetected for 12 versions | Caught at v0.1 | Eliminated |
| Version sync fixes | 10+ | 0–1 | Nearly eliminated |
| Schema quality issues | 30 (found in audit) | 5–10 (caught at generation) | **60–80% fewer** |
| CLI CJS/ESM crash | 2 fixes | 0 (smoke test catches) | Eliminated |
| npm publish saga | 21 fixes | 8–12 (interactions still hard) | **40–60% fewer** |
| Naming convention chain | 7 fixes | 5–6 (design error persists) | **Slightly reduced** |
| Architectural rewrites | 9 | 6–7 | **Slightly reduced** |
| Test coverage | 0.9% | 30–50% (if enforced) | **Dramatically better** |
| Development speed | 33 days | 38–45 days | **15–35% slower** (testing overhead) |

**The trade-off**: Agentic mode could cut the fix rate roughly in half — from 33% to ~17% — but at the cost of slower iteration. The mechanical errors (types, versions, schema validation, bundling) would be eliminated. The infrastructure interaction errors (npm OIDC + provenance + scoped packages) would be reduced but not eliminated — the agent would still need multiple attempts because these failures are emergent. The design errors (container model, naming conventions, platform extraction) would mostly remain.

#### The Gap That Remains: Architectural Agency

The failures that agentic mode *cannot* solve are the most expensive ones:

- Container model inversion consumed **an entire planned phase**
- Module synthetic nodes required **6 fixes across every pipeline**
- HCL generator refactor rewrote **every single generator**
- Naming convention circular dependency required **7 fixes and a schema-level refactor**
- npm publish saga consumed **21 commits across 2 days for zero new functionality**
- Platform extraction required **rewriting project logic** that could have been separated from day 1

These are the failures that come from the AI not having a **system-level mental model**. It doesn't ask: "If I add synthetic nodes here, which other subsystems touch node data?" It doesn't reason: "This container relationship will break when I need to nest three levels deep."

True architectural agency would require the AI to:
1. Maintain a dependency graph of all subsystems and their data contracts
2. Simulate the impact of a design choice across the full system before implementing
3. Challenge its own assumptions ("Is `canContain` really the right direction?")
4. Recognize when a local decision has non-local consequences

This isn't a prompting problem or a tooling problem — it's a **reasoning ceiling**. Current AI models optimize for the immediate context window. Architectural reasoning requires holding the *entire system* in mind and evaluating trade-offs across boundaries that span dozens of files and thousands of lines. The extended timeline data strengthens this conclusion: the naming convention circular dependency, the npm publish interaction cascade, and the platform extraction timing are all problems that require reasoning about system topology, not just code correctness.

There's also a new category the extended data reveals: **emergent infrastructure complexity**. The npm OIDC + provenance + scoped packages interaction doesn't appear in any single tool's documentation. It only manifests when you combine specific tools in a specific configuration. Even a highly capable agent would struggle here because the failure mode doesn't exist in training data — it's a product of combinatorial system interaction. This suggests that as AI-built systems mature and need real-world distribution (packaging, publishing, CI/CD), the architectural gap *widens* rather than narrows.

Until AI can reason about system topology and emergent interactions, the architect's job is safe — and more important than ever.

---

### The Uncomfortable Conclusion

This dataset — now spanning 338 commits over 33 days — shows AI as a **brilliant junior developer with no architectural judgment, no security instinct, no cross-system awareness, no CI/CD competence, and no testing discipline.** It works at 10x speed on application features but requires constant supervision on everything except the mechanical act of writing code. And when the project moves from "build features" to "distribute and harden," the AI's limitations become more pronounced, not less.

The cost comparison makes the value proposition clear: AI-assisted development is **3–9x cheaper and 3–8x faster** for getting to a working product. But the 33% fix rate, 0.9% test coverage, 9 architectural rewrites, and 30 accumulated schema issues are debts that a traditional team wouldn't accumulate. The real cost isn't the subscription — it's the **maintenance burden** that AI leaves behind.

The extended timeline reveals a critical nuance: **the fix rate gets worse, not better, as the project matures.** The first 19 days had a 28% fix rate. Days 20–33 had a 47% fix rate. This isn't because the AI got worse — it's because the project shifted from feature development (where AI excels) to infrastructure, distribution, and quality hardening (where AI struggles most). Any team planning to use AI-assisted development should expect the velocity advantage to *erode* as the project moves from prototype to production.

Agentic AI would close roughly half the gap — eliminating mechanical errors while leaving design and infrastructure interaction errors intact. The remaining failures are the ones that require **system-level reasoning, adversarial thinking, pipeline orchestration, and domain judgment** — exactly the skills that define senior developers, architects, and DevOps engineers.

The developers who thrive will be those who shift from *writing* code to *directing* and *correcting* AI-generated code — and the architects who can front-load the right design so the AI's 10x speed builds the right thing instead of the wrong thing 9 times.

**The 33% fix tax is the price of velocity — and it compounds as complexity grows. The question isn't whether to pay it — it's whether your architecture, CI pipeline, audit process, and testing strategy can keep it from becoming the dominant cost.**

---

## Appendix: Roadmap Evolution — How the Plan Mutated

The implementation roadmap (`docs/implementation-roadmap.md`) was created in the very first commit and updated 21 times across the project's life. It tells a story of a plan that barely survived contact with reality.

### The Original Vision (Feb 19)

The initial roadmap was **10 phases**, clean and linear:

| Phase | Goal | Status |
|-------|------|--------|
| 1 | Monorepo + Types | Completed as planned |
| 2 | Core Registry + HCL Pipeline | Completed as planned |
| 3 | Networking Plugin (VNet, Subnet, NSG) | Completed as planned |
| 4 | Tauri Shell + Canvas | Completed, but with 3 DnD fixes |
| 5 | Sidebar + Drag-Drop | Completed as planned |
| 6 | Compute Plugin (VM) | Completed, but containers required rework |
| 7 | Terraform Execution | Completed as planned |
| 8 | Deployment Status | Completed as planned |
| 9 | Save/Load + Polish | Completed, but undo/redo needed rewrite |
| 10 | Export + Doc Gen | Completed as planned |

The MVP scope was "5 Azure resources: Resource Group, Virtual Network, Subnet, NSG, Virtual Machine." This was actually achieved. Everything after Phase 10 was improvised.

The "Future Phases" section listed 8 ideas as vague bullet points:
1. Import existing Terraform
2. More Azure plugins
3. AWS/GCP plugins
4. Auto-layout
5. Template gallery
6. Cost estimation
7. Module support
8. Dark mode

**Of these 8 ideas**: 6 were eventually built, 1 was partially built, and 1 was never attempted.

### Phase Number Chaos: The .5 Problem

As development progressed, unplanned work kept appearing between planned phases. Rather than renumbering, phases got decimal suffixes:

| Phase ID | What It Was | Why It Was Unplanned |
|----------|-------------|----------------------|
| 15.5 | NSG Reference Properties | Original edge-based NSG model didn't work, needed property references |
| 16.5 | Naming Convention System | Discovered during project wizard work that names needed convention enforcement |
| 20.5 | Additional Azure Resources | Batch addition of Redis, PostgreSQL, Cosmos DB, Service Bus between planned phases |
| 21.5 | Edge Visibility UI Cleanup | Cost badges broke the toolbar, needed a rework |
| 21.6 | TypeScript Build Infrastructure | Typecheck cascade from cost estimation forced infrastructure work |
| 21.8 | Plugin Conformance Test Suite | Realized plugins had inconsistent schemas |
| 21.9 | Canvas Layout Tools | Alignment tools were a gap discovered during template building |
| 22.1 | Structured Logging | Debugging in production revealed need for proper logging |
| 22.2 | File Association | OS integration wasn't in the plan but felt essential |
| 22.3 | Multi-Window Support | Users wanted multiple projects open |
| 22.4 | Security Hardening | HCL injection vulnerability discovered |
| 25.5 | Module Template Reuse | Module system (Phase 25) worked but needed template instances |

**12 unplanned phases** were inserted, more than the original 10 planned phases. The roadmap grew from 10 phases to 36+ phases.

### Phases That Were Renamed / Repurposed

Some phase numbers kept their slot but completely changed scope:

| Phase | Original Plan | What It Became | Why |
|-------|---------------|----------------|-----|
| **13** | "Azure Subscription Resource + Variable Management UI" | "Containment Refactor" | The container model (`canContain` → `canBeChildOf`) broke so badly it needed a dedicated phase to fix |
| **14** | "Networking Intelligence + Azure Name Validation" | "New Azure Resources + resolveTerraformType" | Name validation via Azure API was deprioritized; expanding the resource catalog was more valuable |
| **17** | "Networking Intelligence + Azure Name Validation" (moved from 14) | "Networking Intelligence + Validation UX" | Got the CIDR auto-assignment part but Azure API name validation was dropped |

Phase 13 is the most telling: what was supposed to be a *feature* phase became a *fix* phase because the container architecture broke.

### Phases That Were Skipped Entirely

| Phase | Plan | Status | Why Skipped |
|-------|------|--------|-------------|
| **19** | Import Existing Terraform State | Never started | Requires parsing `terraform show -json` into diagram nodes — complex reverse-engineering that wasn't worth the effort with so many forward features to build |
| **20** | Expanded Azure Plugins | Partially done via 20.5 | The "expanded" phase was too vague; resources were added ad-hoc as needed instead |
| **21.7** | External File Change Detection | Dropped | Would watch for .tf file changes outside the app — low priority, never came back |

**Import Existing Terraform** was the most ambitious "future phase" and the only one that was never even attempted. It remains in the roadmap as a perpetual "someday" item.

### The Spec Lifecycle: Write 11, Delete 11

On Mar 7, **11 feature spec documents** were created in `docs/specs/` as part of the bottom panel system commit:

```
bottom-panel-system.md          canvas-search.md
connection-wizard.md            cost-breakdown.md
dark-mode-accessibility.md      dependency-graph-view.md
diagram-annotations.md          localization-i18n.md
smart-resource-duplication.md   terraform-plan-visualization.md
validation-dashboard.md
```

These were detailed specs (500–1000+ lines each) for features about to be built. They served as implementation guides for the AI.

**Within 24 hours**, 6 of the 11 specs were deleted (the features had been built). Within 48 hours, a 7th was deleted. The remaining 4 were consumed by their feature commits (cost-breakdown, diagram-annotations, smart-duplication, plan-visualization) and deleted as side-effects of those commits.

**The entire `docs/specs/` directory no longer exists.** All 11 specs were created and destroyed in ~2 days. They were disposable blueprints — written to guide implementation, deleted the moment the code was done.

### Documentation Update Frequency

The main architecture docs were updated exactly **3 times each**:

| When | What | Trigger |
|------|------|---------|
| Feb 19 | Initial creation | Day 1 — everything written from scratch |
| Feb 21 | NSG reference properties | Architecture shifted from edges to property references |
| Mar 3 | Module system + variable toggle | Two big features that changed the data model |

After Mar 3, the docs were **never updated again** — even though 36 more versions shipped. Features like AWS support, i18n, accessibility, MCP server, cost estimation, plan visualization, annotations, and dependency graphs all shipped without documentation updates.

The `version-history.md` file was a late addition (Mar 8) — a retroactive changelog created from commit messages.

### The Gantt Chart That Tried

The roadmap included a Mermaid Gantt chart that went through its own evolution:

1. **v1 (Feb 19)**: Abstract units (`dateFormat X`, `axisFormat %s`) — phases as numbered slots
2. **v2 (Feb 20)**: Real dates added but wrong — showed Feb 1–Mar 7 even though work started Feb 19
3. **v3 (Feb 20)**: "Compress roadmap Gantt to realistic daily dates" — tried to match reality
4. **v4 (Feb 20)**: "Add monthly tick interval" — formatting fix
5. **v5 (Feb 20)**: "Fix Gantt chart, add phases 13-15" — more phases broke the layout

The Gantt chart was updated 4 times in a single day (Feb 20) and then effectively abandoned. New phases were added to the phase list but never to the Gantt. By the end, the chart showed 17 phases while the actual roadmap had 36+.

### How Roadmap Evolution Connects to Findings

| Roadmap Event | Finding It Explains |
|---------------|---------------------|
| Phase 13 repurposed from feature → fix | The container model inversion was painful enough to consume an entire planned phase |
| 12 unplanned .5 phases | Vibe coding creates emergent requirements that can't be predicted — over half the work was unplanned |
| Azure Name Validation dropped twice | Some features keep getting deprioritized because the immediate value isn't there |
| Import Terraform never attempted | The hardest feature in the backlog stayed in the backlog — velocity favors new features over reverse-engineering |
| Specs created and deleted in 48 hours | Documentation in vibe coding is ephemeral — it exists to guide AI implementation, not for humans to read later |
| Docs not updated after Mar 3 | Architecture docs drifted from reality as velocity outran documentation. By v0.48, the docs describe a v0.16 system |
| Gantt abandoned after day 2 | Visual project tracking breaks down when the plan changes faster than you can update the chart |

### Summary: Plan vs. Reality

| Metric | Original Plan | Actual |
|--------|--------------|--------|
| Total phases | 10 | 36+ |
| Planned phases completed as-is | 8/10 | — |
| Phases renamed/repurposed | — | 3 |
| Unplanned phases inserted | — | 12 |
| Phases skipped | — | 2 |
| "Future" ideas eventually built | — | 6/8 |
| Days the Gantt chart was useful | — | ~2 |
| Spec documents created | — | 11 |
| Spec documents surviving | — | 0 |
| Architecture docs accurate at end | — | Outdated by ~32 versions |

The roadmap started as a linear 10-phase plan and ended as a 36+ phase patchwork with decimal suffixes, repurposed phases, and a dead Gantt chart. **The original plan got the architecture right** (plugin system, schema-driven, provider-agnostic) but couldn't predict the implementation surprises (container model inversion, undo rewrite, synthetic node leaks, naming convention cycles, npm publish saga) or the scope explosion (12+ unplanned phases, CLI extraction, Azure AI plugin). The plan survived as a rough compass, not a map.
