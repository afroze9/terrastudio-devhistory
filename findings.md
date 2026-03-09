# TerraStudio: Vibe-Coded App — Git History Findings

> Analysis of 239 commits over 19 days (Feb 19 – Mar 9, 2026), building a full desktop infrastructure-as-code visual editor from zero to v0.39.

---

## The Numbers

| Metric | Value |
|--------|-------|
| Total commits | 239 |
| Calendar days | 19 |
| Avg commits/day | 12.6 |
| Peak day (Feb 20) | 48 commits |
| Feature commits (`feat:`) | 107 (44.8%) |
| Bug fix commits (`fix:`) | 67 (28.0%) |
| Chore/CI (`chore:`) | 14 (5.9%) |
| Documentation (`docs:`) | 14 (5.9%) |
| Refactors (`refactor:`) | 4 (1.7%) |
| Tests (`test:`) | 2 (0.8%) |
| Merge/release automation | 31 (13.0%) |
| Version releases | 51 tagged versions (v0.3.0 → v0.39.1) |
| Major features shipped | ~39 minor versions in 19 days |

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

---

## What Went Well

### 1. Schema-driven architecture paid off massively
Adding new resources became mechanical: one schema + one HCL generator + one icon = full resource with palette entry, sidebar form, validation, and Terraform output. This is why **50+ Azure resources and 14+ AWS resources** were added in days, not weeks.

### 2. Plugin system enabled clean multi-cloud expansion
AWS support (`v0.21.0`) dropped in cleanly because the core was provider-agnostic from day 1. No core changes needed — just a new plugin package.

### 3. Rapid feature velocity
39 minor versions in 19 days. Features that would normally take sprints were shipped in hours:
- Full i18n with 6 languages — 1 commit
- Accessibility (WCAG AA, ARIA, font scaling) — 3 commits
- MCP server for AI integration — 1 commit
- Module system with templates — 2 feature commits + fixes
- Multi-window support — 2 commits

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

---

## Bugs & Fixes Breakdown

### By Category

| Bug Category | Count | Examples |
|-------------|-------|---------|
| UI/rendering issues | 15 | Ghost handles, node widths, boundary visibility, icon collisions |
| HCL generation bugs | 8 | String quoting, os_type casing, deprecated API refs, injection |
| Drag-and-drop / canvas | 7 | WebView2 DnD, reparenting, containment |
| Undo/redo | 3 | structuredClone, debouncing, select-all |
| Type system errors | 6 | Implicit any, interface propagation |
| CI/release pipeline | 7 | Binary names, NSIS vs MSI, version manifests |
| Module system | 6 | Synthetic nodes, HCL dedup, boundary rendering |
| Variable system | 4 | Array storage, list(string) handling, variable mode guards |
| Data display | 3 | [object Object], edge defaults, contrast ratios |
| Platform quirks | 3 | Context menu blocking, F5 refresh, devtools gating |
| Miscellaneous | 5 | Export alignment, edge categories, reference validation |

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

**Takeaway**: Early foundation features (DnD, containers, undo) had the worst fix ratios. Later features (AWS, i18n) were much cleaner — the architecture had stabilized.

---

## Architectural Breaking Points

### Times the architecture was fundamentally changed: 6

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

---

## Notable Patterns

### The "Ship Then Fix" Cadence
Nearly every major feature followed this pattern:
1. Land the feature in 1-2 big commits
2. Immediately discover 2-5 issues
3. Fix them in rapid succession
4. Move on to the next feature

This is visible in the fix chains: **11 instances** of 2+ consecutive fix commits following a feature.

### Icon Replacement Happened 4 Times
```
feat: replace generated icons with official Azure SVGs, make icon optional
feat: replace resource icons with official Azure SVGs
feat: replace AWS icons with official AWS Architecture icons
fix: replace 12 placeholder icons with official Azure SVGs
```
Icons started as generated/placeholder, were replaced with official SVGs, then replaced again when better versions were found, then fixed again for stragglers. The lesson: don't bother with placeholder icons.

### Version Number Chaos
- v0.3.3 appears twice (different commits)
- v0.23.0 appears twice (different commits)
- release-please created versions like `0.1.2`, `0.1.3`, `0.1.4` while the app was already at `0.3.x`
- At least 5 commits exist purely to fix version drift

### The 48-Commit Day
Feb 20 had 48 commits — that's one commit every 30 minutes for a 24-hour day (or every 18 minutes for a 14-hour day). This included:
- 20 feature commits
- Phases 6 through 17
- Container nodes, icons, undo/redo, theming, project system, deployment status, export, auto-CIDR, variable management
- 8 documentation updates

### Security Was Retrofitted
The HCL injection fix (`fee36bd`) came at v0.12.0 — after 12 versions of generating HCL without escaping user input. The security hardening commit was reactive, not proactive.

### Testing Was Almost Absent
Only 2 `test:` commits in 239 total (0.8%). The test infrastructure itself (`vitest + v8 coverage`) wasn't added until commit 195 out of 239. The app was largely untested for 80% of its development.

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

---

## Summary: Vibe Coding Verdict

### Strengths
- **Incredible velocity**: 39 versions in 19 days, from zero to a fully functional desktop app
- **Architecture-first paid off**: Schema-driven + plugin system made scaling resources trivial
- **Conventional commits**: Made the project self-documenting and analyzable
- **Iterative refinement worked**: Ship fast, fix fast, move on

### Weaknesses
- **28% of all commits were bug fixes** — nearly 1 fix for every 1.6 features
- **Testing was an afterthought** (0.8% of commits) — bugs were caught by manual testing
- **Security was retrofitted** — HCL injection wasn't caught until v0.12
- **Platform quirks (Tauri/WebView2) ate significant time** — DnD, context menus, devtools
- **Release automation fought back** — version sync issues across 3 files
- **6 architectural course corrections** — some quite painful (container model, undo system)

### The Pattern
Vibe coding produces a distinctive commit pattern: **bursts of ambitious features followed by trails of fixes**. The fix ratio decreases over time as the architecture stabilizes, but early phases have fix ratios as high as 5:1. The approach works best when the foundational architecture is sound — TerraStudio's plugin/schema system was the right bet early, which made later features cheap to add.

**Bottom line**: 239 commits, 19 days, one developer + AI. A desktop app with 64+ cloud resources, multi-cloud support, Terraform execution, modules, cost estimation, i18n, accessibility, and an MCP server. The bugs were real but the velocity was undeniable.

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
| Docs not updated after Mar 3 | Architecture docs drifted from reality as velocity outran documentation. By v0.39, the docs describe a v0.16 system |
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
| Architecture docs accurate at end | — | Outdated by ~23 versions |

The roadmap started as a linear 10-phase plan and ended as a 36-phase patchwork with decimal suffixes, repurposed phases, and a dead Gantt chart. **The original plan got the architecture right** (plugin system, schema-driven, provider-agnostic) but couldn't predict the implementation surprises (container model inversion, undo rewrite, synthetic node leaks) or the scope explosion (12 unplanned phases). The plan survived as a rough compass, not a map.
