# TerraStudio Development Timeline Data

> Structured commit data for timeline visualization. 320 commits, Feb 19 – Mar 23, 2026.

## Format
Each entry: `hash | datetime | type | message | version (if any)`

Types: feat, fix, chore, docs, refactor, test, merge, ci

---

| # | Hash | DateTime | Type | Message | Version |
|---|------|----------|------|---------|---------|
| 1 | 85b01c8 | 2026-02-19T22:29 | docs | initial architecture and implementation plan | - |
| 2 | c211b6d | 2026-02-19T23:30 | feat | scaffold monorepo and @terrastudio/types (Phase 1) | - |
| 3 | ff9658a | 2026-02-19T23:35 | feat | @terrastudio/core - plugin registry, HCL pipeline (Phase 2) | - |
| 4 | f2b4a35 | 2026-02-19T23:37 | feat | azure-networking plugin: VNet, Subnet, NSG (Phase 3) | - |
| 5 | b4091a7 | 2026-02-19T23:43 | feat | Tauri 2 desktop app with Svelte Flow canvas (Phase 4) | - |
| 6 | 391ce37 | 2026-02-19T23:45 | fix | add DefaultResourceNode so dropped nodes render | - |
| 7 | c1dc73e | 2026-02-19T23:56 | fix | add @tauri-apps/cli devDependency | - |
| 8 | 15ae025 | 2026-02-19T23:58 | feat | schema-driven PropertyRenderer, DeploymentBadge, keyboard delete (Phase 5) | - |
| 9 | 6081f1d | 2026-02-20T00:03 | fix | resolve drag-and-drop from palette to canvas | - |
| 10 | 909a090 | 2026-02-20T00:05 | fix | move drag-drop handlers to DOM wrapper element | - |
| 11 | 13245f7 | 2026-02-20T00:16 | fix | enable HTML5 drag-drop in Tauri WebView2 | - |
| 12 | 8f56f98 | 2026-02-20T00:22 | fix | resolve type errors and node position persistence | - |
| 13 | 1ea7365 | 2026-02-20T00:27 | feat | compute plugin, container nodes, cross-plugin connections (Phase 6) | - |
| 14 | 8a99b00 | 2026-02-20T00:31 | fix | container nodes explicit dimensions, subnet is container | - |
| 15 | efd40f1 | 2026-02-20T00:38 | fix | flip container to canBeChildOf, fix nested nesting | - |
| 16 | 83dd8db | 2026-02-20T00:38 | fix | add canBeChildOf to NSG schema (Resource Group) | - |
| 17 | 6f76cdf | 2026-02-20T00:55 | fix | dynamic reparenting on drag and scaled container defaults | - |
| 18 | 728812f | 2026-02-20T00:57 | chore | add AGPL-3.0 license, README, and package metadata | - |
| 19 | c62e07f | 2026-02-20T00:58 | ci | add GitHub Actions build workflow | - |
| 20 | a2d91e3 | 2026-02-20T01:05 | docs | update roadmap with Phase 1-6 completion | - |
| 21 | dda591f | 2026-02-20T01:27 | feat | Phase 7 - project system and terraform execution | - |
| 22 | 066b8ef | 2026-02-20T01:36 | feat | welcome screen with recent projects | - |
| 23 | 5849ca0 | 2026-02-20T01:44 | feat | Phase 8 - deployment status on diagram nodes | - |
| 24 | 8ba1a74 | 2026-02-20T01:59 | feat | Phase 9 - undo/redo, validation, dirty tracking, shortcuts | - |
| 25 | 5749bba | 2026-02-20T02:02 | fix | undo/redo structuredClone error and select-all delete | - |
| 26 | 02ae0f8 | 2026-02-20T02:06 | fix | rewrite undo/redo to snapshot after mutations | - |
| 27 | 2c9182f | 2026-02-20T02:10 | fix | debounce property edits for undo coalescing | - |
| 28 | 56032cb | 2026-02-20T02:20 | feat | Phase 10 - diagram export (PNG, clipboard) and doc gen | - |
| 29 | e8ee0a9 | 2026-02-20T02:31 | fix | align PNG export with official Svelte Flow approach | - |
| 30 | 0b8cb20 | 2026-02-20T02:36 | docs | add Phases 11-13 to roadmap | - |
| 31 | 600cc26 | 2026-02-20T02:40 | docs | add frameless UI, hover details, auto-CIDR to roadmap | - |
| 32 | faf1ed3 | 2026-02-20T10:08 | feat | Phase 11 - frameless UI, collapsible palette, container styling | - |
| 33 | 735e253 | 2026-02-20T10:20 | feat | replace icons with official Azure SVGs | - |
| 34 | 16263a4 | 2026-02-20T10:37 | feat | Phase 12 - handle labels, edge labels, connection validation | - |
| 35 | 1fa5ba8 | 2026-02-20T10:55 | refactor | remove redundant containment edges, derive parent refs | - |
| 36 | b904e2d | 2026-02-20T11:16 | feat | add Storage Account, App Service, Key Vault resources + resolveTerraformType | - |
| 37 | 259b6a7 | 2026-02-20T11:19 | feat | add official Azure SVG icons for new resources | - |
| 38 | 4d763c2 | 2026-02-20T11:23 | fix | namespace SVG gradient IDs to prevent color collisions | - |
| 39 | e0b7ecc | 2026-02-20T11:25 | fix | use ResourceTypeId in diagram-converter getSchema parameter | - |
| 40 | 44b566c | 2026-02-20T11:42 | docs | fix Gantt chart, add phases 13-15 to roadmap | - |
| 41 | 81d1e14 | 2026-02-20T11:44 | docs | use realistic dates in roadmap Gantt chart | - |
| 42 | 4b72b9f | 2026-02-20T11:47 | docs | add monthly tick interval to Gantt chart | - |
| 43 | ba92756 | 2026-02-20T11:50 | docs | compress roadmap Gantt to realistic daily dates (Feb 1ΓÇôMar 7) | - |
| 44 | 53e6afd | 2026-02-20T13:58 | feat | Phase 15 - resource output bindings with decoupled acceptsOutputs system | - |
| 45 | 45563fb | 2026-02-20T14:55 | feat | Phase 16 - subscription container, variable management, tfvars generation | - |
| 46 | 2e221db | 2026-02-20T15:46 | feat | VS Code-style UI restructure with activity bar, editor tabs, and menus | - |
| 47 | 2480e4f | 2026-02-20T16:06 | feat | custom app icon, titlebar branding, and window state persistence | - |
| 48 | da920a1 | 2026-02-20T16:35 | feat | Phase 17 - auto-CIDR assignment, overlap detection, and CIDR validation | - |
| 49 | 6e12d14 | 2026-02-20T17:15 | feat | auto-layout, edge styles, canvas toolbar, and container resize improvements | - |
| 50 | f73316c | 2026-02-20T17:45 | feat | dark/light mode, SVG export, and multi-theme system with 8 palettes | - |
| 51 | 11dba59 | 2026-02-20T18:28 | feat | storage resources, snap-to-grid, app settings panel, and official Azure icons | - |
| 52 | 1b9b81d | 2026-02-20T19:08 | feat | add nightly builds and release-please versioning pipeline | - |
| 53 | 2612bc5 | 2026-02-20T14:13 | chore | release 0.1.1 | - |
| 54 | c7ac345 | 2026-02-20T19:16 | fix | build workspace packages before tauri-action in CI workflows | - |
| 55 | 487ccbd | 2026-02-20T19:26 | fix | use NSIS instead of MSI for Windows nightly builds | - |
| 56 | 68aba0d | 2026-02-21T01:01 | feat | restyle container nodes and add drag-drop containment validation | - |
| 57 | f8ca2a2 | 2026-02-21T01:33 | feat | replace NSG edge connections with property-based reference system | - |
| 58 | 30784d4 | 2026-02-21T01:44 | docs | update documentation to reflect NSG reference properties and completed phases | - |
| 59 | 0d46bb6 | 2026-02-21T22:59 | feat | add 12 new Azure resources across 3 new plugins | - |
| 60 | 020ae9a | 2026-02-21T23:49 | fix | migrate storage sub-resources from storage_account_name to storage_account_id | - |
| 61 | e50bee6 | 2026-02-21T23:49 | feat | add hybrid grid layout algorithm as project setting | - |
| 62 | 164c182 | 2026-02-21T23:50 | feat | replace resource icons with official Azure SVGs | - |
| 63 | fdc0c2f | 2026-02-21T23:51 | chore | bump Tauri app version to 0.1.1 | - |
| 64 | 9f8a4b2 | 2026-02-22T00:17 | feat | add canvas interactions - context menu, drag selection, copy/paste | - |
| 65 | 51b1957 | 2026-02-22T01:37 | feat | add project templates, unsaved changes protection, and VM improvements | - |
| 66 | e8cefe7 | 2026-02-22T01:50 | chore | bump version to 0.2.1 and update README with screenshot | - |
| 67 | c21d788 | 2026-02-23T18:40 | feat | add auto-regenerate toggle, property-as-variable, and RG containment | - |
| 68 | 4cdb36e | 2026-02-23T13:43 | chore | release 0.1.2 | - |
| 69 | 96ab2a2 | 2026-02-23T21:32 | feat | validation error highlights, variable-mode bypass, and real-time variables panel | - |
| 70 | b229c05 | 2026-02-23T21:43 | feat | add sensitive field support and credential validation to schemas | - |
| 71 | 7273dd8 | 2026-02-23T22:04 | feat | add project-level naming convention system | - |
| 72 | fa91fef | 2026-02-23T22:18 | feat | new project wizard with naming convention, layout, and edge style | - |
| 73 | 5b9502a | 2026-02-23T22:25 | refactor | move new project wizard inline into welcome screen | - |
| 74 | 8c7751d | 2026-02-23T23:19 | feat | VS-style 3-step new project wizard with naming convention UI | - |
| 75 | bb48594 | 2026-02-23T18:24 | chore | release 0.1.3 | - |
| 76 | d1aab02 | 2026-02-24T00:13 | feat | Azure subscription picker, minimap toggle, and tab context menu (v0.3.0) | 0.3.0 |
| 77 | 89508ee | 2026-02-24T00:15 | chore | commit Cargo.lock for reproducible builds | - |
| 78 | 77187b0 | 2026-02-24T00:21 | docs | update implementation roadmap to reflect completed phases | - |
| 79 | 19b3e38 | 2026-02-24T01:07 | feat | unified collapsible sections and search across all sidebar panels | - |
| 80 | 9adfe54 | 2026-02-24T01:12 | chore | bump version to 0.3.1 | - |
| 81 | d0cc051 | 2026-02-24T01:51 | feat | keyboard shortcuts, Help menu with shortcuts/about modals (v0.3.2) | 0.3.2 |
| 82 | 737f377 | 2026-02-24T13:48 | feat | QoL improvements - destroy confirmation, close protection, notifications, taskbar progress (v0.3.3) | 0.3.3 |
| 83 | 571c5f1 | 2026-02-24T16:00 | feat | Key Vault access control and collapsible property sections (v0.3.4) | 0.3.4 |
| 84 | ba7b5d8 | 2026-02-24T22:37 | fix | add cafAbbreviation and namingConstraints to all resource schemas | - |
| 85 | 89fd21c | 2026-02-24T22:55 | feat | template gallery completion and 3 new built-in templates (v0.3.3) | 0.3.3 |
| 86 | 19853d6 | 2026-02-24T23:18 | feat | add 8 Azure data & messaging resources (Redis, PostgreSQL, Cosmos DB, Service Bus) | - |
| 87 | a00015d | 2026-02-24T23:38 | feat | add Azure SVG icons for all 8 new data & messaging resources | - |
| 88 | b159130 | 2026-02-24T23:46 | fix | audit corrections for Redis Cache and Service Bus generators | - |
| 89 | f60e94c | 2026-02-25T00:05 | feat | add Route Table, Route, NAT Gateway, and Azure Bastion resources | - |
| 90 | f602bcf | 2026-02-25T00:10 | feat | add Azure SVG icons for Route Table, Route, NAT Gateway, and Bastion | - |
| 91 | 012d381 | 2026-02-25T00:20 | feat | add App Service Baseline (Zone-Redundant) template | - |
| 92 | 3228fe6 | 2026-02-25T00:31 | feat | add zone redundancy to App Service Plan + enhance App Service Baseline template | - |
| 93 | b17cc8c | 2026-02-25T00:35 | feat | add VNet integration to App Service + wire into baseline template | - |
| 94 | b5f3025 | 2026-02-25T00:40 | feat | add subnet service delegation + wire into App Service Baseline template | - |
| 95 | b93650f | 2026-02-25T00:46 | feat | add VNet Integration resource for visual NIC representation in subnet | - |
| 96 | 69f08ea | 2026-02-25T01:09 | feat | auto-spawn dashed reference edges for showAsEdge properties | - |
| 97 | 77c3aaf | 2026-02-25T01:19 | fix | replace $state+effects ref-edge approach with $derived | - |
| 98 | 6aabfcf | 2026-02-25T01:24 | fix | add ghost handles to all nodes for reference edge routing | - |
| 99 | a68a829 | 2026-02-26T00:49 | feat | add edge type framework with connection point management | - |
| 100 | 7da323c | 2026-02-26T01:03 | feat | add edge style settings with project-level defaults and per-edge overrides | - |
| 101 | 45e5dc4 | 2026-02-26T01:10 | fix | show actual default values in edge style dropdowns instead of 'Default' option | - |
| 102 | 2755d17 | 2026-02-26T01:15 | fix | show correct category default colors in edge style pickers | - |
| 103 | 41b8380 | 2026-02-26T01:17 | refactor | use muted industry-standard edge color palette | - |
| 104 | 4f7519f | 2026-02-26T01:20 | feat | edge styling system with project and per-edge overrides (v0.4.0) | 0.4.0 |
| 105 | c4d3395 | 2026-02-26T01:28 | fix | auto layout now considers all edge categories appropriately | - |
| 106 | 729a11c | 2026-02-26T01:52 | feat | handle-aware auto layout with edge weighting (v0.4.1) | 0.4.1 |
| 107 | 63eef1f | 2026-02-26T13:00 | feat | edge styling enhancements and visibility toggles (v0.4.2) | 0.4.2 |
| 108 | 6e19ab4 | 2026-02-26T14:21 | feat | selectable reference edges with handle placement (v0.4.3) | 0.4.3 |
| 109 | 50e4958 | 2026-02-26T15:13 | fix | use unique tags for each nightly build | - |
| 110 | a2de0ef | 2026-02-26T10:17 | chore | release 0.1.4 | - |
| 111 | 49493b6 | 2026-02-26T15:29 | fix | validate reference properties correctly | - |
| 112 | 3912cdd | 2026-02-26T15:38 | fix | restore version to 0.4.3 and sync release-please manifest | - |
| 113 | db187f6 | 2026-02-26T10:40 | chore | release 0.4.4 | - |
| 114 | d066ef5 | 2026-02-26T17:32 | fix | correct portable binary name in release and nightly workflows | - |
| 115 | 79ae6cf | 2026-02-26T20:23 | feat | add cost estimation panel (Phase 21) | - |
| 116 | bb5c6ad | 2026-02-26T22:01 | feat | add cost estimation panel (v0.5.0) | 0.5.0 |
| 117 | ff61f97 | 2026-02-26T22:05 | fix | move cost badges toggle into edge visibility dropdown (v0.5.1) | 0.5.1 |
| 118 | e9797ac | 2026-02-26T22:13 | fix | add explicit types to implicit-any arrow function parameters | - |
| 119 | 4df8775 | 2026-02-26T22:32 | fix | resolve remaining typecheck errors ΓÇö implicit any params and pluginRegistry export | - |
| 120 | a0f4e84 | 2026-02-26T22:40 | fix | introduce IReactivePluginRegistry interface for correct typecheck resolution | - |
| 121 | 0d54305 | 2026-02-26T22:41 | fix | import IReactivePluginRegistry before using in declare statement | - |
| 122 | 3e2c4a9 | 2026-02-26T22:46 | fix | resolve all typecheck errors ΓÇö IReactivePluginRegistry interface propagation | - |
| 123 | e3d8a69 | 2026-02-26T17:46 | chore | release 0.5.2 | - |
| 124 | b7445ea | 2026-02-26T23:23 | fix | make showAsEdge reference handles positionable via Manage Handles dialog | - |
| 125 | ff7b866 | 2026-02-26T23:24 | docs | update roadmap ΓÇö add Phase 21.9 Canvas Layout Tools and Phase 24 MCP Server | - |
| 126 | f737a35 | 2026-02-27T14:57 | feat | add MCP server for AI assistant integration (v0.6.0) | 0.6.0 |
| 127 | 4be6d91 | 2026-02-27T16:09 | feat | add structured logging with configurable log level (v0.7.0) | 0.7.0 |
| 128 | 660c182 | 2026-02-27T16:53 | feat | add canvas layout tools ΓÇö alignment, auto-fit, schema min sizes (v0.8.0) | 0.8.0 |
| 129 | fb8f136 | 2026-02-28T00:33 | feat | add .tstudio file extension with OS file association and single-instance handling (v0.9.0) | 0.9.0 |
| 130 | 9819acb | 2026-02-28T00:57 | feat | add multi-window support ΓÇö single process, multiple project windows (v0.10.0) | 0.10.0 |
| 131 | 571ffb4 | 2026-02-28T14:46 | feat | add MCP multi-window support ΓÇö per-window state, project targeting, property merge fix (v0.11.0) | 0.11.0 |
| 132 | ce93d74 | 2026-02-28T14:54 | feat | sync app settings across multiple windows | - |
| 133 | fee36bd | 2026-02-28T15:53 | fix | escape all user-supplied strings in HCL generation to prevent injection | - |
| 134 | 104f21d | 2026-02-28T16:49 | feat | security hardening, user secrets, about dialog & UX improvements (v0.12.0) | 0.12.0 |
| 135 | 489e35c | 2026-02-28T19:16 | feat | MCP query filtering, move/resize commands, containment validation & output control (v0.13.0) | 0.13.0 |
| 136 | 643dfdb | 2026-02-28T19:31 | fix | HCL generator issues ΓÇö os_type case sensitivity, deprecated swift connection, always-emit properties | - |
| 137 | d082c4e | 2026-02-28T19:38 | fix | show VNet integration as edge on canvas after swift connection removal | - |
| 138 | b443623 | 2026-02-28T19:41 | fix | add target handle to Subnet for VNet integration edge visibility | - |
| 139 | 544d8ac | 2026-03-01T15:56 | feat | Terraform module support ΓÇö visual grouping, HCL generation, collapse/expand & MCP commands (v0.14.0) | 0.14.0 |
| 140 | 6f29216 | 2026-03-01T16:07 | fix | module boundary visibility ΓÇö use front viewport portal, remove negative z-index | - |
| 141 | f3aaedc | 2026-03-01T16:29 | fix | module boundary/collapsed node visibility, handle dedup & layout | - |
| 142 | 05c336f | 2026-03-01T17:39 | fix | module HCL dedup, locals scope, stdin hang, draggable boundaries & file tree | - |
| 143 | 7b478db | 2026-03-01T18:42 | feat | module template reuse ΓÇö define once, instantiate many with variable overrides (v0.15.0) | 0.15.0 |
| 144 | f46eaab | 2026-03-02T22:36 | fix | module instance expand/collapse ΓÇö proper cloning, parenting & HCL isolation | - |
| 145 | e626117 | 2026-03-02T23:11 | fix | filter synthetic/transient nodes from all non-UI pipelines | - |
| 146 | 8e183b6 | 2026-03-02T23:22 | feat | enable variable toggle for select and boolean property types | - |
| 147 | 964f5d5 | 2026-03-03T00:34 | refactor | convert all HCL generators to use getPropertyExpression for variable toggle support | - |
| 148 | b64572b | 2026-03-03T00:47 | feat | enable variable toggle for array properties (address_space, dns_servers, etc.) | - |
| 149 | 2750398 | 2026-03-03T00:54 | fix | proper list(string) variable handling in tfvars and sidebar display | - |
| 150 | 4138bd5 | 2026-03-03T01:18 | fix | native array variable storage, UI disable in variable mode, optional array guards | - |
| 151 | 08a8c73 | 2026-03-03T01:39 | fix | clear terraform state, terminal output, and file tabs on project close/switch | - |
| 152 | ed7b3c3 | 2026-03-03T01:47 | fix | "New Project" closes current project and returns to welcome screen | - |
| 153 | 8417e7f | 2026-03-03T02:13 | docs | update all documentation for module system, variable toggle, and project structure | - |
| 154 | 8106b49 | 2026-03-03T02:15 | feat | universal variable toggle, array variables, project state cleanup (v0.16.0) | 0.16.0 |
| 155 | af72c4c | 2026-03-05T00:59 | test | add vitest test infrastructure with v8 coverage across all packages | - |
| 156 | d84644a | 2026-03-05T02:13 | feat | add AKS resources, subnet edges, MCP layout warnings, and validation error details | - |
| 157 | aa9054e | 2026-03-05T02:43 | feat | add 13 Azure resources, make Key Vault a container (v0.17.0) | 0.17.0 |
| 158 | c09cacc | 2026-03-05T02:58 | fix | MySQL DB requiresResourceGroup, container layout warnings in MCP (v0.17.1) | 0.17.1 |
| 159 | 4f60da0 | 2026-03-05T04:02 | feat | visual subnet placement, implicit PEP generation, ASP edge connections (v0.18.0) | 0.18.0 |
| 160 | 52f10b9 | 2026-03-05T04:09 | chore | suppress build warnings for Svelte a11y, Vite dynamic imports, and Rust dead code | - |
| 161 | dbd36bf | 2026-03-05T04:17 | chore | sync release-please manifest to v0.18.0 | - |
| 162 | 30e0301 | 2026-03-05T04:32 | fix | add repository field to desktop package.json | - |
| 163 | 4e994e6 | 2026-03-04T23:33 | chore | release 0.18.1 | - |
| 164 | a6c272e | 2026-03-05T22:26 | fix | correct Linux portable binary name in release workflow | - |
| 165 | 9b8e542 | 2026-03-05T22:39 | fix | convert ASP to leaf node, use edge for service plan references | - |
| 166 | 2cab47a | 2026-03-05T22:58 | fix | use fixed 220px width for resource nodes with label truncation | - |
| 167 | b71fdbd | 2026-03-06T00:16 | feat | compact node view with Visio-style icons and fixed node colors | - |
| 168 | 5c153ab | 2026-03-06T00:20 | chore | sync release-please manifest to v0.19.0 | - |
| 169 | 7f8420e | 2026-03-05T19:24 | chore | release 0.19.1 | - |
| 170 | f5f21d2 | 2026-03-06T00:59 | feat | add 7 new Azure resources with official icons and DNS Zone container (v0.20.0) | 0.20.0 |
| 171 | 61cb3e1 | 2026-03-05T20:01 | chore | release 0.20.1 | - |
| 172 | 07e9c58 | 2026-03-06T02:18 | feat | add AWS plugin support with template-driven provider selection and official icons (v0.21.0) | 0.21.0 |
| 173 | c01b46c | 2026-03-06T17:26 | feat | complete Azure cost estimation coverage, fix AWS connection rules and compact mode (v0.22.0) | 0.22.0 |
| 174 | 4f142fa | 2026-03-06T17:29 | feat | add AWS cost estimation for EC2, RDS, ALB, EIP, and NAT Gateway | - |
| 175 | 2a46b38 | 2026-03-06T17:43 | feat | add costEstimation schema blocks for AWS resources and Azure gaps | - |
| 176 | 3c032fc | 2026-03-06T17:46 | fix | render nested object arrays in sidebar instead of [object Object] | - |
| 177 | 8df798c | 2026-03-06T17:59 | feat | add 8 new AWS resources ΓÇö S3, IAM, CloudWatch, Lambda, API GW, DynamoDB, SQS, SNS (v0.23.0) | 0.23.0 |
| 178 | fd39749 | 2026-03-06T18:15 | fix | restrict variable toggle to button click only | - |
| 179 | f02ca21 | 2026-03-06T18:15 | feat | replace AWS icons with official AWS Architecture icons (v0.23.0) | 0.23.0 |
| 180 | 90fba48 | 2026-03-06T18:40 | feat | add 6 new AWS resources with official icons and cost calculators (v0.24.0) | 0.24.0 |
| 181 | a29bce7 | 2026-03-06T18:48 | feat | make EKS/ECS clusters containers, add child resources (v0.25.0) | 0.25.0 |
| 182 | 42d9181 | 2026-03-07T18:08 | feat | add multi-tab bottom panel system + 11 feature specs | - |
| 183 | 38aa17d | 2026-03-07T18:46 | feat | add canvas search in side panel with scoring, filters, and node navigation (v0.26.0) | 0.26.0 |
| 184 | 4d0ed78 | 2026-03-07T19:06 | feat | add connection wizard + rework status bar (v0.27.0) | 0.27.0 |
| 185 | 4177efb | 2026-03-07T20:08 | feat | add internationalization with 6 languages (v0.28.0) | 0.28.0 |
| 186 | 59691bf | 2026-03-07T20:32 | feat | add validation dashboard with problems panel (v0.29.0) | 0.29.0 |
| 187 | 109b6cf | 2026-03-07T20:41 | fix | improve WCAG AA contrast ratios for 4 light mode palettes (v0.29.1) | 0.29.1 |
| 188 | 8669e8f | 2026-03-08T02:37 | feat | add High Contrast palette + color-accent-text theme variable (v0.30.0) | 0.30.0 |
| 189 | 3d2907f | 2026-03-08T02:43 | feat | add 7 new palettes ΓÇö Solarized, Nord, Monokai, GitHub, 3 colorblind-safe | - |
| 190 | e724baf | 2026-03-08T02:45 | feat | status indicator icons + global focus-visible rings (v0.31.0) | 0.31.0 |
| 191 | b1323ec | 2026-03-08T03:31 | feat | ARIA accessibility, font scale system, reduced motion + settings UI (v0.32.0) | 0.32.0 |
| 192 | 39cdae3 | 2026-03-08T03:37 | feat | WCAG AA contrast audit + theme extensibility (Phase 1) | - |
| 193 | 9cce339 | 2026-03-08T03:40 | chore | remove 6 completed spec files | - |
| 194 | e527433 | 2026-03-08T03:53 | feat | add dependency graph view with DAG layout and highlight traversal (v0.33.0) | 0.33.0 |
| 195 | e5ce3a9 | 2026-03-08T13:14 | fix | i18n key typo, missing EC2 handle, and add i18n lint tests | - |
| 196 | 3ba754b | 2026-03-08T13:22 | fix | add edge rendering, bezier curves, and TB/LR direction toggle to dep graph | - |
| 197 | 8e5b648 | 2026-03-08T14:14 | feat | add diagram annotation sticky notes (v0.34.0) | 0.34.0 |
| 198 | 0a7ff08 | 2026-03-08T14:24 | feat | smart resource duplication with numeric suffixes + fix build warnings (v0.35.0) | 0.35.0 |
| 199 | 489d7d9 | 2026-03-08T14:29 | fix | smart duplication preserves zero-padding and updates resource name | - |
| 200 | b6b0969 | 2026-03-08T14:30 | chore | remove completed dependency graph view spec | - |
| 201 | 55fa8b1 | 2026-03-08T14:48 | feat | terraform plan visualization with node highlighting and diff view (v0.36.0) | 0.36.0 |
| 202 | af9532c | 2026-03-08T15:10 | feat | cost breakdown by container and module with distribution bar (v0.37.0) | 0.37.0 |
| 203 | 06a5e3c | 2026-03-08T15:12 | fix | exclude template modules from cost grouping when instances exist | - |
| 204 | a91613a | 2026-03-08T15:26 | fix | block browser context menu and F5 refresh, add dev tools menu entry | - |
| 205 | c51c5e9 | 2026-03-08T15:52 | docs | rewrite README with features, resource catalog, and architecture overview | - |
| 206 | a9ab6d8 | 2026-03-08T15:58 | fix | gate devtools API behind cfg(debug_assertions) for release builds | - |
| 207 | b8d4ee2 | 2026-03-08T10:58 | chore | release 0.20.2 | - |
| 208 | 83bd151 | 2026-03-08T16:38 | chore | sync release-please manifest to v0.37.0 | - |
| 209 | 7d4066f | 2026-03-08T16:40 | chore | restore version to 0.37.0 after release-please revert | - |
| 210 | b0f117a | 2026-03-08T11:41 | chore | release 0.37.1 | - |
| 211 | 88f9a93 | 2026-03-08T17:25 | chore | set up open-core license structure | - |
| 212 | 74cbdce | 2026-03-08T19:47 | fix | replace 12 placeholder icons with official Azure SVGs and improve MCP resource type tool | - |
| 213 | 137f01f | 2026-03-08T20:36 | feat | add draw.io-inspired connection UX with directional arrows and handle menu | - |
| 214 | 42d94b5 | 2026-03-08T21:30 | feat | connection UX improvements, grid snap, and space-to-pan (v0.38.0) | 0.38.0 |
| 215 | 9e04e79 | 2026-03-08T16:33 | chore | release 0.38.1 | - |
| 216 | 94ba0fe | 2026-03-08T22:38 | feat | multi-subscription HCL generation + new Azure resources (v0.39.0) | 0.39.0 |
| 217 | 673b729 | 2026-03-08T22:47 | fix | function app dotnet-isolated runtime and key vault rbac attribute name | - |
| 218 | b26b08d | 2026-03-08T23:02 | test | add costEstimation conformance check for all resource schemas | - |
| 219 | 69dcf07 | 2026-03-08T23:04 | chore | baseline 4 new i18n violations from plan/connection UX features | - |
| 220 | 3aaf777 | 2026-03-08T23:52 | docs | add version history changelog and update MCP port (v0.39.1) | 0.39.1 |
| 221 | c6fb94b | 2026-03-09T03:22 | fix | annotation positioning on load and cost panel crash on synthetic nodes | - |
| 222 | 1abf26b | 2026-03-12T11:53 | chore | Merge pull request #27 (release-please) | - |
| 223 | 5cd8e7e | 2026-03-13T12:23 | fix | remove redundant snap-on-drop that caused grid placement drift | - |
| 224 | 084cd22 | 2026-03-13T12:30 | fix | implement proper keyboard arrow key movement for canvas nodes | - |
| 225 | 7faa211 | 2026-03-13T13:05 | fix | simplify project creation to 2-step workflow | - |
| 226 | 0f000e2 | 2026-03-13T13:34 | fix | replace naming convention checkbox with toggle switch | - |
| 227 | 0dc2670 | 2026-03-13T17:53 | fix | canvas crosshair cursor and middle-click tab close | - |
| 228 | 7b06a5d | 2026-03-15T16:56 | feat | add Display Name field for canvas nodes | 0.39.0 |
| 229 | 9e11278 | 2026-03-15T17:02 | fix | inherit env/region naming tokens from parent Resource Group | - |
| 230 | fcd0bea | 2026-03-15T17:11 | fix | remove redundant naming_region field and fix slug extraction feedback loop | - |
| 231 | 30c5ece | 2026-03-15T17:24 | fix | decouple naming convention slug from computed name/label | - |
| 232 | 47fc4ea | 2026-03-15T17:32 | fix | restore naming_region shortcode field on Resource Group | - |
| 233 | 089e7a5 | 2026-03-15T17:38 | fix | keep label in sync with naming slug, simplify canvas label derivation | - |
| 234 | da16c3b | 2026-03-15T17:41 | fix | propagate RG naming overrides to nodes without a stored namingSlug | - |
| 235 | f1bc179 | 2026-03-15T17:52 | fix | derive naming region from RG location dropdown | 0.39.1 |
| 236 | f821a77 | 2026-03-15T18:09 | refactor | generalize naming token inheritance as schema-declared NamingTokenSource | - |
| 237 | c00c425 | 2026-03-15T19:00 | docs | add platform architecture plan for CLI + web + IPlatform | - |
| 238 | 8e38f6f | 2026-03-15T19:24 | feat | extract @terrastudio/project package (Phase A of platform architecture) | - |
| 239 | 3a85fa5 | 2026-03-15T19:31 | chore | update lockfile for @terrastudio/project package | - |
| 240 | 87c6f53 | 2026-03-15T19:50 | feat | delete MCP bridge, scaffold @terrastudio/cli (Phase B) | - |
| 241 | 59e3be9 | 2026-03-15T20:05 | feat | implement full MCP command parity in @terrastudio/cli | - |
| 242 | 23241e3 | 2026-03-15T20:14 | feat | add shared validation layer to @terrastudio/project and CLI | - |
| 243 | 2bc7e3c | 2026-03-15T21:31 | feat | Phase C — IProjectStorage interface + platform adapters | - |
| 244 | b91eead | 2026-03-15T21:39 | chore | centralize versioning and reorganize plugin packages | - |
| 245 | c669758 | 2026-03-15T21:45 | feat | implement full HCL generation pipeline in CLI (tstudio hcl generate) | - |
| 246 | 25ed887 | 2026-03-15T21:51 | feat | add project create and terraform command group to CLI | - |
| 247 | 7b0d76d | 2026-03-15T21:57 | feat | expand CLI resource and project config commands | - |
| 248 | 216b68c | 2026-03-15T22:03 | chore | bump version to 0.40.0 | 0.40.0 |
| 249 | 882d0a8 | 2026-03-15T22:09 | feat | add CLI standalone binary packaging and release workflow | - |
| 250 | e1561ce | 2026-03-15T22:14 | feat | add CLI install scripts and npm publish on release | - |
| 251 | 2da3469 | 2026-03-15T22:16 | chore | bump version to 0.41.0 | 0.41.0 |
| 252 | c2e732b | 2026-03-15T22:23 | chore | sync release-please manifest to 0.41.0 | 0.41.0 |
| 253 | 229e6e2 | 2026-03-15T22:24 | chore | release 0.41.1 | 0.41.1 |
| 254 | e3d69b9 | 2026-03-15T22:45 | fix | use direct pkg binary path to avoid conflict with npm pkg command | - |
| 255 | f3b746a | 2026-03-15T22:46 | fix | switch npm publish to OIDC trusted publishing (no token required) | - |
| 256 | ddfec77 | 2026-03-15T22:54 | fix | rename npm package to @afroze9/terrastudio-cli | - |
| 257 | 96a8859 | 2026-03-15T23:04 | fix | support manual release trigger in addition to release-please | - |
| 258 | b8ee172 | 2026-03-15T23:22 | fix | remove email address from package author fields | - |
| 259 | 4929ca1 | 2026-03-15T23:22 | chore | release 0.41.2 | 0.41.2 |
| 260 | 5737ff7 | 2026-03-15T23:32 | fix | track CLI package in release-please and bump to 0.41.2 | 0.41.2 |
| 261 | 6c67ccd | 2026-03-15T23:32 | chore | release master | - |
| 262 | 6a56c96 | 2026-03-15T23:39 | fix | remove manual release trigger, restore clean release-please flow | - |
| 263 | 90f1e1a | 2026-03-15T23:47 | fix | trigger build jobs when CLI package releases independently of desktop | - |
| 264 | 89abe38 | 2026-03-15T23:53 | fix | remove CLI from release-please tracking, gate all jobs on desktop release | - |
| 265 | 4aa0f67 | 2026-03-15T23:59 | fix | force release-please PR for pending fixes | - |
| 266 | 0cf439a | 2026-03-16T00:01 | fix | unblock release-please after tagging v0.41.3 | 0.41.3 |
| 267 | 392d4b9 | 2026-03-16T00:03 | fix | sync release-please manifest to v0.41.3 | 0.41.3 |
| 268 | fc61cd0 | 2026-03-16T00:04 | fix | trigger release after unblocking release-please | - |
| 269 | 72b7716 | 2026-03-16T00:05 | chore | release 0.41.4 | 0.41.4 |
| 270 | e70c08d | 2026-03-16T00:17 | fix | use npm publish with job-level id-token for OIDC trusted publishing | - |
| 271 | 03e2090 | 2026-03-16T00:30 | feat | add structured logging across diagram, HCL gen, terraform, and project ops | - |
| 272 | 9c5ef99 | 2026-03-16T00:34 | chore | release 0.41.5 | 0.41.5 |
| 273 | 40d65d6 | 2026-03-16T00:42 | fix | remove --provenance flag from npm publish (scoped package %2f encoding bug) | - |
| 274 | 8c1f869 | 2026-03-16T00:48 | fix | use Node 24 for npm publish to fix OIDC provenance 404 on scoped packages | - |
| 275 | 27d7fc6 | 2026-03-16T00:49 | fix | trigger release to verify npm OIDC publish with Node 24 | - |
| 276 | 5ef6b17 | 2026-03-16T00:49 | chore | release 0.41.6 | 0.41.6 |
| 277 | dde4960 | 2026-03-16T00:59 | fix | add repository url to cli package.json for npm provenance verification | - |
| 278 | 37ffab8 | 2026-03-16T00:59 | chore | prompt release-please to open next PR | - |
| 279 | 4cee821 | 2026-03-16T01:07 | fix | bump version to 0.41.7 and align cli package version | 0.41.7 |
| 280 | f4aa2ef | 2026-03-16T01:07 | chore | release 0.41.7 | 0.41.7 |
| 281 | 7f4e3e7 | 2026-03-22T01:16 | feat | add annotation plugin and remove old annotation system (#31) | - |
| 282 | 5562c9a | 2026-03-22T01:17 | chore | release 0.41.8 | 0.41.8 |
| 283 | f2ae436 | 2026-03-22T01:23 | docs | add resource audit and evaluation criteria checklist | - |
| 284 | 5897911 | 2026-03-22T01:49 | fix | resolve critical resource audit findings (#59, #74, #75, #76, #82, #84, #85, #86) | - |
| 285 | 6eef7a3 | 2026-03-22T01:54 | fix | resolve high-priority resource audit findings (#77, #81, #83, #87) | - |
| 286 | 90aeb5b | 2026-03-22T02:02 | fix | resolve high-priority resource audit findings (#63, #79, #80, #89) | - |
| 287 | bfa89a4 | 2026-03-22T02:07 | fix | resolve high-priority resource audit findings (#62, #64, #90, #91) | - |
| 288 | 2e607db | 2026-03-22T02:12 | fix | resolve high-priority resource audit findings (#60, #61, #88, #92) | - |
| 289 | 929db70 | 2026-03-22T11:40 | fix | resolve resource audit findings (#51, #65, #66, #67) | - |
| 290 | 8a18169 | 2026-03-22T11:49 | fix | resolve all remaining medium-priority resource audit findings | - |
| 291 | 606e0d5 | 2026-03-22T12:11 | fix | CLI crashes when bundled/installed due to import.meta.url in CJS (#48) | - |
| 292 | 5aefb50 | 2026-03-22T12:19 | chore | bump version to 0.42.0 | 0.42.0 |
| 293 | 66837b5 | 2026-03-22T12:23 | fix | update release-please manifest to 0.42.0 | 0.42.0 |
| 294 | c5a78ed | 2026-03-22T12:25 | docs | add release-please manifest to version bump checklist in CLAUDE.md | - |
| 295 | 63391b9 | 2026-03-22T12:25 | chore | release 0.42.1 | 0.42.1 |
| 296 | b318d9e | 2026-03-22T12:53 | fix | build CLI binaries on native OS instead of cross-compiling (#48) | - |
| 297 | 3380399 | 2026-03-22T12:54 | fix | bump version to 0.42.2 — native CLI builds | 0.42.2 |
| 298 | 6070ef6 | 2026-03-22T12:56 | chore | release 0.42.3 | 0.42.3 |
| 299 | 31c8fcf | 2026-03-22T13:17 | feat | auto-detect project path in CLI when run from project directory | - |
| 300 | eb4e9dd | 2026-03-22T13:18 | feat | bump version to 0.42.4 — CLI auto-detect project path | 0.42.4 |
| 301 | 75dd0e7 | 2026-03-22T13:19 | chore | release 0.42.5 | 0.42.5 |
| 302 | d4675dd | 2026-03-22T13:45 | feat | add node visual customization panel (#49) | - |
| 303 | d09b5e0 | 2026-03-22T13:50 | feat | bump version to 0.43.0 — node visual customization panel | 0.43.0 |
| 304 | 02c299d | 2026-03-22T14:08 | feat | add right-side activity bar with Properties and Visual Style panels (#49) | - |
| 305 | a3141ea | 2026-03-22T14:24 | fix | properties panel not filling right panel height | 0.43.1 |
| 306 | 222be01 | 2026-03-22T15:08 | feat | custom sticky note node with double-click creation (#49) | - |
| 307 | f051afe | 2026-03-22T15:47 | feat | node type visibility toggles (#33) | - |
| 308 | eee7334 | 2026-03-22T16:26 | fix | handle repositioning when toggling outputs on/off (#34) | - |
| 309 | 33cb6b6 | 2026-03-22T18:41 | feat | add Azure AI plugin with 8 resources | - |
| 310 | 91bf2cb | 2026-03-23T21:59 | feat | improve Azure AI plugin and fix CLI npm publish | 0.47.0 |
| 311 | b707553 | 2026-03-23T22:03 | chore | release 0.47.1 | 0.47.1 |
| 312 | 1193187 | 2026-03-23T22:05 | chore | Merge pull request #111 (release-please) | - |
| 313 | 146c115 | 2026-03-23T22:06 | fix | update lockfile after CLI dependency changes | - |
| 314 | cf5d5c4 | 2026-03-23T22:14 | chore | bump version to 0.47.2 to retrigger release | 0.47.2 |
| 315 | 49afeda | 2026-03-23T22:16 | chore | release 0.47.3 | 0.47.3 |
| 316 | 9ce7f30 | 2026-03-23T22:17 | chore | Merge pull request #112 (release-please) | - |
| 317 | c93b822 | 2026-03-23T22:37 | feat | interactive CLI wizard for project create and optional path | 0.48.0 |
| 318 | 1cfbd57 | 2026-03-23T22:39 | chore | release 0.48.1 | 0.48.1 |
| 319 | fbdddd6 | 2026-03-23T22:39 | chore | Merge pull request #113 (release-please) | - |
| 320 | 5c9d694 | 2026-03-23T23:34 | fix | drop macOS x86_64 release build | 0.48.2 |

