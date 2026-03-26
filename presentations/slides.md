---
theme: default
title: Building TerraStudio with AI
info: |
  One Developer, 338 Commits, 33 Days - A case study in AI-assisted development
class: text-center
drawings:
  persist: false
transition: slide-left
---

# Building TerraStudio with AI

**Afroze Amjad**

Associate Director Engineering

---

# What This Session Covers

<v-clicks>

- Can <span class="font-extrabold text-teal-400">one developer + AI</span> build a <span class="font-extrabold text-teal-400">production-grade</span> desktop app from scratch?
- What breaks when AI writes <span class="font-extrabold text-teal-400">80%</span> of the code?
- Hard numbers: velocity, bugs, cost, and the <span class="font-extrabold text-teal-400">"fix tax"</span>
- <span class="font-extrabold">Key Takeaways</span>

</v-clicks>


---

# The Use Case

Build a full desktop <span class="font-extrabold text-teal-400">infrastructure-as-code visual editor + CLI</span> from zero

<v-clicks>

- <span class="font-extrabold">Visual canvas</span> for designing Azure/AWS architectures with drag-and-drop
- <span class="font-extrabold">Terraform HCL generation</span>, execution, and plan visualization
- <span class="font-extrabold text-teal-400">72+ cloud resources</span> across Azure (50+), AWS (14+), and Azure AI (8)
- Cost estimation, modules, <span class="font-extrabold">i18n</span> (6 languages), <span class="font-extrabold">accessibility</span> (WCAG AA)
- <span class="font-extrabold">CLI</span> with HCL generation, project wizard, and native binary packaging

</v-clicks>

---

# The Use Case

<div class="grid grid-cols-3 grid-rows-2 gap-2 h-100">
  <img src="/canvas-view.png" class="rounded-lg w-full h-full object-cover col-span-2 row-span-1" />
  <img src="/resource-palette.png" class="rounded-lg w-full h-full object-cover row-span-2" />
  <img src="/plan-view.png" class="rounded-lg w-full h-full object-cover" />
  <img src="/cli.png" class="rounded-lg w-full h-full object-cover" />
</div>

---

# The Traditional Way

Building this without AI - estimated timeline for a small team:

<div class="mt-6 space-y-3">
  <div class="flex items-center gap-3">
    <div class="w-44 text-right text-sm font-medium">Full-stack Dev</div>
    <div class="relative h-8 flex-1">
      <div class="absolute inset-y-0 left-0 w-full rounded opacity-10 bg-slate-500" />
      <div class="absolute inset-y-0 left-0 rounded flex items-center pl-3 text-white text-xs font-bold" style="width: 100%; background: linear-gradient(90deg, #0d9488, #0f766e);">4–6 months</div>
    </div>
  </div>
  <div class="flex items-center gap-3">
    <div class="w-44 text-right text-sm font-medium">UI / UX</div>
    <div class="relative h-8 flex-1">
      <div class="absolute inset-y-0 left-0 w-full rounded opacity-10 bg-slate-500" />
      <div class="absolute inset-y-0 left-0 rounded flex items-center pl-3 text-white text-xs font-bold" style="width: 50%; background: linear-gradient(90deg, #14b8a6, #0d9488);">2–3 months</div>
    </div>
  </div>
  <div class="flex items-center gap-3">
    <div class="w-44 text-right text-sm font-medium">Cloud Architect</div>
    <div class="relative h-8 flex-1">
      <div class="absolute inset-y-0 left-0 w-full rounded opacity-10 bg-slate-500" />
      <div class="absolute inset-y-0 left-0 rounded flex items-center pl-3 text-white text-xs font-bold" style="width: 33%; background: linear-gradient(90deg, #2dd4bf, #14b8a6);">1–2 months</div>
    </div>
  </div>
  <div class="flex items-center gap-3">
    <div class="w-44 text-right text-sm font-medium">DevOps / CI</div>
    <div class="relative h-8 flex-1">
      <div class="absolute inset-y-0 left-0 w-full rounded opacity-10 bg-slate-500" />
      <div class="absolute inset-y-0 left-0 rounded flex items-center pl-3 text-white text-xs font-bold" style="width: 33%; margin-left: 33%; background: linear-gradient(90deg, #f59e0b, #d97706);">1–2 months</div>
    </div>
  </div>
  <div class="flex items-center gap-3">
    <div class="w-44 text-right text-sm font-medium">QA / Testing</div>
    <div class="relative h-8 flex-1">
      <div class="absolute inset-y-0 left-0 w-full rounded opacity-10 bg-slate-500" />
      <div class="absolute inset-y-0 left-0 rounded flex items-center pl-3 text-white text-xs font-bold" style="width: 83%; margin-left: 17%; background: linear-gradient(90deg, #fbbf24, #f59e0b);">Ongoing</div>
    </div>
  </div>
  <div class="flex items-center gap-3 mt-1">
    <div class="w-44" />
    <div class="flex-1 flex justify-between text-xs opacity-40 px-1">
      <span>Month 1</span><span>Month 2</span><span>Month 3</span><span>Month 4</span><span>Month 5</span><span>Month 6+</span>
    </div>
  </div>
</div>

<v-click>

<div class="text-center text-2xl mt-4 font-bold">
  We did it in <span class="text-teal-400">33 days</span>
</div>

</v-click>

---

# The Journey: 33 Days, 5 Weeks

<div class="flex gap-6 h-96">
<div class="flex flex-col items-center">
  <div class="w-4 h-4 rounded-full bg-teal-500 ring-4 ring-teal-500/20 z-10" />
  <div class="w-0.5 flex-1 bg-slate-500/40" />
  <div class="w-4 h-4 rounded-full bg-teal-500 ring-4 ring-teal-500/20 z-10" />
  <div class="w-0.5 flex-1 bg-slate-500/40" />
  <div class="w-4 h-4 rounded-full bg-teal-500 ring-4 ring-teal-500/20 z-10" />
  <div class="w-0.5 flex-1 bg-slate-500/40" />
  <div class="w-4 h-4 rounded-full bg-amber-500 ring-4 ring-amber-500/20 z-10" />
  <div class="w-0.5 flex-1 bg-slate-500/40" />
  <div class="w-4 h-4 rounded-full bg-amber-500 ring-4 ring-amber-500/20 z-10" />
</div>
<div class="flex flex-col justify-between text-sm">
  <div>
    <div class="font-bold">Week 1</div>
    <div class="opacity-80">Monorepo scaffold, 48-commit marathon, containers, undo/redo, theming, 20+ Azure resources</div>
  </div>
  <div>
    <div class="font-bold">Week 2</div>
    <div class="opacity-80">Cost estimation, MCP server, multi-window, modules, templates</div>
  </div>
  <div>
    <div class="font-bold">Week 3</div>
    <div class="opacity-80">AWS plugin (14 resources), i18n, accessibility, dependency graph</div>
  </div>
  <div>
    <div class="font-bold">Week 4</div>
    <div class="opacity-80">Naming system collapse (7 fixes), CLI extraction, release pipeline hell (21 fixes)</div>
  </div>
  <div>
    <div class="font-bold">Week 5</div>
    <div class="opacity-80">Resource audit (30 issues found), Azure AI plugin, CLI wizard</div>
  </div>
</div>
</div>

<v-click>

<span class="font-extrabold">Weeks 1-3</span>: <span class="text-teal-400 font-extrabold">28%</span> fix rate. <span class="font-extrabold">Weeks 4-5</span>: <span class="text-amber-400 font-extrabold">47%</span> fix rate. <span class="font-extrabold">48 versions</span> shipped.

</v-click>

---

# The Journey: Interactive Timeline

<div class="flex items-center gap-12 mt-8">
  <img src="/timeline-qr.png" class="w-48 h-48 rounded-lg" />
  <div>
    <a href="https://afrozeamjad.com/projects/terrastudio/timeline.html" target="_blank" class="text-xl underline">
      Open Interactive Timeline
    </a>
  </div>
</div>

---

# The Ship-Then-Fix Pattern

Every major feature followed this cadence - <span class="font-extrabold text-amber-400">16 instances</span> across the project:

<div class="flex flex-col items-center gap-1 mt-4">
  <div class="px-4 py-1.5 rounded bg-teal-500/20 border border-teal-500/40 font-bold text-sm">Ship feature (1-2 commits)</div>
  <div class="opacity-40">↓</div>
  <div class="px-4 py-1.5 rounded bg-amber-500/20 border border-amber-500/40 font-bold text-sm">Discover 2-5 issues</div>
  <div class="opacity-40">↓</div>
  <div class="px-4 py-1.5 rounded bg-slate-500/20 border border-slate-500/40 font-bold text-sm">Fix in rapid succession</div>
  <div class="opacity-40">↓</div>
  <div class="px-4 py-1.5 rounded opacity-40 border border-current text-sm">Move on → repeat</div>
</div>

---

# The Fix Chains

Every major subsystem had its own debugging saga - <span class="font-extrabold text-amber-400">48 total fix commits</span> across 6 chains:

<v-clicks>

<div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10 mt-2">
  <div class="font-bold text-sm w-52">npm Publish Pipeline</div>
  <div class="opacity-70 text-xs flex-1">OIDC, provenance, scoped packages, release-please - 7 patch versions, zero features</div>
  <div class="font-bold text-amber-400 text-xs">21 fixes</div>
</div>

<div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10 mt-2">
  <div class="font-bold text-sm w-52">Naming Conventions</div>
  <div class="opacity-70 text-xs flex-1">Slug → name → slug circular dependency. Each fix broke a different direction</div>
  <div class="font-bold text-amber-400 text-xs">7 fixes</div>
</div>

<div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10 mt-2">
  <div class="font-bold text-sm w-52">Module System</div>
  <div class="opacity-70 text-xs flex-1">Synthetic nodes leaked into HCL gen, export, save/load, and cost estimation</div>
  <div class="font-bold text-amber-400 text-xs">6 fixes</div>
</div>

<div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10 mt-2">
  <div class="font-bold text-sm w-52">Container Model</div>
  <div class="opacity-70 text-xs flex-1">canContain → canBeChildOf inversion cascaded through every container resource</div>
  <div class="font-bold text-amber-400 text-xs">5 fixes</div>
</div>

<div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10 mt-2">
  <div class="font-bold text-sm w-52">TypeScript Types</div>
  <div class="opacity-70 text-xs flex-1">Adding one reactive interface created implicit-any errors across the entire codebase</div>
  <div class="font-bold text-amber-400 text-xs">5 fixes</div>
</div>

<div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10 mt-2">
  <div class="font-bold text-sm w-52">Drag-and-Drop</div>
  <div class="opacity-70 text-xs flex-1">WebView2 ≠ browser - the most basic interaction took 4 attempts to get working</div>
  <div class="font-bold text-amber-400 text-xs">4 fixes</div>
</div>

</v-clicks>

---


# Where AI Failed - Every Time

<v-clicks>

<div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10 mt-2">
  <div class="font-bold text-sm w-52">Platform Blind Spots</div>
  <div class="opacity-70 text-xs flex-1">WebView2 DnD, Svelte 5 proxies, CJS/ESM</div>
  <div class="font-bold text-amber-400 text-xs">12+ fixes</div>
</div>

<div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10 mt-2">
  <div class="font-bold text-sm w-52">Wrong Architecture</div>
  <div class="opacity-70 text-xs flex-1">canContain → canBeChildOf, naming cycles</div>
  <div class="font-bold text-amber-400 text-xs">9 rewrites</div>
</div>

<div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10 mt-2">
  <div class="font-bold text-sm w-52">No Security Instinct</div>
  <div class="opacity-70 text-xs flex-1">HCL injection shipped for 12 versions</div>
  <div class="font-bold text-amber-400 text-xs">Retrofitted</div>
</div>

<div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10 mt-2">
  <div class="font-bold text-sm w-52">Cascading Blindness</div>
  <div class="opacity-70 text-xs flex-1">Module nodes leaked into every pipeline</div>
  <div class="font-bold text-amber-400 text-xs">6 fixes</div>
</div>

<div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10 mt-2">
  <div class="font-bold text-sm w-52">No Testing Initiative</div>
  <div class="opacity-70 text-xs flex-1">3 test commits out of 338 (0.9%)</div>
  <div class="font-bold text-amber-400 text-xs">30 audit issues</div>
</div>

<div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10 mt-2">
  <div class="font-bold text-sm w-52">CI/CD Incompetence</div>
  <div class="opacity-70 text-xs flex-1">npm publish saga</div>
  <div class="font-bold text-amber-400 text-xs">21 fixes</div>
</div>

</v-clicks>

<v-click>

<div class="text-center mt-4">

AI chose the wrong architecture <span class="font-extrabold text-amber-400">9 out of 9 times</span> when left to its own judgment.

</div>

</v-click>

---

# Before and After

<div class="grid grid-cols-2 gap-4 mt-2">
<div class="text-center font-bold opacity-60 text-sm">With AI</div>
<div class="text-center font-bold opacity-60 text-sm">Without AI</div>
</div>

<v-clicks>

<div class="grid grid-cols-2 gap-4 mt-2">
  <div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-teal-500/30 bg-teal-500/10">
    <div class="font-bold text-sm w-44">Time to product</div>
    <div class="font-bold text-teal-400 text-sm">33 days</div>
  </div>
  <div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-slate-500/30 bg-slate-500/10">
    <div class="font-bold text-sm w-44">Time to product</div>
    <div class="opacity-70 text-sm">4-6 months</div>
  </div>
</div>

<div class="grid grid-cols-2 gap-4 mt-2">
  <div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-teal-500/30 bg-teal-500/10">
    <div class="font-bold text-sm w-44">Human hours</div>
    <div class="font-bold text-teal-400 text-sm">~80-100 hrs*</div>
  </div>
  <div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-slate-500/30 bg-slate-500/10">
    <div class="font-bold text-sm w-44">Human hours</div>
    <div class="opacity-70 text-sm">~2,000-3,000 hrs</div>
  </div>
</div>

<div class="grid grid-cols-2 gap-4 mt-2">
  <div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-teal-500/30 bg-teal-500/10">
    <div class="font-bold text-sm w-44">Features shipped</div>
    <div class="font-bold text-teal-400 text-sm">48 versions, 72+ resources</div>
  </div>
  <div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-slate-500/30 bg-slate-500/10">
    <div class="font-bold text-sm w-44">Features shipped</div>
    <div class="opacity-70 text-sm">Same scope</div>
  </div>
</div>

<div class="grid grid-cols-2 gap-4 mt-2">
  <div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10">
    <div class="font-bold text-sm w-44">Bug rate</div>
    <div class="font-bold text-amber-400 text-sm">33% fix commits</div>
  </div>
  <div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-slate-500/30 bg-slate-500/10">
    <div class="font-bold text-sm w-44">Bug rate</div>
    <div class="opacity-70 text-sm">~10-15%</div>
  </div>
</div>

<div class="grid grid-cols-2 gap-4 mt-2">
  <div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10">
    <div class="font-bold text-sm w-44">Test coverage</div>
    <div class="font-bold text-amber-400 text-sm">0.9%</div>
  </div>
  <div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-slate-500/30 bg-slate-500/10">
    <div class="font-bold text-sm w-44">Test coverage</div>
    <div class="opacity-70 text-sm">40-70%</div>
  </div>
</div>

<div class="grid grid-cols-2 gap-4 mt-2">
  <div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-amber-500/30 bg-amber-500/10">
    <div class="font-bold text-sm w-44">Arch rewrites</div>
    <div class="font-bold text-amber-400 text-sm">9</div>
  </div>
  <div class="flex items-center gap-3 px-4 py-2 rounded-lg border border-slate-500/30 bg-slate-500/10">
    <div class="font-bold text-sm w-44">Arch rewrites</div>
    <div class="opacity-70 text-sm">1-2</div>
  </div>
</div>

</v-clicks>

---

# Takeaway 1: AI Is a Brilliant Junior Dev

AI produces <span class="font-extrabold text-teal-400">incredible velocity</span> but requires a human to catch every:

<div class="mt-4 space-y-3">
<v-clicks>
  <div class="flex items-center gap-4 px-5 py-3 rounded-xl bg-slate-500/15 border border-slate-500/30 ml-0">
    <div class="font-bold text-sm w-44">Architectural mistakes</div>
    <div class="text-sm opacity-80">9 wrong abstractions - wrong every time when left to its own judgment</div>
  </div>
  <div class="flex items-center gap-4 px-5 py-3 rounded-xl bg-slate-500/15 border border-slate-500/30 ml-8">
    <div class="font-bold text-sm w-44">Security vulnerabilities</div>
    <div class="text-sm opacity-80">HCL injection shipped undetected for 12 versions</div>
  </div>
  <div class="flex items-center gap-4 px-5 py-3 rounded-xl bg-slate-500/15 border border-slate-500/30 ml-16">
    <div class="font-bold text-sm w-44">Platform quirks</div>
    <div class="text-sm opacity-80">WebView2, CJS/ESM, npm OIDC - blind spots in every runtime</div>
  </div>
  <div class="flex items-center gap-4 px-5 py-3 rounded-xl bg-slate-500/15 border border-slate-500/30 ml-24">
    <div class="font-bold text-sm w-44">Cascading failures</div>
    <div class="text-sm opacity-80">Module nodes, naming cycles - fixes locally, breaks globally</div>
  </div>
</v-clicks>
</div>

<v-click>

<div class="flex gap-8 mt-6 items-center">
  <div class="px-5 py-2 rounded-lg bg-teal-500/15 border border-teal-500/30 text-center">
    <div class="text-xs opacity-60">Weeks 1-3</div>
    <div class="font-bold">28% fixes</div>
  </div>
  <div class="text-xl opacity-30">→</div>
  <div class="px-5 py-2 rounded-lg bg-amber-500/15 border border-amber-500/30 text-center">
    <div class="text-xs opacity-60">Weeks 4-5</div>
    <div class="font-bold">47% fixes</div>
  </div>
  <div class="text-sm opacity-70 ml-4">Velocity erodes when you move from building to hardening.</div>
</div>

</v-click>

---

# Takeaway 2: Architecture Is the New Bottleneck

The optimal approach is <span class="font-extrabold text-teal-400">architect-led, AI-accelerated development</span>:

<div class="mt-4 space-y-3">
<v-clicks>
  <div class="flex items-center gap-4 px-5 py-3 rounded-xl bg-teal-500/15 border border-teal-500/30 ml-0">
    <div class="font-bold text-sm w-20">Human</div>
    <div class="text-sm opacity-80">Design the architecture, security model, and CI pipeline</div>
  </div>
  <div class="flex items-center gap-4 px-5 py-3 rounded-xl bg-teal-500/15 border border-teal-500/30 ml-12">
    <div class="font-bold text-sm w-20">AI</div>
    <div class="text-sm opacity-80">Implement features at 10x speed</div>
  </div>
  <div class="flex items-center gap-4 px-5 py-3 rounded-xl bg-slate-500/15 border border-slate-500/30 ml-24">
    <div class="font-bold text-sm w-20">CI</div>
    <div class="text-sm opacity-80">Enforce tests and linting automatically</div>
  </div>
  <div class="flex items-center gap-4 px-5 py-3 rounded-xl bg-teal-500/15 border border-teal-500/30 ml-36">
    <div class="font-bold text-sm w-20">Human</div>
    <div class="text-sm opacity-80">Review before merge</div>
  </div>
  <div class="flex items-center gap-4 px-5 py-3 rounded-xl bg-amber-500/15 border border-amber-500/30 ml-48">
    <div class="font-bold text-sm w-20">Audit</div>
    <div class="text-sm opacity-80">Catch accumulated quality debt periodically</div>
  </div>
</v-clicks>
</div>

<v-click>

<div class="text-center mt-8 text-lg">

> The 33% fix tax is the price of velocity - and it compounds as complexity grows.
> The question isn't whether to pay it - it's whether your architecture and testing strategy can keep it from becoming the dominant cost.

</div>

</v-click>

---

# Questions?

<div class="flex gap-12 mt-8">
  <div class="flex items-center gap-4">
    <img src="/terrastudio-qr.png" class="w-36 h-36 rounded-lg" />
    <div>
      <div class="font-bold text-sm">TerraStudio</div>
      <a href="https://github.com/afroze9/terrastudio" target="_blank" class="text-sm underline opacity-70">github.com/afroze9/terrastudio</a>
    </div>
  </div>
  <div class="flex items-center gap-4">
    <img src="/devhistory-qr.png" class="w-36 h-36 rounded-lg" />
    <div>
      <div class="font-bold text-sm">This Analysis</div>
      <a href="https://github.com/afroze9/terrastudio-devhistory" target="_blank" class="text-sm underline opacity-70">github.com/afroze9/terrastudio-devhistory</a>
    </div>
  </div>
</div>
