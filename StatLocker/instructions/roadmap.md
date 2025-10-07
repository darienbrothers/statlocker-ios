**StatLocker AI 2.0:**  
**StatLocker could evolve into a true “AI-powered athlete platform”** — while preserving everything you already have (stats, goals, recruiting, onboarding, paywall, etc.).  
**AI-Powered StatLocker Vision**  
**“Your Game. Your Stats. Your DNA.”**

🔹 **1\. AI Layer Across the Entire App**

Instead of being *just another feature*, AI becomes the invisible assistant running *through* every module — constantly learning, predicting, and coaching.

| Area | Existing Feature | AI Upgrade |
| ----- | ----- | ----- |
| **Onboarding** | Sport, position, grad year, goals | 🧬 *AthleteDNA Builder*: GPT-powered quiz analyzes play style, mindset, and experience → auto-personalizes dashboard layout, season goals, and stat tracking tips. |
| **Dashboard / Locker** | Stat cards, trends | ⚡ *AI Coach Summary*: “Your saves increased 12% this week — your positioning has improved.” Natural-language recaps of progress and focus areas. |
| **Game Logging** | Manual input of stats | 🎯 *AutoStat OCR*: Camera or screenshot upload → detects and logs stats automatically. AI validates data for realism. |
| **Stats Tab** | Graphs and metrics | 📈 *Smart Insights*: “You perform 18% better in the 3rd quarter.” “Your clear percentage drops under pressure — work on quick resets.” |
| **Goals & Badges** | Manual goals, streaks | 🏆 *AI Goal Generator*: Recommends realistic stretch goals based on historical data and peers at similar levels. AI tracks emotional and effort patterns. |
| **Skills / Drills** | Library \+ progress | 🤖 *AI Skill Recommender*: Suggests drills to fix weaknesses. Example: “Your lateral reaction time is lagging — try Reflex Wall Drill Level 2.” |
| **Recruiting** | School lists, roadmap | 🎓 *AI Recruiting Coach*: Creates tailored outreach emails, builds a dynamic recruiting roadmap (“You’re 60% ready for D2 targets”), and scores compatibility with schools. |
| **Messaging & Feedback** | Team and coach chat | 💬 *AI Feedback Analyzer*: Summarizes coach messages, surfaces positive/critical trends (“Coach praised your footwork improvement 3× this month”). |
| **Parent Mode** | View dashboard | 👨‍👩‍👧 *AI Family Insights*: Generates easy-to-read summaries (“London’s save percentage climbed 7% this month — confidence trend improving”). |

**2\. Core AI Features**

🧬 **AthleteDNA Profile**  
A “living” model of the athlete combining:

* Stat patterns  
* Position playstyle  
* Mental & physical goals  
* Skill completion history  
  → Used to personalize drills, insights, and recruiting recommendations.

💬 **AI Locker Chat (Your AI Coach)**  
Built with OpenAI’s API \+ Firebase memory layer.

* “What should I work on before playoffs?”  
* “Why did my save percentage drop last game?”  
* “Generate a weekly training plan.”  
* “Write an email to the coach at Boston College.”

This chat lives inside the Dashboard as **“Ask StatLocker AI”** with voice input (using **expo-speech** or OpenAI Realtime API later).  
🔍 **StatGraph AI**  
Auto-generated visualizations:

* Trends (save %, shot %, efficiency)  
* Heatmaps or zone-based charts  
* Comparison vs. previous games or teammates

🧩 **Smart Notifications**  
Push AI reminders:

* “You’re one game away from your best streak.”  
* “Try 10 wall-ball reps today to stay on pace for your goal.”

🔹 **3\. AI-Enhanced Recruiting Flow**

StatLocker already has the structure — we enhance it with:

* **AI Resume Builder:** Pulls stats \+ bio → outputs polished PDF/email template.  
* **AI School Matcher:** Uses recruiting data \+ preferences → ranks schools by “fit score.”  
* **Roadmap Assistant:** “You’re missing 1 game highlight and 1 transcript upload to reach 80% recruiting readiness.”

🔹 **4\. In-App AI Architecture**

To keep performance and privacy solid:

1. **Local state:** Zustand or Firebase local cache for stat data.  
2. **Cloud AI:** OpenAI API for natural-language \+ analytics tasks.  
3. **Serverless functions (Firebase or Supabase Edge):** For periodic AI jobs like generating insights post-game.  
4. **Realtime Firestore listener:** Updates dashboards instantly after AI runs analytics.

🔹 **5\. AI Monetization Tiers**

| Tier | Access | Example |
| ----- | ----- | ----- |
| **Free Trial (7-Day)** | Limited AI summaries | “Basic stat recap after each game.” |
| **Pro ($9.99/mo)** | Full AI Coach \+ Recruiting Assistant | Personalized insights, roadmap creation, auto-emails |
| **Elite ($19.99/mo)** | Everything \+ StatGraph AI & AutoStat OCR | Advanced breakdowns, multi-team sync, smart comparisons |

🔹 **6\. Example User Flow**

1. Athlete finishes a game → logs stats.  
2. AI analyzes game → generates:  
   * “Performance Summary” card  
   * Updated goals & recommendations  
   * Drill suggestions  
3. Athlete opens Dashboard next morning → sees:  
   “You saved 72% of shots from the left side — strongest this season.”  
   “Work on clears under pressure (58% success). Try the Quick Reset Drill.”

🔹 **7\. Next-Gen Features (Future)**

* 🏋️‍♂️ *AthleteDNA Analytics Cloud* — compare trends across seasons.  
* 🧍‍♂️ *AI Ghost Competitor* — simulate progress vs. D1 benchmarks.  
* 🔊 *Voice AI Feedback* — spoken post-game summaries.  
* 🔗 *AI Recruiting Network* — coaches get AI-verified player insights, reducing scouting time.

**StatLocker: AI Roadmap (Overview)**  
**Vision**

* **Tagline:** Your Game. Your Stats. Your DNA.  
* **Promise:** AI that learns your game, turns stats into coaching, and makes recruiting simple.  
* **Pillars:** AthleteDNA™, AI Coach (chat \+ ambient summaries), StatGraph AI™ (smart visual insights), AutoStat OCR (assistive logging).

**End-to-End Experience (Welcome → Everyday Use)**

1. **Welcome**  
* Crisp hero: “Your Game. Your Stats. Your DNA.”  
* Single CTA → “Let’s personalize your locker.”  
1. **Onboarding 2.0 (AthleteDNA-first)**  
* Team identity: Boys/Girls, grad year, level, club toggle.  
* Position (primary/secondary) → shows position-specific stat preview.  
* Season goals picker (top 3 suggested by position).  
* **AthleteDNA Quick Quiz (6–8 micro Qs)**: focus, conditioning, preferred session length, confidence trend.  
* Review \+ Start 7-Day Trial → “Enter Locker.”  
* First-use nudge: “Log your first game or try OCR to scan your scorebook.”  
1. **Dashboard (Locker)**  
* **AI Coach Summary** (top): one-liner improvement \+ 1 drill suggestion.  
* **Key tiles** (position-aware): Save %, Shots Faced, Saves, Goals Allowed (trends).  
* **Goals pace** meters (On track / Catch up).  
* **Today’s Plan**: quick drill (2–8 mins) \+ optional micro-habit.  
* Secondary: Recent Games (tap for AI post-game summary), Upcoming, Badges/Streaks.  
* Global FAB: **Log Game** (secondary: Scan with OCR).  
1. **Stats Tab (Deep Intelligence)**  
* Trends (with AI callouts), Situational cuts (quarter, home/away), Comparisons (last 5 vs season; HS vs Club).  
* “What changed?” explainer after big swings.  
* Shareable season card (AI one-liner).  
1. **Goals & Achievements**  
* Pre-filled by position; AI Pacekeeper nudges & micro-adjusts.  
* “What to do next” drill from Skills.  
* Badges & streaks with unlock criteria and dates.  
1. **Skills / Drills**  
* Library filters: position, skill type, time, difficulty.  
* **AI prescriptions** based on AthleteDNA gaps; daily micro-plan.  
* Quick tracking: done/partial/skipped \+ perceived effort.  
1. **Recruiting**  
* Athlete profile (stats snapshot, bio, academics, highlights link, transcript).  
* **Roadmap** by grad year & target divisions \+ **Readiness Score**.  
* **AI Email Builder** for outreach (subject, body, follow-ups).  
* **School Fit** ranking with AI assistance (location, division, size, academics).  
1. **Parent Mode**  
* Read-only dashboards; weekly “What to celebrate” digest.  
1. **Notifications & Rituals**  
* Post-game: AI summary.  
* Morning: 1 quick plan suggestion.  
* Weekly review (Sun): “3 wins, 1 focus, next week’s plan.”  
* Milestones & streak protection nudges.

**Pricing & Packaging (with Quotas)**

**Free 7-Day Trial**

* Full experience preview with light caps: \~3 AI summaries, 1 OCR scan, 1 recruiting email.

**Pro (Individual)**

* AI Coach, StatGraph AI, Goals/Skills AI.  
* Example caps: \~6 AI summaries/mo, 3 OCR scans/mo, 10 drill recs/mo.

**Elite (Individual)**

* Everything in Pro \+ advanced comparisons/deeper analyses, priority support.  
* Example caps: \~20 AI summaries/mo, 10 OCR scans/mo; unlimited drill recs.

**Family (2–4 seats)**

* Shared billing; Parent Mode+; seat-based quotas (choose Pro or Elite per seat).  
* Cross-athlete celebration digest optional.

**Upsell moments (tastefully placed):**

* After first AI post-game summary (“Unlock full weekly reports”)  
* When hitting OCR/summary caps  
* On recruiting readiness thresholds (“Enable AI Email Builder to finish this step”)

**Phased Rollout (Zero tech details—pure product)**

**Phase 0 – Foundations (Weeks 0–4)**  
Onboarding 2.0 • Dashboard v1 (AI summary \+ tiles \+ goals) • Log Game v1 • Trial+Paywall v1 • Weekly Review v1  
**Phase 1 – Performance Intelligence (Weeks 5–8)**  
Stats Tab (Trends \+ callouts) • Skills AI micro-plans • Goals Pacekeeper \+ Badges v1 • Shareable season card  
**Phase 2 – Assistive Capture & Recruiting (Weeks 9–12)**  
AutoStat OCR v1 • Recruiting Profile \+ Roadmap \+ AI Email Builder • Parent Mode read-only \+ Celebrate digest  
**Phase 3 – Depth & Community (Weeks 13–16)**  
Advanced comparisons • (Optional) Messaging \+ AI digests • Family seats \+ cross-athlete rollups  
**North-Star & KPIs**

* **North Star:** Weekly Active Improvement \= % of athletes who either log a game or complete an AI-recommended drill weekly.  
* Activation (onboarding completion → trial start), time-to-first-insight, D7/D30 retention, trial→paid conversion, Pro→Elite uplift, drills completed/week, recruiting roadmap completion, NPS.

**Guardrails & Trust**

* Crystal-clear consent for AI use; delete/export AthleteDNA anytime.  
* Non-judgmental tone; celebrate wins alongside fixes.  
* Age-appropriate defaults; parent visibility controls.

A true **MVP (Minimum Viable Product)** for StatLocker AI should **prove the core habit**:  
➡️ *Athletes log their games consistently, see progress, and feel value fast.*  
So our MVP isn’t about “AI everywhere” yet — it’s about creating a **sticky daily/weekly loop** that keeps athletes logging.  
Let’s define this properly 👇  
🧩 **StatLocker MVP — Core Goal**  
“Make stat tracking effortless and rewarding so athletes build a habit before introducing deeper AI coaching.”  
**Primary KPI:**  
📈 *% of athletes who log at least 1 game per week (Week 2–4 retention)*  
🚀 **MVP Core Features (Phase 0 Launch)**  
1️⃣ **Authentication & Role**

* Simple sign up: **Email / Apple / Google**  
* Role: **Athlete** only (coach/parent later)  
* Store: first name, sport (Lacrosse), gender, grad year, position.

✅ *Goal:* 10-sec login, no friction.  
2️⃣ **Onboarding Flow (AthleteDNA Lite)**

* Screens:  
  1. **Welcome → “Your Game. Your Stats. Your DNA.”**  
  2. Choose: Boys/Girls team  
  3. Select Position (dynamic list)  
  4. Enter Grad Year  
  5. Choose Top 3 Season Goals (preset per position)  
  6. Review \+ “Enter Locker”

🎯 *Why this matters:* You’ll get personalized stat fields immediately (Goalie ≠ Attack).  
No quiz, no fluff — this is the fastest path to a personal Locker.  
3️⃣ **Dashboard (Locker)**

**Purpose:** Home for motivation \+ quick navigation.

| Section | Function |
| ----- | ----- |
| **Top Stat Cards** | Position-specific (e.g., Save %, Shots Faced, Saves, Goals Allowed) |
| **Season Goals Progress** | Simple bars showing “X of Y target” |
| **Recent Games** | List of last 3 logged games with headline stats |
| **FAB (Floating Action Button)** | “Log Game” — always visible, pulsing for first-time users |

✅ *Goal:* The athlete always knows:

1. Their season progress  
2. Their last performance  
3. Where to go next (FAB)

4️⃣ **Log Game Modal**  
**The heart of the MVP.**

| Feature | Details |
| ----- | ----- |
| **Dynamic Fields** | Based on position (Goalie vs. Attack vs. Midfield) |
| **Increment/Decrement Buttons** | \+ / \- for each stat field |
| **Auto-Calculated Stats** | e.g., Save % \= Saves ÷ Shots |
| **Notes Field (optional)** | “Felt strong on left side,” etc. |
| **Save Game Button** | Writes to Firestore |
| **AI Placeholder Summary (optional)** | “Great work — save % up 4% from avg.” (can use static logic before AI) |

✅ *Goal:* Logging feels fast, rewarding, and data auto-updates immediately on the dashboard.

5️⃣ **Stats Tab (Basic)**

Visualizes improvement without needing AI yet.

* Trend lines (Save %, Goals Allowed over time)  
* Per-game list (sortable)  
* Basic summary metrics (Season Avg Save %, Shots Faced, Goals Allowed)  
* Placeholder “AI Insights Coming Soon” banner (tease upgrade)

✅ *Goal:* Show progress → drive emotional reinforcement.  
6️⃣ **Goals Tab (Basic)**

* Shows the 3 goals selected during onboarding.  
* Manual completion tracking (auto-progress later).  
* Simple % bars (e.g., “You’re 60% to your 100-save goal”).  
* Add “+” button for new custom goal.

✅ *Goal:* Connect logging → progress → motivation loop.  
7️⃣ **Paywall (Free 7-Day Trial)**

* Unlocks:  
  * Advanced Insights (AI coach)  
  * Recruiting Roadmap  
  * Drill recommendations  
* Triggered after 3rd game logged or 7 days after onboarding.

✅ *Goal:* Hook users with visible value before the upsell.  
8️⃣ **Profile / Settings**

* Edit personal info  
* Manage subscription  
* “View My Stats Summary” (sharable image later)

💡 **Optional MVP Enhancers (If Time Allows)**

| Feature | Why Add It |
| ----- | ----- |
| **AutoStat OCR (Preview)** | Let users upload a photo → tease “AI detection coming soon.” |
| **Weekly Summary Email (Manual version)** | Send a motivational recap every Sunday. |
| **Empty State Tips** | If no games yet, show: “Tap \+ to log your first game\!” |
| **Gamified Feedback** | “🔥 Streak: 3 games in a row\!” |

🧭 **MVP Success Loop**  
1️⃣ Athlete logs game →  
2️⃣ Dashboard updates instantly →  
3️⃣ Athlete sees trend →  
4️⃣ Athlete hits small milestone →  
5️⃣ AI or motivational nudge keeps them logging.  
That’s the loop we must perfect before scaling to AI insights, drills, recruiting, etc.  
💰 **MVP Monetization Strategy**

| Plan | Description | Access |
| ----- | ----- | ----- |
| **Free 7-Day Trial** | Full access for first week | Logging, dashboard, stats, limited insights |
| **Pro ($9.99/mo)** | For motivated players | Adds AI summaries, goals pacing, weekly recaps |
| **Elite ($19.99/mo)** | For top performers | Adds OCR, recruiting tools, advanced analytics |
| **Family ($24.99/mo)** | 2–4 athlete seats \+ parent view | Shared billing \+ Parent digest |

**In-App Upsells:**

* After 3 logged games → “Unlock AI Coach for deeper breakdowns.”  
* After hitting a milestone → “Elite unlocks deeper season analytics.”  
* After 7 days → trial conversion screen with Pro/Elite comparison.

🧱 **MVP Phase Roadmap (No tech yet)**

**Phase 0 — Core MVP (Weeks 1–6)**

* Onboarding (Athlete setup \+ goals)  
* Dashboard  
* Log Game Modal  
* Stats Tab (trend view)  
* Goals Tab (progress view)  
* Free trial \+ paywall

**Phase 1 — AI Starter Layer (Weeks 7–10)**

* Simple post-game insights (“You saved 10/14 shots — 71%. Best this month.”)  
* AI Coach Chat (limited)  
* Weekly recap summary (auto-generated)  
* Drill suggestions (rule-based before full AI)

⚡ **MVP Core Message**

“StatLocker makes logging your games effortless — and turns your season into progress you can see.”  
This is the habit-creation phase.  
Once athletes log consistently and see value → we layer the AI on top.

Your *new version* is a **personalized AI athletic companion** that learns your game, builds your performance profile (AthleteDNA), and keeps you improving.

| Core Area | Before | Now |
| ----- | ----- | ----- |
| **Purpose** | Track stats & goals | Turn every logged stat into adaptive AI coaching |
| **Value Prop** | “Track your journey.” | “Your Game. Your Stats. Your DNA.” |
| **AI Role** | Optional insights | Core engine driving personalization |
| **User Habit** | Manual logging → view numbers | Log once → AI instantly gives meaning & next steps |
| **Retention Loop** | Stats \+ streaks | AI summaries \+ streaks \+ daily drill prompts |
| **Monetization** | Paywall by feature | Paywall by *AI capability tier* |
| **Scalability** | Sport-specific | Universal across sports (AI model adapts to any stat set) |

your **architecture, screens, and UI flow remain the same**, but:

* You now have a stronger *reason* to log consistently (AI summaries).

* You’ve embedded *AthleteDNA* as the central personalization layer.

* You’ve opened the door to expanding beyond lacrosse (soccer, hockey, basketball) with minimal friction.

Think of it like **StatLocker 2.0 — powered by AI**.

## **2️⃣ What’s Our True MOAT (Defensible Edge) Now?**

A strong SaaS \+ AI company needs a *compound advantage* — something that gets stronger as more users join.  
 Here’s yours:

### **🧩 1\. AthleteDNA Dataset (Proprietary Data Layer)**

* Every athlete generates unique *performance fingerprints* (stats, context, habits, mindset).

* The more games logged → the smarter StatLocker gets → better AI insights.

* Competitors can’t replicate this dataset without your scale.

**Analogy:** Duolingo’s moat \= user learning patterns.  
 **StatLocker’s moat \= athlete performance patterns.**

---

### **🧠 2\. Adaptive AI Coaching Engine**

Unlike static stat trackers (like Hudl or MaxPreps), StatLocker’s AI:

* Learns *each athlete’s improvement curve*

* Detects weaknesses automatically

* Suggests drills \+ goals dynamically

* Adjusts tone (motivational vs. analytical) based on personality.

That personalization \= stickiness \+ retention.

---

### **💪 3\. Emotional Design \+ Motivation Loop**

Your design ethos (“approachable, positive, gamified progress”) keeps users emotionally invested:

* AI voice \= encouraging coach, not judgmental critic.

* Rewards \+ badges \+ weekly “You got better” summaries → dopamine loop.

* Every session feels like progress, not paperwork.

This makes StatLocker the *Calm \+ Strava for athletes* — emotionally sticky.

---

### **💾 4\. Multi-Stakeholder Ecosystem**

* **Athletes** → AI performance engine.

* **Parents** → progress insights \+ family plans.

* **Coaches (future)** → team-level AI summaries.

Each new user type adds data → which improves AthleteDNA accuracy → which increases value for all users.  
 That’s network compounding.

---

### **💰 5\. Recurring Revenue \+ Lifetime Value Compounding**

Because your AI engine improves automatically with data:

* Each new feature (drill recs, recruiting roadmap, OCR) adds upsell layers.

* Families and schools become long-term contracts.

* High retention \= high LTV with low churn.

## **5️⃣ Recap: Your MVP’s North Star Loop**

**Action Loop \= The Moat.**

Log Game → See AI Summary → Get Encouraged → Set Next Goal → Log Again.

This loop **feeds your AthleteDNA**, **powers your AI engine**, and **increases retention** — all while you gather proprietary performance data.

#  **1️⃣ One-Page Pitch Sheet (for Partners & Press)**

**STATLOCKER — “Your Game. Your Stats. Your DNA.”**

### **🧠 The Vision**

StatLocker transforms raw athletic stats into personalized performance intelligence.  
 It’s where athletes *log their journey*, see *exactly how they’re improving*, and get *AI-powered coaching insights* that make them better every week.

### **🏆 The Problem**

Athletes record their stats but never know what they mean.  
 Coaches are busy, parents are guessing, and players lose motivation when progress isn’t visible.  
 Current apps track numbers — they don’t teach, motivate, or adapt.

### **🚀 The Solution**

StatLocker learns every athlete’s habits, strengths, and weaknesses through **AthleteDNA™** — an adaptive AI profile that grows smarter with every game logged.  
 It delivers instant post-game breakdowns, personalized drill plans, and recruiting roadmaps.

### **💥 Key Features**

* **AI Coach** – Instant summaries \+ motivational feedback after every game

* **StatGraph AI™** – Dynamic charts with intelligent callouts

* **GoalPace AI™** – Keeps athletes on track toward season targets

* **Recruiting Roadmap** – Turns data into a digital resume coaches love

* **Parent Mode** – Positive weekly digest of wins to celebrate

### **💰 Business Model**

7-day free trial → subscription tiers (Pro, Elite, Family).  
 High retention \= high LTV.  
 Each log grows the AthleteDNA dataset — StatLocker’s proprietary moat.

### **💫 Tagline**

“Track smarter. Improve faster. Own your story.”

---

# **🦈 2️⃣ Shark Tank-Style Elevator Pitch (No Funding Ask)**

“Hi Sharks — imagine every high-school athlete having a digital coach in their pocket.  
 They log a game, and within seconds, an AI tells them what improved, what to work on, and how close they are to their season goals.

That’s StatLocker — the first app that turns stats into strategy.  
 Built by D1 athletes, powered by AI, designed to make progress visible.

Our users don’t just see numbers — they see growth.  
 They log once and get better forever.  
 We’re not here for investment — we’re here to make athlete development personal again.”

---

# **💸 3️⃣ Pricing Matrix (v2 — Data-Driven)**

| Tier | Monthly | Yearly | Core Access | AI Access | Recruiting | OCR | Notes |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| **Free (Forever-Lite)** | $0 | — | Basic logging, dashboard, manual goals | 1 AI Summary / week | ❌ | ❌ | Keeps engagement high, top of funnel |
| **Pro** | $9.99 | $99 | Everything in Free \+ advanced stats & progress goals | 10 AI Summaries / month \+ weekly reports | ✅ (basic) | 2 scans/mo | Best for serious high-school players |
| **Elite** | $19.99 | $199 | All features unlocked | Unlimited AI Insights \+ drill plans | ✅ Full \+ Roadmap \+ Email Builder | Unlimited | Adds recruiting, OCR, and AI coaching depth |
| **Family Plan** | $24.99 | $249 | 2–4 athletes \+ Parent Mode+ | Shared AI Summaries | ✅ | ✅ | Great for multi-athlete households |

**Projected Numbers (Year 1 realistic):**

* 2 k paying users × avg $12 / mo \= $288 k ARR

* 10 k free users → upsell funnel 15–20 % conversion

* 80 %+ retention due to streaks \+ AI feedback loops

#  **4️⃣ Founder-Friendly Storyboard**

### ***“Welcome → First Log → First Insight → First Win”***

| Scene | Screen Copy | Emotional Hook |
| ----- | ----- | ----- |
| **1\. Welcome** | “Your Game. Your Stats. Your DNA.” CTA → Get Started | Curiosity \+ identity |
| **2\. Onboarding** | “Let’s build your Locker.” Step 1 → Choose Team Step 2 → Position Step 3 → Goals Step 4 → Quick Quiz | Momentum \+ ownership |
| **3\. Dashboard (Empty)** | “We’re ready when you are — log your first game\!” | Motivation to act |
| **4\. Log Game Modal** | “Every stat tells a story. Let’s record yours.” | Action \+ control |
| **5\. First AI Summary** | “🔥 Save % up 7 % this week — confidence pays off.” | Reward dopamine hit |
| **6\. Goal Progress View** | “You’re 60 % to your season goal. Stay locked in.” | Progress visualization |
| **7\. Paywall Moment** | “Ready for deeper insights? Go Pro to unlock AI Coach.” | Desire to level up |

# **5️⃣ User Journeys (Examples)**

### **Journey A — High-School Goalie**

1. Signs up → selects *Goalie | Varsity | Grad 2026*

2. Logs game (12 saves / 5 goals against)

3. Dashboard → “Save % \= 70 % (+5 % vs avg)”

4. AI recommends “Reflex Drill Level 2” → adds to Goals

5. After 3 games → Weekly Recap: “Consistency Unlocked Badge”

6. Upgrades to Pro for deeper trend analysis.

### **Journey B — Parent View**

1. Athlete invites parent to join Family Plan.

2. Parent dashboard shows “Wins of the Week.”

3. Receives email digest → “London’s save % improved 12 % this month.”

4. Parent shares achievement → social loop.

### **Journey C — College-Recruiting Athlete**

1. Logs consistent stats for 10 games.

2. AI generates Recruiting Profile \+ Email Template.

3. Adds Boston College to target list.

4. Progress bar → “80 % Recruiting Ready.”

5. Motivated to keep logging.

---

# **🏁 6️⃣ Onboarding Flow (Data \+ Purpose)**

### **Step-by-Step**

| Step | Field | How AI Uses It |
| ----- | ----- | ----- |
| 1\. Team Identity | Boys / Girls | Filters position sets \+ language tone |
| 2\. Grad Year | 2025–2028 | Drives recruiting timeline \+ roadmap |
| 3\. Level | Freshman / JV / Varsity | Benchmarks vs peers |
| 4\. Position | Goalie / Attack / Mid / Def / FOGO | Defines stat categories \+ AI focus areas |
| 5\. Club Toggle \+ Team Names | HS vs Club context | Enables dual-team comparisons |
| 6\. Season Goals (3) | Save % target / Saves / Clears | Trains GoalPace AI™ |
| 7\. AthleteDNA Quiz | Confidence level / Motivation style / Focus areas | Shapes AI Coach voice and drill tone |

**Immediate Outcome:**  
 Personalized dashboard \+ stat template \+ starter goals ready on day 1\.

**Bonus Tip:**  
 After onboarding, show “Simulated Stats” (1 sample game) → visual progress from the start.

# **7️⃣ In-App Copy & AI Voice Examples**

### **System Tone**

* Motivational, concise, non-judgmental

* Feels like a trusted coach \+ teammate hybrid

### **Examples**

| Context | Copy |
| ----- | ----- |
| **Empty Dashboard** | “Every stat tells your story — start logging to see yours unfold.” |
| **Log Confirmation** | “Locked in\! Your game’s added. Let’s see what the numbers say.” |
| **AI Summary (Pro)** | “You stopped 72 % of shots today — up 8 % from last week. Your reflex work is paying off.” |
| **Goal Progress** | “You’re on track to hit 100 saves by May. Keep stacking games.” |
| **Badge Unlocked** | “🏅 Consistency Badge earned — 3 games in a row. That’s how leaders train.” |
| **Paywall Prompt** | “Your stats are talking — AI Coach can translate them for you.” |
| **Parent Digest Subject** | “London’s Save % Up 12 % — Confidence Rising.” |
| **Notification Nudge** | “Quick reminder: a 5-min drill today keeps your reflex edge sharp.” |

Let’s make this section the **core of StatLocker’s “AI identity.”**  
 Below is a **deep dive** into each of the five 💥 key features — written as if this were the **legendary internal playbook** for the product, investors, and the dev team.

Each one includes:

* 🔍 *What it is*

* ⚙️ *How it works* (data, flow, UX)

* 🎯 *Why it matters / emotional value*

* 💎 *Future potential*

---

## **💥 1️⃣ AI Coach — “Your Personal Locker Room Genius”**

### **🔍 What It Is**

An **always-on AI performance coach** that translates your stats, patterns, and habits into personalized, actionable feedback — instantly after every logged game.

It’s not a chatbot — it’s a **context-aware analyst \+ motivator** who speaks the athlete’s language.

### **⚙️ How It Works**

* **Input:** Game stats (manual or OCR), position, opponent, location, and any quick notes.

* **Processing:**

  1. AI pulls trends from recent performances (e.g., last 5 games).

  2. Compares to season averages and goals.

  3. Generates a **short “Locker Summary”** in 2–3 sentences.

  4. Tone adjusts using **AthleteDNA personality** (confident, cautious, self-critical, etc.).

  5. Suggests 1 micro-action for tomorrow — e.g., “Run 8 mins of Reflex Drill 2 tonight.”

* **Output Example:**

   “🔥 You saved 74% of shots today — your best this season. Keep building that consistency. Try the Lateral Reflex Drill for 5 mins before your next game.”

### **🎯 Why It Matters**

* Creates an emotional connection after every log → *habit loop trigger*.

* Replaces “cold stats” with “human encouragement.”

* Builds loyalty — every athlete feels seen and guided.

### **💎 Future**

* Add **voice summaries** (“Hey London, that 74% save rate was clutch today.”)

* Multi-language support for global sports expansion.

* **Team-level AI Coach** for coaches to see player insights.

---

## **📊 2️⃣ StatGraph AI™ — “Your Game, Visualized Intelligently”**

### **🔍 What It Is**

Dynamic visual analytics powered by AI that automatically highlights meaningful patterns in an athlete’s performance.  
 It’s not just a chart — it’s **data storytelling** in motion.

### **⚙️ How It Works**

* **Input:** Logged game data (e.g., saves, shots, clears, goals).

* **Processing:**

  * AI detects patterns and anomalies (spikes, drop-offs).

  * Adds callouts directly to the chart.

  * Compares metrics by quarter, opponent type, or team level (HS vs. Club).

  * AI explains trends in natural language:

     “Save % is strongest in Q3 (+12% vs. avg). Focus drops slightly in last quarters.”

* **Output Examples:**

  * Visual: Trend line with auto-generated callout bubbles.

  * Text summary below: “Defensive performance trending upward since mid-April.”

### **🎯 Why It Matters**

* Visual progress makes improvement tangible.

* Athletes *feel* their growth → higher motivation \+ retention.

* Drives curiosity: “Why did that drop happen?” → deeper engagement with AI Coach.

### **💎 Future**

* Introduce **HeatMap AI** (shot locations & save zones).

* Allow athletes to compare to team or D1 benchmarks.

* “Share My Graph” social feature — AI creates highlight-style season graphics.

---

## **🎯 3️⃣ GoalPace AI™ — “Your AI Accountability Partner”**

### **🔍 What It Is**

A smart goal-tracking system that monitors each athlete’s progress toward season targets and keeps them on pace through gentle nudges, predictions, and drill suggestions.

### **⚙️ How It Works**

* **Input:**

  * Athlete’s 3–5 primary goals set during onboarding (e.g., “100 saves,” “75% save %,” “15 clears per game”).

  * Ongoing stat logs.

* **Processing:**

  * AI monitors pace vs. expected trajectory.

  * Detects early signs of falling behind.

  * Generates micro-coaching prompts like:

     “You’re pacing slightly below your 100-save goal — just 5 more saves per week keeps you on track.”

  * Auto-adjusts stretch goals when consistency increases.

* **Gamification:**

  * Progress bars turn green when “on pace.”

  * “Goal at Risk” alert with motivational AI copy.

  * Reward badges (“Clutch Consistency” / “Locked-In Performer”).

### **🎯 Why It Matters**

* Keeps users engaged long-term (they’re literally chasing goals).

* Prevents drop-offs mid-season.

* Adds emotional payoff every time progress improves.

### **💎 Future**

* Predictive AI pacing (e.g., “At your current rate, you’ll hit 100 saves by May 10th”).

* Shared team goals for group motivation.

* Add “Coach Pacing Dashboard” for team monitoring.

---

## **🎓 4️⃣ Recruiting Roadmap — “Your Career, Simplified by AI”**

### **🔍 What It Is**

An integrated recruiting assistant that helps athletes **turn their performance data into a story** — not just a spreadsheet.  
 StatLocker becomes a digital resume builder \+ outreach coach.

### **⚙️ How It Works**

* **Input:** Stats, position, grad year, academics, goals, schools of interest.

* **Processing:**

  1. AI assembles a clean, shareable recruiting profile (like a résumé).

  2. Builds a “readiness score” based on performance consistency \+ goal completion.

  3. Suggests next steps: upload transcript, highlight reel, coach outreach.

  4. AI generates **custom email templates** to college coaches.

      “Hi Coach Smith, I’m a 2026 Goalie from Duxbury HS with a 72% save rate. Here’s my season summary and highlight reel link.”

  5. Provides “target schools” ranking by fit: division, academics, roster need, etc.

* **Output Example:**  
   “You’re 80% Recruiting Ready for D2 programs. Add your highlight reel to reach 90%.”

### **🎯 Why It Matters**

* Removes recruiting anxiety.

* Builds tangible career momentum.

* Parents love it → drives Family Plan conversions.

### **💎 Future**

* Verified college coach dashboard.

* AI School Compatibility Index (based on player’s data \+ school’s profile).

* AI resume PDF generator (“Print Your Season Story”).

---

## **👨‍👩‍👧 5️⃣ Parent Mode — “Celebrate, Don’t Compare”**

### **🔍 What It Is**

A positive, digest-style mode for parents that transforms raw data into easy-to-read stories of growth — weekly summaries, milestones, and encouragement.

### **⚙️ How It Works**

* **Input:** Child’s stats \+ recent AI summaries.

* **Processing:**

  * AI extracts “positive deltas” (improvements week-to-week).

  * Auto-generates a cheerful digest email and in-app feed card:

     “This week: London’s save % climbed 7%, and she earned the Consistency Badge\! Confidence and focus are trending up.”

  * Suggests encouraging comments parents can send (“Tell her she’s owning the 3rd quarter\!”).

* **Optional Features:**

  * Multi-child switching (Family Plan).

  * Celebration feed: “Rocco hit 10 consecutive wall-ball days\!”

### **🎯 Why It Matters**

* Converts parents into advocates — increasing retention and word-of-mouth.

* Creates emotional connection around positive reinforcement, not stats.

* Builds trust through transparency without pressure.

### **💎 Future**

* “Proud Parent Moments” sharable to social.

* Team updates (“Your child was top 3 in Saves this week”).

* AI-generated highlight summaries for families.

🧩 Combined Impact: “The 5 Engines of Retention”

| Feature | Emotional Trigger | Business Impact |
| ----- | ----- | ----- |
| **AI Coach** | Feeling guided & seen | Habit creation |
| **StatGraph AI™** | Visible progress | Increased engagement |
| **GoalPace AI™** | Accountability & achievement | Retention & upgrades |
| **Recruiting Roadmap** | Future clarity | Family \+ Elite plan conversion |
| **Parent Mode** | Celebration & pride | Word-of-mouth virality |

Together, they form a **self-reinforcing ecosystem:**

Log → Insight → Progress → Pride → Motivation → Log Again.

Let’s zoom in on the **core intelligence of StatLocker — AthleteDNA™** — and build a full **AI flow architecture** around it.

This is the system that makes your entire app *learn, adapt, and scale across every athlete, sport, and generation*.  
 Once this layer is defined, everything else (AI Coach, GoalPace AI, Recruiting Roadmap, etc.) plugs *into it* instead of operating separately.

---

# **🧬 AthleteDNA™ — The Brain of StatLocker**

## **1️⃣ Overview**

AthleteDNA™ is StatLocker’s **adaptive intelligence engine** — a living profile that learns from an athlete’s data, behavior, and progress to deliver ultra-personalized coaching, insights, and motivation.

It’s not a static record. It’s a continuously evolving **AI model of the athlete.**

Think of it as:

*“A personal digital twin of every athlete that learns how they play, how they grow, and what keeps them motivated.”*

---

## **2️⃣ The AthleteDNA™ Framework**

AthleteDNA contains five “data rings.”  
 Each ring feeds and refines the others — forming the intelligence core of StatLocker.

| Ring | Description | Key Inputs | Used By |
| ----- | ----- | ----- | ----- |
| **1\. Performance DNA** | Raw stats & game logs | Saves, shots, goals, clears, penalties, time played | AI Coach, StatGraph AI |
| **2\. Context DNA** | Environment & metadata | Game date, opponent, team type (HS/Club), weather (future) | StatGraph AI, Recruiting Roadmap |
| **3\. Behavior DNA** | Activity & engagement | Logging frequency, drill completion, streaks | GoalPace AI, Motivation Engine |
| **4\. Mindset DNA** | Psychological indicators | Onboarding quiz, self-reported focus/confidence | AI Coach tone & recommendations |
| **5\. Ambition DNA** | Goals, aspirations, and recruiting intent | Season goals, college targets, preferred divisions | Recruiting Roadmap, GoalPace AI |

## **3️⃣ AthleteDNA Data Lifecycle**

### **🩵 Step 1: Capture**

Data enters via multiple sources:

* Manual game logs

* AutoStat OCR scans

* Drill logs

* Athlete self-inputs (confidence, fatigue)

* Passive tracking (streaks, session time)

### **🧩 Step 2: Synthesize**

The AI engine merges these into normalized profiles:

* Converts raw numbers into ratios and rates (Save %, Goals/Game, etc.)

* Tracks per-game deltas (performance changes over time)

* Creates event tags (big improvements, slumps, milestones)

### **🧠 Step 3: Learn**

AthleteDNA runs comparisons against:

* Athlete’s own historical averages

* Peer benchmarks (position, level, grad year)

* Global anonymized dataset (crowd insights)

Machine learning models start finding:

* Strengths and weaknesses

* Fatigue patterns (based on variance)

* Momentum (trend of improvement per stat)

### **⚡ Step 4: Apply**

Each AI module taps into AthleteDNA:

* **AI Coach** → personalized summaries, tone, next drill

* **GoalPace AI** → pace tracking & predictions

* **StatGraph AI** → annotated graphs

* **Recruiting Roadmap** → readiness scoring

* **Parent Mode** → positivity-first summaries

### **🔄 Step 5: Adapt**

Feedback loops:

* Athlete logs another game → model retrains micro-weights.

* AI learns which feedbacks yield higher engagement.

* Personality profile refines (e.g., prefers encouragement vs. analytics).

4️⃣ AthleteDNA \+ AI Flow Architecture (Data Map)

![][image1]

**What this means:**  
 Every feature learns from the same dataset, and every action feeds back into the system.  
 That’s your defensible moat — **no siloed modules, one living model.**

---

## **5️⃣ AI Implementation Roadmap (Conceptual)**

### **Phase 1 — Rules-Based Intelligence**

✅ MVP ready, lightweight.

* If Save% \> season avg → “Great job improving\!”

* If Shots Faced \< avg → “Light workload today — focus on consistency.”

* If goal pace \< 70% → “Small gap, you’ve got this.”

(Use deterministic logic \+ templates, no external API yet.)

### **Phase 2 — Hybrid AI Engine**

* Combine rules with OpenAI API or local LLMs for contextual summaries.

* Send sanitized stat payloads (e.g., last 3 games, trends, goals).

* Model outputs motivational \+ analytical summaries in tone of AI Coach.

* Store embeddings for “context recall” (AthleteDNA context).

### **Phase 3 — Predictive & Personalized AI**

* Train lightweight ML models (TensorFlow.js, PyTorch Mobile) for:

  * Performance trend prediction

  * Goal completion probability

  * Drill impact scoring

* Integrate AI Coach personality fine-tuning (based on engagement logs).

### **Phase 4 — Cross-Athlete Intelligence**

* Aggregate anonymized data → build position-specific benchmarks.

* Allow AI to generate team-wide insights (coach dashboards).

* Begin transfer learning for new sports.

---

## **6️⃣ The AthleteDNA Feedback Ecosystem**

| Trigger | AI Response | Impact |
| ----- | ----- | ----- |
| Game Logged | AI Coach Summary | Immediate reward, habit formation |
| Stat Trend Detected | StatGraph Callout | Curiosity \+ re-engagement |
| Goal Progress Drift | GoalPace Nudge | Retention |
| Streak Achieved | AI Celebration | Dopamine \+ loyalty |
| Recruiting Milestone | AI Email Prompt | Monetization |
| Inactivity | AI Reminder (“Ready to get back at it?”) | Re-activation |

## **7️⃣ What We’re Missing (and Should Add)**

Let’s identify any structural gaps so this ecosystem is airtight.

### **⚙️ Missing Structural Components**

| Gap | Why It Matters | How to Add |
| ----- | ----- | ----- |
| **Motivation Engine (AI Tone Layer)** | Consistent “voice” across app | Build small prompt templates for personality types (“Hype”, “Analyst”, “Mentor”) |
| **Data Trust Layer (Privacy/Opt-In)** | Parents & minors need transparency | Add Data Policy screen during onboarding; allow toggle for anonymized benchmarking |
| **Performance Benchmark API** | To compare users vs. peer averages | Use internal dataset; later, crowd-source anonymous game averages |
| **Reward System (Gamification Loop)** | Keeps engagement alive | Integrate streaks \+ badges as XP that feed into AI Coach voice (“You’re on a 3-game streak\!”) |
| **AI Journal (Memory Log)** | Tracks growth stories | Create “My Journey” tab — auto-generated AI summaries over time |
| **Emotion Tagging** | Context for mindset trends | Post-game self-rating: “How did you feel today?” (1–5 scale) — used for pattern recognition |
| **Drill Effectiveness Scoring** | Quantify improvement rate | AI correlates drills logged vs. performance increase |
| **AthleteDNA Export Layer** | Recruiting transparency | Generates downloadable summary for college coaches |

8️⃣ Example AthleteDNA Snapshot (Internal View)

| Category | Example Data Point | Last Update | Confidence |
| ----- | ----- | ----- | ----- |
| Position | Goalie | Static | 100% |
| Grad Year | 2026 | Static | 100% |
| Avg Save % | 71.3% | 10/05 | 97% |
| Left-side Save % | 76% | 10/05 | 82% |
| Consistency Score | 8.4/10 | 10/05 | 94% |
| Focus Trend | Rising | 10/05 | 80% |
| Current Goal Progress | 68% | 10/05 | 99% |
| Recruit Readiness | 72% | 10/05 | 70% |
| Motivation Type | Hype-driven | 10/05 | 88% |

## **9️⃣ Why This Architecture is a True MOAT**

* Every interaction (log, drill, goal) improves the personalized model.

* No competitor can replicate this dataset easily — it compounds with every athlete.

* AI gets smarter over time without external data costs.

* It ties emotional satisfaction (progress & identity) directly to engagement.

The longer an athlete stays in StatLocker, the better their AI Coach becomes — and the more irreplaceable StatLocker feels.

---

## **🔮 10️⃣ What’s Next**

To fully complete the new structure, we’ll need:

1. **Motivation Engine Spec** — define the emotional “tone system” for the AI Coach.

2. **Reward Loop Design** — streak badges, celebration animations, XP system.

3. **AI Data Governance Policy** — explain to users how AI learns safely.

4. **Team AI Layer** — enable future coach dashboards that plug into AthleteDNA.

5. **AthleteDNA API Schema** — design Firestore data model for storage (so each ring can be accessed modularly).

---

# **1\) Motivation Engine (AI Tone System)**

## **Purpose**

Give StatLocker’s AI a consistent, adaptive personality that matches each athlete. This is *how* we speak across AI Coach, notifications, digests, and empty states.

## **Tone Profiles (select 1 primary, 1 secondary)**

* **Hype** (energizing, punchy): “🔥 You brought it today. Keep that edge.”

* **Mentor** (calm, supportive): “Strong step forward. Let’s compound it.”

* **Analyst** (precise, neutral): “Save% \+7 vs season avg. Lateral speed is trending up.”

* **Captain** (accountability, ownership): “Leaders show up—log two drills by Friday.”

## **Inputs → Tone Mapping**

* Onboarding quiz (prefers encouragement vs data).

* Behavior DNA (responds well to nudges? avoids pressure?).

* Age/level guardrails (freshmen get gentler cues).

## **Message Templates (short-form)**

* **Win:** “Save% up {delta}% — that work is showing.”

* **At Risk:** “Slight dip vs. your pace. 5 min of Reflex L2 keeps you on track.”

* **Comeback:** “Took a breath; now let’s stack a clean week.”

* **Celebrate:** “🏅 Consistency badge—3 games in a row.”

## **Acceptance Criteria**

* Every AI output references a tone profile.

* 95% of in-app and email copy \< 240 chars.

* “At Risk” messages end with 1 concrete action.

---

# **2\) Reward Loop Design (Gamification Core)**

## **Loop**

Log → Insight → Micro-win → Reward → Next Action → Log again

## **Rewards**

* **Badges:** Consistency (3/5/10 logs), Clutch (best Save%), Iron Wall (low GA streak), Comeback (back after 7+ days).

* **Streaks:** Game logging streak, Drill streak.

* **Milestones:** 25/50/100 saves; target Save% achieved; first recruiting email sent.

## **Visuals & Moments**

* Confetti microburst (subtle), haptic pop on badge.

* Shareable season card (AI one-liner \+ key stat).

* Weekly “Wins of the Week” recap.

## **Acceptance Criteria**

* Reward animation \< 1.5s.

* Badge tooltips explain criteria.

* Streaks pause (not reset) if athlete taps “illness/injury” toggle.

---

# **3\) AI Data Governance & Trust**

## **Principles**

* **Consent:** Clear opt-in to AI features during onboarding.

* **Control:** Export & delete AthleteDNA on demand.

* **Transparency:** “What we use & why” plain-language modal.

* **Minors:** Parent visibility controls; uplifting tone only.

## **Surfaces**

* Onboarding: “Help AI coach you—agree to use your anon stats to learn.”

* Settings: “Manage my AthleteDNA → Export / Reset / Delete.”

* Parent Mode: “What parents can see” explainer.

## **Acceptance Criteria**

* One-click export (JSON summary, season card).

* Delete request completes across all surfaces within SLA (product-defined).

---

# **4\) Team AI Layer (Coach & Group Readiness — future-capable)**

## **Scope (post-MVP but architect now)**

* **Team Summary:** Top performers, emerging trends, at-risk goals.

* **Coach Notes Digest:** AI extracts themes (footwork praised 3×).

* **Group Goals:** Shared streaks (e.g., “10 straight days with wall-ball logs”).

## **Privacy**

* Athlete consent required to appear in coach views.

* Parents can disable team visibility for minors.

## **Acceptance Criteria**

* Team summary never displays sensitive notes; uses performance deltas only.

* Opt-in per team (HS vs Club) stored in AthleteDNA.

---

# **5\) AthleteDNA API Schema (Conceptual, stack-agnostic)**

This is a *logical schema*—use whatever datastore later; keep these shapes.

{  
  "athleteId": "string",  
  "profile": {  
    "firstName": "string",  
    "gradYear": 2027,  
    "teamType": { "hs": true, "club": false },  
    "level": "Varsity",  
    "positions": \["Goalie","-"\],  
    "tonePrimary": "Hype",  
    "toneSecondary": "Mentor",  
    "visibility": { "parentMode": true, "teamCoachView": false }  
  },  
  "goals": \[  
    {"id":"g1","type":"saves\_total","target":100,"current":62,"status":"on\_pace"},  
    {"id":"g2","type":"save\_pct","target":0.70,"current":0.673,"status":"at\_risk"}  
  \],  
  "performance": {  
    "season": {  
      "gamesPlayed": 12,  
      "savePct": 0.673,  
      "shotsFaced": 210,  
      "saves": 141,  
      "goalsAllowed": 69  
    },  
    "trends": \[  
      {"metric":"savePct","window":"last5","value":0.712,"deltaVsSeason":+0.039}  
    \],  
    "situational": {  
      "byQuarter": {"Q1":0.64,"Q2":0.66,"Q3":0.74,"Q4":0.62},  
      "homeVsAway": {"home":0.70,"away":0.65}  
    }  
  },  
  "behavior": {  
    "loggingStreakDays": 6,  
    "drillStreakDays": 4,  
    "lastActiveAt": "2025-10-05T20:12:00Z"  
  },  
  "mindset": {  
    "confidenceTrend": "rising",  
    "preferredSessionMinutes": 10  
  },  
  "recruiting": {  
    "readinessScore": 0.72,  
    "targets": \[{"school":"Boston College","division":"D1","fitScore":0.68}\],  
    "resumeUrl": null  
  },  
  "ocr": {  
    "creditsRemaining": 2,  
    "lastScanConfidence": 0.91  
  },  
  "audit": {  
    "createdAt": "iso8601",  
    "updatedAt": "iso8601"  
  }  
}

# **Deep Dive: Log Game \+ AutoStat OCR (FAB → Bottom Sheet Flow)**

We’ll design this like a **pro sports app**: lightning fast in the moment, forgiving after the fact.

## **Core Principles**

* **One thumb, zero hunting.** FAB is always accessible.

* **Two primary paths:** **Live Game** vs **After Game**.

* **Position-aware fields**. Only what matters to that athlete.

* **Auto-calculated** percentages; stat hygiene guardrails.

* **Save states** (drafts), offline-first, undo.

---

## **Entry: FAB → Bottom Sheet**

**FAB label:** “Log Game”  
 **Press → Bottom Sheet (Peek Height \~40%):**

**Header:** “How do you want to log?”  
 **Tiles (2 up):**

1. **Live Game** (Start Timer)  
    *“Track as you play—fast \+ focused.”*

2. **After Game** (Quick Add)  
    *“Enter final stats in under a minute.”*

**Secondary row (optional):**

* **Scan Scorebook (OCR)**  
   *“Snap a pic—we’ll suggest stats to confirm.”*

**Helper copy (below):**  
 “Goalie? We’ll show saves, shots, goals allowed. You can customize anytime.”

---

## **Path A: Live Game (In-Game Tracker)**

### **Screen Layout**

* **Top App Bar:** “Live Game • Duxbury vs \[Opponent\]”

* **Timer Chip:** Start/Pause; Quarter selector (Q1–Q4)

* **Primary Stat Grid (position-aware):**

  * Goalie: **\+ Save**, **\+ Shot Against**, **\+ Goal Allowed**, **\+ Clear**

* **Secondary Row (expandable):** Turnovers, Cards

* **Undo pill** appears for 4s after each \+ action

* **Quarter End CTA:** “End Q1” → locks quarter tally (editable via “Adjust”)

### **Micro-Interactions**

* Haptics: light tick on each \+; medium on quarter end.

* Color cues: Saves → subtle positive flash; Goals Allowed → neutral to avoid shaming.

### **End Game**

* **Summary Modal (auto):**

  * “Final: 12 Saves, 5 GA, 70.6% Save%”

  * Notes (optional)

  * **Save Game** (primary) / **Adjust Stats** (secondary)

### **Edge Cases**

* **Phone lock / interruptions:** auto-pause timer; on return → prompt “Resume Live?”

* **No opponent set:** default “Unlabeled Game”; prompt to edit later.

* **Offline:** queue locally; sync on reconnect.

### **Acceptance Criteria**

* Start→Save in \< 3 taps (if minimal use).

* Quarter split visible in Stats detail.

* Undo available for last 3 actions.

---

## **Path B: After Game (Quick Add)**

### **Modal Flow (Stacked Bottom Sheets)**

**Sheet 1: Game Context (15s)**

* Opponent (optional), Home/Away toggle

* Game date (default today)

* Team: HS or Club

**Sheet 2: Position-Aware Stat Entry (45–60s)**

* **Inline counters with \+/-**

  * Goalie: Saves, Shots Against, Goals Allowed, Clears

* **Auto-calculated Save%** (read-only)

* Notes (optional)

**Validation**

* Saves ≤ Shots Against

* Goals Allowed \= Shots Against − Saves (auto if allowed)

* If mismatch → “Heads up: these numbers don’t line up — fix or save anyway?”

**Sheet 3: Review & Save**

* Summary card \+ micro-insight placeholder:  
   “Save% 71% — best in 3 games.”

* **Save Game** (primary)

* **Share Card** (disabled in MVP but visible teaser)

### **Acceptance Criteria**

* Time to complete \< 60–90 seconds.

* Auto-calculation never blocks save; shows advisory only.

---

## **Path C: Scan Scorebook (AutoStat OCR)**

### **Intake Sheet**

* **Prompt:** “Frame the sheet; avoid glare. We auto-detect saves, shots, goals.”

* **Capture** → preview → **Use Photo** / Retake

### **OCR Result Sheet (Editable)**

* Confidence chips next to each field (e.g., Saves 12 (92%))

* Unknowns marked with “?” → tap to edit

* “Apply all” (if high confidence)

* “Fix quickly” (jumps between low-confidence fields)

### **Review → Save**

* Same Review & Save sheet as After Game

* Post-save toast: “OCR saved you \~40 taps. Nice.”

### **Edge Cases**

* Low light / blur → fallback prompt: “We can’t read this—enter manually?”

* Partial read → prefill what we can; never block save.

### **Acceptance Criteria**

* OCR flow must not exceed manual time when confidence is low.

* Editable values always override OCR.

---

## **Component Specs (UI summary)**

**Bottom Sheet**

* 16px drag handle; 24px side padding

* Safe area aware; scroll on small devices

* “Collapse” chevron displayed during deep sheets

**Counters (+/−)**

* Large touch targets (44×44)

* Long-press repeat (fast ramp)

* Haptic light on each increment

**Timer/Quarter (Live)**

* One-touch quarter change; confirm on End Quarter

* Lock per quarter with Edit affordance

**Validation Banners**

* Non-blocking yellow: “Numbers don’t add up—want help fixing?”

* Blocking red only for impossible values (e.g., Saves \> Shots when “lock relations” on)

---

## **Data Events (for analytics & AI triggers)**

* `log_game_started` {mode: live|after|ocr}

* `log_game_quarter_end` {q: “Q1”, stats: {...}}

* `log_game_saved` {mode, stats, durationSec}

* `ocr_started` / `ocr_parsed` {confidenceAvg, fieldsAutofilled}

* `insight_viewed` {type: postgame|weekly}

* `goal_nudge_shown` {goalId, paceStatus}

* `badge_earned` {badgeType}

**AI Triggers**

* After `log_game_saved` → generate **Postgame Summary**

* After 3 logs in 10 days → **Consistency Badge**

* If pace dip \> threshold → **GoalPace Nudge**

---

## **Copy & Microcopy (in these flows)**

* **Live Start:** “Tracking live. Focus on your game—we’ve got the numbers.”

* **Quarter End:** “Q1 locked. Want a quick breather note?”

* **After Game Headline:** “Quick add—less than a minute.”

* **OCR Helper:** “Good light helps. Tip: tilt phone to avoid glare.”

* **Validation Hint:** “Saves \+ Goals should equal Shots. Want us to balance it?”

* **Save Toast:** “Logged\! Postgame summary is ready.”

* **Upgrade Tease (post-save):** “Get deeper insights with AI Coach in Pro.”

---

## **Edge Cases & Safeties**

* **Fat thumbs:** Undo, edit, confirmation on destructive actions.

* **Interrupted live entry:** Auto-draft each 10s; recover on return.

* **Dual team same day:** Context sheet must show HS/Club clearly.

* **Low vision:** Large tap areas, clear contrast, no red/green-only cues.

---

## **Acceptance Criteria (End-to-End)**

* From FAB tap to saved **After Game** entry in ≤ 90s (median).

* From FAB tap to **Live Game** running in ≤ 3 taps.

* OCR success path (good photo) is faster than manual (≤ 40s).

* Postgame AI summary appears within **seconds** of save (MVP: rule-based, later LLM).

* Validation never traps the user; save is always possible with warnings.

---

## **How this all ties back to AthleteDNA**

* Every save/shot/clear updates **Performance DNA** \+ **Trends**.

* Mode used (live/after/ocr) and time-to-log feed **Behavior DNA** (consistency/coaching style).

* Notes can nudge **Mindset DNA** and AI tone.

* Hitting micro-wins updates **GoalPace AI** and unlocks **Rewards**, fueling the retention loop.

Perfect — you’re now setting up **the StatLocker 2.0 Product Architecture Suite**:  
 1️⃣ Vision & Pitch (done ✅ — PDF delivered)  
 2️⃣ Edge Case \+ Validation System  
 3️⃣ Test Case Matrix (AA / QA layer)  
 4️⃣ Developer-Ready PRD (for AI IDE input — Cursor, Windsurf, etc.)

We’ll create \#2 and \#3 next, then I’ll compile \#4 as the “feedable PRD” optimized for agent interpretation.

---

# **⚙️ StatLocker 2.0 — Edge Case & Validation Document**

## **1️⃣ Purpose**

This document defines all potential **edge cases, exceptions, and validation rules** for the AI-powered athlete experience — ensuring reliability, data integrity, and trust.

---

## **2️⃣ App Modules Covered**

1. Onboarding

2. Dashboard

3. Log Game (Live / After / OCR)

4. AI Coach

5. StatGraph AI

6. GoalPace AI

7. Recruiting Roadmap

8. Parent Mode

9. Subscription & Paywall

---

## **3️⃣ Edge Cases by Module**

### **🧩 Onboarding**

| Scenario | Expected Behavior | Validation Rule |
| ----- | ----- | ----- |
| User skips sport or position | Disable Continue button until required fields filled | Required field enforcement |
| Poor network connection mid-onboarding | Save partial data locally; resume later | Local caching \+ resume state |
| Athlete under 13 | Trigger parental consent screen | Age check \+ parental gate |
| User exits before review screen | Save temporary progress | Local store partial inputs |
| Duplicate email / existing account | Offer Login option | Firebase auth check |

---

### **🧠 Dashboard**

| Scenario | Expected Behavior | Validation |
| ----- | ----- | ----- |
| No data logged | Show empty state with “Log First Game” CTA | Default placeholder card |
| Partial goal setup | Hide incomplete goals gracefully | Conditional rendering |
| AI summary not yet available | Show “Processing...” for \<10s, fallback rule-based | AI timeout handling |

---

### **🏟️ Log Game (Live, After, OCR)**

| Scenario | Expected Behavior | Validation |
| ----- | ----- | ----- |
| **Saves \> Shots Faced** | Show yellow warning “Numbers don’t add up” | Hard cap or manual override |
| **Goal Allowed \= 0, but Shots Faced \> 0** | Valid, no alert | — |
| **Live Game interrupted (app closed)** | Auto-pause \+ draft recovery | Auto-save to local storage |
| **OCR fails due to glare** | Prompt retry or manual entry | Confidence threshold \< 0.7 |
| **Offline mode** | Queue logs → sync on reconnect | Retry with local persistence |
| **Multiple team same day** | Prompt “HS or Club?” before save | Context check |

---

### **💬 AI Coach**

| Scenario | Expected Behavior | Validation |
| ----- | ----- | ----- |
| AI API timeout | Use rule-based summary fallback | 3s timeout grace |
| Contradictory stats (e.g., Save% \> 100%) | Sanitize inputs before AI prompt | Data filter |
| AthleteDNA incomplete | Use default tone \+ minimal insight | Fallback personality |

---

### **📈 StatGraph AI**

| Scenario | Expected Behavior | Validation |
| ----- | ----- | ----- |
| \<2 games logged | Display message “Need more data to visualize trends” | Conditional render |
| Outlier game (huge spike) | Auto-label as “Best Game” instead of breaking chart | Outlier detection |
| Missing timestamps | Skip plotting, prompt fix | Data validation |

---

### **🎯 GoalPace AI**

| Scenario | Expected Behavior | Validation |
| ----- | ----- | ----- |
| No goals set | Prompt to add | Null-check |
| Behind schedule | Trigger nudge | Threshold: \<70% target pace |
| Overachieved | Offer stretch goal | Threshold: \>110% pace |

---

### **🎓 Recruiting Roadmap**

| Scenario | Expected Behavior | Validation |
| ----- | ----- | ----- |
| Missing transcript | Display “Upload to complete readiness” | Conditional visibility |
| No games logged | Recruiting readiness \<20% | Default floor |
| Email builder API error | Fallback to offline template | Fallback content |

---

### **👨‍👩‍👧 Parent Mode**

| Scenario | Expected Behavior | Validation |
| ----- | ----- | ----- |
| Child data private | Parent sees “Limited access enabled” | Visibility filter |
| Multiple children | Switchable tabs | Data separation |
| No new progress | Show “No changes this week” | Graceful degradation |

---

### **💳 Subscription / Paywall**

| Scenario | Expected Behavior | Validation |
| ----- | ----- | ----- |
| Trial expired | Lock premium sections | Date comparison |
| iOS/Google billing delay | Show “Renewing…” state | RevenueCat event sync |
| Downgrade plan | Retain data, limit features | Role-based access |

---

## **4️⃣ System-Wide Validation**

| Category | Validation Rule | Trigger |
| ----- | ----- | ----- |
| Data Integrity | Saves \+ Goals \= Shots (Goalie) | On Save |
| Value Limits | No negative stats | Input field |
| API Failure | Fallback to local templates | AI Coach, OCR |
| Connectivity | Offline sync queue | Any network loss |
| User Session | Token expiration → logout | Auth |

---

## **5️⃣ AI Model Fail Safes**

| Issue | Response |
| ----- | ----- |
| GPT response incomplete | Retry once, fallback rule logic |
| Offensive / invalid AI text | Filter \+ rephrase |
| Model confusion | Simplified insight version |
| Hallucinated recommendation | Restrict to pre-trained stat contexts |

---

# **🧪 StatLocker 2.0 — Test Case Matrix (AA Validation)**

## **1️⃣ Log Game (After Game)**

| ID | Test | Expected Result |
| ----- | ----- | ----- |
| TC-LG-001 | Log 10 saves / 3 GA / 13 shots | Auto Save% \= 76.9% |
| TC-LG-002 | Leave “Shots” blank | Prompt error “Enter shots faced” |
| TC-LG-003 | Add note | Saved in Firestore `notes` |
| TC-LG-004 | Tap Save offline | Queued locally, syncs when online |
| TC-LG-005 | Enter impossible values | Warning shown, still able to Save |

---

## **2️⃣ OCR Capture**

| ID | Test | Expected Result |
| ----- | ----- | ----- |
| TC-OCR-001 | Clear photo (92% confidence) | Fields auto-filled correctly |
| TC-OCR-002 | Blurry photo (below 70%) | Prompt “Retry or enter manually” |
| TC-OCR-003 | Missing saves column | Field left blank, confirm required |
| TC-OCR-004 | Low light | Show “Turn on flash?” prompt |
| TC-OCR-005 | Edit OCR result manually | Manual override allowed |

---

## **3️⃣ AI Coach Summary**

| ID | Test | Expected Result |
| ----- | ----- | ----- |
| TC-AI-001 | Save% \+5 vs last game | Message: “Improvement \+5% — great focus\!” |
| TC-AI-002 | API timeout | Fallback rule summary shown |
| TC-AI-003 | AthleteDNA tone: Mentor | Calm supportive phrasing |
| TC-AI-004 | AthleteDNA missing | Default neutral tone |
| TC-AI-005 | Negative trend | Supportive “Bounce back” copy, no negative tone |

---

## **4️⃣ GoalPace**

| ID | Test | Expected Result |
| ----- | ----- | ----- |
| TC-GP-001 | 50% of goal reached mid-season | “On track” state |
| TC-GP-002 | 30% goal pace | “Catch up” nudge |
| TC-GP-003 | Exceed goal 120% | “Stretch goal unlocked” |
| TC-GP-004 | Delete goal | Safe remove, UI updates |

---

## **5️⃣ Recruiting**

| ID | Test | Expected Result |
| ----- | ----- | ----- |
| TC-RR-001 | Fill full profile | Readiness \= 100% |
| TC-RR-002 | Missing transcript | Readiness capped at 80% |
| TC-RR-003 | Email generated | Opens formatted email |
| TC-RR-004 | API error | Offline template fallback |

---

## **6️⃣ Parent Mode**

| ID | Test | Expected Result |
| ----- | ----- | ----- |
| TC-PM-001 | Enable parent view | Read-only mode |
| TC-PM-002 | Child has no progress | “No updates yet” card |
| TC-PM-003 | Multiple children | Switchable dashboard |

---

## **7️⃣ Paywall / Subscription**

| ID | Test | Expected Result |
| ----- | ----- | ----- |
| TC-PW-001 | Start trial | 7-day unlock starts |
| TC-PW-002 | Trial ends | Premium locked |
| TC-PW-003 | Upgrade to Pro | AI Coach unlocked |
| TC-PW-004 | Cancel subscription | Retain data, lock premium |

---

## **8️⃣ Global QA Acceptance Criteria**

✅ 95% of users can log a game without error.  
 ✅ AI Summary appears in \<5s 90% of the time.  
 ✅ OCR confidence ≥85% average accuracy.  
 ✅ Zero data loss on app crash or offline.  
 ✅ Fallback summaries always render within 2s.

# **🧩 StatLocker 2.0 — Phase-by-Phase Build Prompt Guide**

---

## **PHASE 0 — FOUNDATIONS (Weeks 0–4)**

Goal: Build the core skeleton (Welcome → Auth → Onboarding → Dashboard \+ Log Game \+ Trial)

### **🎯 Purpose**

Get the app booting from Splash → Welcome → Auth → Onboarding → Dashboard with working FAB → Log Game modal. Establish brand voice, navigation, and theming.

---

### **🧱 Deliverables**

| Area | Component | Function |
| ----- | ----- | ----- |
| **Welcome** | `WelcomeScreen.tsx` | Animated Calm-style intro; “Get Started” \+ “Log In” buttons |
| **Auth** | `AuthManager.ts` \+ Firebase | Apple / Google / Email login |
| **Onboarding 2.0** | 5-step flow w/ AthleteDNA capture | Team, Grad Year, Level, Position, Goals, Review |
| **Dashboard (Locker)** | `DashboardScreen.tsx` | Stat cards, AI summary placeholder, Goals progress, FAB |
| **Log Game Modal** | `LogGameModal.tsx` | Live \+ After Game \+ OCR modes |
| **Paywall \+ Trial** | `PaywallScreen.tsx` | 7-day free trial logic (RevenueCat) |
| **Weekly Review (v1)** | `WeeklySummary.tsx` | Rule-based “AI summary” placeholder |

---

### **💻 AI IDE Prompt Examples**

Use these prompts directly in **Cursor or Windsurf** (adjust file paths as needed).

**1️⃣ Welcome Screen**

“Create a Calm-inspired WelcomeScreen component with a gradient background, soft fade-in animation of the StatLocker logo, tagline ‘Your Game. Your Stats. Your DNA.’, and two buttons (‘Get Started’, ‘Log In’). Use Tailwind-style utility classes and add haptic feedback on press.”

**2️⃣ Authentication**

“Implement AuthManager.ts with Firebase for Apple, Google, and Email login. Store firstName, lastName, email, UID, and role (‘athlete’). Ensure clean error handling and loading indicators.”

**3️⃣ Onboarding 2.0**

“Build a 5-step Onboarding flow using Zustand or context state. Steps: Team Identity, Level, Position, Goals, Review. Capture AthleteDNA fields in Firestore. Use progress indicators and motivational microcopy.”

**4️⃣ Dashboard v1**

“Build DashboardScreen with greeting (‘Hi \[firstName\]’), stat cards grid (Save %, Shots, Goals, Clears), Goals progress bars, and a pulsing FAB labeled ‘Log Game’. Layout should feel like Calm x Strava (airy, confident).”

**5️⃣ Log Game Modal**

“Create a bottom sheet modal with options: Live Game, After Game, OCR Scan. If After Game, display numeric \+/- counters and auto-calculate Save%. Include undo and validation. After save, trigger mock AI summary toast.”

**6️⃣ Trial & Paywall**

“Add a simple 7-day free trial state using mock RevenueCat API. After trial, show locked sections with blur overlay and CTA ‘Unlock AI Coach’.”

**7️⃣ Weekly Summary**

“Build a static WeeklySummaryCard that shows improvement deltas from last 3 games with motivational copy like ‘🔥 Save% up 5%\! Keep stacking wins.’”

---

### **🎨 Design Prompt Example**

“Design Phase 0 components in a Calm-meets-Strava aesthetic: white and indigo gradient, soft motion, smooth shadows. Typography: Plus Jakarta Sans for body, Anton for headings. Maintain generous breathing space.”

---

## **PHASE 1 — PERFORMANCE INTELLIGENCE (Weeks 5–8)**

Goal: Bring the data to life with trends, insights, badges, and motivational loops.

### **🎯 Purpose**

Make the app feel *alive* by connecting logged data → visuals → AI summaries → rewards.

---

### **🧱 Deliverables**

| Component | Description |
| ----- | ----- |
| **Stats Tab** | Trend charts, delta callouts, comparisons |
| **GoalPace AI™** | Smart pacing engine \+ nudge notifications |
| **Badges System** | Milestone rewards \+ streaks |
| **Skills Tab** | Micro-drill recommendations (rule-based) |
| **Shareable Season Card** | AI summary snapshot for social |

---

### **💻 AI IDE Prompts**

**1️⃣ Stats Tab**

“Create a StatsScreen with StatGraph AI: line chart showing Save% over time. Add auto callouts (‘Best Game’, ‘Dip below avg’). Include short natural-language insights below chart.”

**2️⃣ GoalPace AI**

“Implement GoalPaceEngine: calculate pace vs. goal targets. If \<70% pace, trigger ‘Catch up’ notification. If \>110%, unlock stretch goal badge. Use colors to visualize pace states.”

**3️⃣ Badges**

“Create BadgesGrid component showing unlocked \+ locked badges. Trigger Confetti animation and vibration when new badge unlocked.”

**4️⃣ Skills AI**

“Add SkillsTab with drill recommendations (static JSON). Filter by position. Display drill duration and skill focus.”

**5️⃣ Shareable Season Card**

“Generate SeasonSummaryCard with top 3 stats, AI tagline (‘Your save consistency is elite’), and a share button (image export).”

---

### **🎨 Design Prompt**

“Use gentle motion. StatGraphs animate like Strava with easing. Badges feel tactile (3D shadow). Maintain motivational, not gamified, tone.”

---

## **PHASE 2 — CAPTURE & RECRUITING (Weeks 9–12)**

Goal: Reduce friction (OCR) and extend value (Recruiting \+ Parent Mode).

### **🧱 Deliverables**

| Component | Function |
| ----- | ----- |
| **AutoStat OCR** | Image capture → AI-assisted stat fill |
| **Recruiting Roadmap** | Readiness score, checklist, email builder |
| **Parent Mode** | Read-only dashboard \+ digest |
| **Refinement of AI Coach** | Use AthleteDNA context for tone |

---

### **💻 AI IDE Prompts**

**1️⃣ OCR**

“Implement AutoStatOCR using Expo Camera or Vision API. Allow user to photograph a stat sheet. Parse text, fill form fields (Saves, Goals, etc.), highlight low-confidence fields. Always allow manual edits.”

**2️⃣ Recruiting Roadmap**

“Create RecruitingTab with readiness bar (0–100%) and checklist (upload transcript, add highlight reel, log 10 games). Generate email template using AI: ‘Hi Coach \[Name\], I’m a \[Grad Year\] \[Position\] with a \[Save%\].’”

**3️⃣ Parent Mode**

“Add toggle for ParentView. Display child’s stat deltas and positive feedback only. WeeklyDigestCard: ‘London’s Save% up 12%\! Confidence trending up.’”

**4️⃣ AI Coach v2**

“Integrate AI summary generation using OpenAI or a local LLM API. Pass last 5 games, trend deltas, goals, and tone to the model. Limit to 2–3 sentences, end with next action.”

---

### **🎨 Design Prompt**

“Introduce a feeling of progress. Parent Mode is celebratory and bright. Recruiting tab feels professional — clean lines, college-style blues and whites.”

---

## **PHASE 3 — DEPTH & COMMUNITY (Weeks 13–16)**

Goal: Expand value across families, teams, and comparisons.

### **🧱 Deliverables**

| Component | Description |
| ----- | ----- |
| **Advanced Analytics** | HS vs Club comparisons; trend segments |
| **Family Plan Management** | Multi-athlete switching |
| **Messaging (optional)** | Team/group chat for feedback |
| **AI Weekly Digest** | Automated motivational recaps |

---

### **💻 AI IDE Prompts**

**1️⃣ Comparisons**

“Build ComparisonScreen: tabs for HS vs Club. Chart side-by-side Save% and Clears. AI generates insight ‘You perform 6% better in home games.’”

**2️⃣ Family Plan**

“Add FamilyDashboard with tabs per athlete. Use shared subscription context. Parent can switch athletes and see read-only view.”

**3️⃣ Messaging**

“Create lightweight ChatScreen for team groups. Integrate Firestore real-time chat. Include AI summary generator for ‘Coach Feedback’ messages.”

**4️⃣ AI Weekly Digest**

“Generate weekly digest for each athlete. Combine 3 best stats, 1 improvement, and AI message (‘3 games logged — save% climbing steadily\!’). Send as in-app card and push.”

# **HS ↔ Club Toggle (Context Switching)**

## **Where it lives**

* **Top of Home (Locker)**: a compact **segmented control**: `HS | Club`.

* Mirrors on **Log Game** sheet (context chip), **Stats** (filter), and **Goals** (scope control).

## **Behavior**

* Default to the **last-used** context.

* Switching updates:

  * **Stat tiles** (season totals/averages scoped to that context)

  * **GoalPace** (context-scoped goals)

  * **Recent games list** (filtered)

  * **AI Coach** summary (uses only selected context unless “All” is chosen)

## **Optional third state**

* Add an **“All”** dropdown in Stats to compare HS vs Club:

  * Tabs: `HS`, `Club`, `Compare`

  * Compare shows a side-by-side chart \+ an AI callout: “You perform 6% better at HS home games.”

## 

## 

## 

## **Data model (minimal add)**

{  
  "context": { "active": "hs", "available": \["hs","club"\] },  
  "teams": {  
    "hs": { "name": "Duxbury HS", "seasonStart": "2025-03-01" },  
    "club": { "name": "LXC Club", "seasonStart": "2025-05-01" }  
  },  
  "performanceByContext": {  
    "hs": {...stats...},  
    "club": {...stats...}  
  },  
  "goalsByContext": {  
    "hs": \[ { "goalId":"g1", "type":"saves\_total", "target": 100 } \],  
    "club": \[ ... \]  
  }  
}

## **Logging guardrails**

* **Log Game sheet** shows a **context pill**: `HS` or `Club` (tap to switch).

* If none set (e.g., didn’t choose Club at onboarding), show **Add Club Team** CTA to enable second context.

## **AI changes**

* AI Coach uses **context-aware prompts**:

  * “In HS play, your save% rose 8% this week. In Club, clears dipped slightly.”

---

# **Freshmen & “Haven’t Played Yet” Support**

## **Onboarding branch**

Add a switch: **“Have you played a game yet this season?”**

* **No** → route to **New Player Mode**:

  1. Quick confidence & readiness check (1–2 micro Qs)

  2. **Starter Goals**: e.g., “Log 1 scrimmage this week”

  3. **Practice-Only mode** enabled (log drills without games)

  4. **Demo Insights** (with clearly labeled sample data) to teach the experience

## **Empty states**

* **Home**: “Every stat tells your story — start with a scrimmage or a 5-min drill.”

* **Stats**: “Play or practice once to unlock your first trend.”

* **Recruiting**: “Focus on foundation; we’ll open this when you’ve logged 5 games.”

## **Practice-first loop**

* **Skills micro-plans** emphasized on Home (“Today’s Plan: 5-min Reflex L2”)

* **Practice Log FAB** option beside Log Game (if no games yet)

* **Progress badges** for practice streaks (so they can win before they play)

## **Bench / DNP (Did Not Play)**

* Log Game → **DNP toggle**  
   Fields: Opponent, Date, **DNP reason** (Coach decision / Injury / Rest / Academic)  
   Impact:

  * Shows in timeline (transparent), doesn’t affect performance averages

  * **GoalPace** pauses (no penalty)

  * AI Coach uses supportive tone: “Not in today, keep the routine: 5-min reaction drill.”

---

# **UX Details (succinct and buildable)**

## **HS/Club segmented control (Home header)**

* Size: 44px tall, full width, pill style, **Haptics on toggle**

* State memory: per-user, persisted

* Long-press: quick switcher to **Edit Team Info**

## **Log Game bottom sheet**

* **Top row**: Context chip `HS` / `Club` (tap to flip)

* “After Game” form auto-fills the context; stored per entry

* OCR: if the sheet includes team name, attempt auto-detect → confirm with user

## **Stats page scope**

* Scope chips: `HS` `Club` `Compare`

  * **Compare** view shows dual lines \+ shaded deltas \+ one AI sentence

## **Goals page scope**

* Toggle at top: `This Team` / `All Teams`

  * Default to `This Team` (context)

  * Add **per-team goals**, plus optional global goals (e.g., “100 total saves across both”)

---

# **Copy (micro)**

* **Context toggle helper**: “Switch teams to see those stats.”

* **New player empty state**: “Start with one practice. Momentum beats perfection.”

* **DNP supportive**: “Not your day to suit up — stay ready.”

* **Practice log nudge**: “Five focused minutes can change your season.”

---

# **Edge cases**

* **User toggles to Club but never set one up** → “Add Club Team” modal (name optional; can be generic “Club Team”).

* **Accidentally logged HS game as Club** → Edit game → change context (recalc stats/goals quietly).

* **Both teams play same day** → Log entries are separate; **Upcoming** shows two tiles.

* **No season start set** → assume first log date.

---

# **Validation & Acceptance criteria**

* Toggling HS/Club updates **all tiles, lists, and charts** in \<250 ms.

* Each log has an immutable `context` field; editing reflows aggregates without data loss.

* **DNP** logs do not affect performance averages; **GoalPace** pauses that day/week, no penalty.

* New players can complete a **practice-only week** and still earn a badge.

* AI summary references **current context** 100% of the time (or explicitly states both if user selects Compare).

---

# **Analytics we’ll capture**

* `context_switched` {from: hs, to: club}

* `log_game_context` {context: hs|club, mode: live|after|ocr}

* `dnp_logged` {reason}

* `practice_logged` {drillId, minutes}

* `empty_state_action` {screen, cta}

---

# **Prompts for your AI IDE (drop-in)**

**Add HS/Club toggle to header**

“Add a segmented control to Home header labeled HS | Club. Persist last selection. On toggle, re-query data for the active context, update stat tiles, goal bars, and recent games. Provide haptic feedback and a short fade transition.”

**Context on Log Game**

“Update LogGameBottomSheet to include a context chip (HS/Club). Persist this with each saved game in a `context` field. If OCR detects a team name, preselect context; otherwise default to active.”

**Stats scope**

“Add scope chips to Stats: HS, Club, Compare. In Compare, render dual Save% lines and a one-line AI callout highlighting the largest delta. Make scope selection sticky per user.”

**Goals by context**

“Refactor Goals module to support `goalsByContext`. Show ‘This Team’ by default. Add an ‘All Teams’ aggregate goal view.”

**New Player mode**

“Add onboarding branch when user selects ‘Haven’t played yet’. Create Practice-first Home state with micro-plans, Practice Log via FAB, and demo insights cards labeled clearly as samples.”

**DNP logging**

“Add DNP toggle to After Game flow. When active, save entry with `isDnp: true` and `dnpReason`. Exclude from performance aggregates; pause GoalPace for that date window; trigger supportive AI copy.”

---

# **Quick visual hierarchy recap**

* **Bottom Tabs**: Home, Stats, (FAB overlay), Goals/ Skills, Recruiting

* **Drawer (avatar)**: Profile, Parent Mode, Subscriptions, Settings, Help, Feedback

* **Context control**: HS/Club in the **Home header** (and chips on Stats/Goals)

* **FAB sheet**: Live, After, OCR (+ **Practice Log** visible if no games yet)

# **StatLocker AI — Mission & Vision**

**Mission:**  
 Make improvement *visible and personal* for every athlete by turning game stats into clear, encouraging coaching—automatically, after every log.

**Vision:**  
 Become the most trusted **AI athlete companion**—the place where athletes build habits, see progress, and tell a recruiting-ready story powered by their **AthleteDNA™**.

**Tagline:** *Your Game. Your Stats. Your DNA.*

---

# **Business Plan (deep but skimmable)**

## **1\) Executive Summary**

StatLocker 2.0 is a mobile-first iOS app for high-school and club athletes. It replaces raw stat tracking with **AI-guided improvement**: a bottom-sheet logging flow (Live/After/OCR), instant AI summaries (AI Coach), smart visuals (StatGraph AI™), pacing (GoalPace AI™), and a Recruiting Roadmap. Monetization: Free (lite), **Pro**, **Elite**, plus **Family** seats.

## **2\) Market**

* **Primary segment:** US high-school athletes in stat-rich sports (lacrosse first, then hockey, soccer, basketball).

* **Secondary:** Parents; later coaches/teams.

* Pain today: scattered stats, no feedback loop, recruiting opacity.

* TAM/SAM: Start with \~8–10M US HS athletes; focus on stick/goalie sports where stat literacy ties to outcomes.

## **3\) Product**

Core features (already defined): **AI Coach**, **StatGraph AI™**, **GoalPace AI™**, **Recruiting Roadmap**, **Parent Mode**.  
 Differentiators: **AthleteDNA** (personalization from 5 rings: performance, context, behavior, mindset, ambition), frictionless logging, celebratory design.

## **4\) Pricing & Packaging**

* **Free (Forever-Lite):** Basic logging \+ 1 AI summary/week.

* **Pro ($9.99/mo or $99/yr):** 10 AI summaries/mo, weekly reports, limited OCR, recruiting basics.

* **Elite ($19.99/mo or $199/yr):** Unlimited AI insights, advanced analytics, full OCR, recruiting roadmap \+ email builder.

* **Family ($24.99/mo or $249/yr):** 2–4 athletes \+ Parent Mode+.  
   Default: Recruiting & GoalPace use **official (Game)** stats; scrimmage inclusion is a settings toggle.

## **5\) Go-To-Market**

* **Bottom-up:** Athlete word-of-mouth via shareable season cards and badges; parent digests.

* **School/Club pilots:** Free season pilots for programs; discount codes per team.

* **Creator loop:** Partner with goalie/skills creators for content \+ bundle codes.

* **Moments:** Season start & playoff pushes; recruiting webinars.

## **6\) Data/AI Strategy (moat)**

* Proprietary **AthleteDNA** improves with each log; generates sticky personalization.

* Cross-athlete anonymized benchmarks (opt-in) power better insights over time.

* Strong privacy posture (export/delete; parent controls) builds trust → retention.

## **7\) Operations**

* **Build:** Native SwiftUI; modular features; Swift Testing for fast iteration (Apple’s new testing framework is part of Xcode 16+) [Apple Developer](https://developer.apple.com/documentation/xcode-release-notes/xcode-16-release-notes?utm_source=chatgpt.com).

* **Infra (no vendor lock in):** Protocol-based services for Auth, Store, AI, OCR.

* **Support:** In-app FAQs; quick-reply macros; NPS after key milestones.

## **8\) Roadmap (18 weeks)**

* **Phase 0 (0–4):** Welcome/Auth/Onboarding → Dashboard v1 → LogGame (Live/After/OCR stubs) → Trial/Paywall v1 → Weekly rule-based summaries.

* **Phase 1 (5–8):** Stats \+ callouts → GoalPace \+ Badges → Skills micro-plans → Shareable card.

* **Phase 2 (9–12):** OCR v1 → Recruiting Roadmap \+ Emails → Parent Mode.

* **Phase 3 (13–16):** Advanced comparisons → Family seats → (Optional) Messaging \+ AI digests.

## **9\) KPIs**

* **North Star:** Weekly Active Improvement (% who log a game or receive an AI summary).

* D7/D30 retention; Trial→Pro ≥20%; AI helpfulness ≥85%; OCR accuracy ≥85%; 95%+ users can log without error.

## **10\) Financial Snapshot (illustrative)**

* Year 1: 10k free → 2k paid; ARPU \~$12/mo blended → \~$288k ARR.

* CAC low via organic school/parent loops; margin high (mobile SaaS) with AI costs controlled via quotas.

## **11\) Risks & Mitigations**

* **Data entry fatigue:** One-thumb counters \+ OCR; post-log dopamine (badges, summary).

* **AI reliability:** Rule-based fallbacks; tight prompts; explicit “official vs scrimmage” scopes.

* **Privacy:** Clear consent, export/delete, parent controls.

## **12\) Competitive Landscape / Why Us**

Most tools track; we **coach**. Our emotional design \+ AthleteDNA feedback loop builds a compounding moat—every log makes StatLocker more irreplaceable.

# **TL;DR (order \+ why)**

* **Start with UI skeleton \+ mocks**, then wire auth/storage.

* Sequence: **Scaffold → Theme → Assets → Nav Shell → Dashboard (mock) → Log Game UI \+ validation → Stats (mock) → Onboarding (mock) → Paywall (stub) → AI Coach (stub) → Auth \+ Firebase → OCR.**

* This keeps velocity high and avoids blocking on setup.

# **Tab bar \+ FAB (Apple-friendly)**

* **Recommended (iOS-native):** make **Log** the **center tab** (modal sheet opens). This matches many iOS apps and avoids floating/obstruction issues.

* **Optional (feature-flag):** a **bottom-right floating button**. If you try it, keep it 56–64pt, 16pt above the tab bar, never overlaps tab taps, VoiceOver label “Log Game”, and adds haptics.

* You can A/B behind `FAB_VARIANT=centerTab|floating` (FeatureFlags).

---

## **Step 1 — Project Scaffolding**

**Goal:** folder layout, feature flags, dependency stubs.

**PROMPT →**  
 “Create a SwiftUI app ‘StatLocker’. Add folders: App, CoreKit, CoreUI, Services, Features/(Welcome, Auth, Onboarding, Dashboard, Logging, Stats, Goals, Recruiting, Paywall, Parent), Resources, Tests. Add `FeatureFlags.plist` with `AI_ENABLED`, `OCR_ENABLED`, `PAYWALL_ENABLED`, `FAB_VARIANT`. Create protocol stubs: `AuthService`, `StoreService`, `AIService`, `OCRService`, `AnalyticsService` with in-memory mocks. Print debug logs `[StatLocker][Boot]`.”

**Accept:**

* App compiles; flags readable; mocks injected via simple container.

---

## **Step 2 — Design Tokens (from the PDF)**

**Goal:** semantic colors, typography, spacing, shadows.

**PROMPT →**  
 “Create `Theme.swift` in CoreUI with semantic `Color` extensions from these hexes:  
 Primary `#4F46E5`, PrimaryPressed `#4338CA`, AccentEmerald `#1AEC88`, AccentTeal `#0BF8CB`, TextPrimary `#0F172A`, TextSecondary `#334155`, Divider `#E2E8F0`, Success `#22C55E`, Warning `#F59E0B`, Error `#EF4444`, Muted `#A3A3A3`.  
 Add chart palette (12 colors) matching the Design Theme PDF.  
 Expose `Typography` using SF (Rounded for numbers, Regular/Semibold for text), and a spacing scale \[4,8,12,16,20,24,32\]. Provide a `StatTile` component.”

**Accept:**

* One place to change colors; `StatTile` preview works in Light/Dark.

---

## **Step 3 — Brand assets & icons**

**Goal:** app icon, launch gradient, SF Symbols map.

**PROMPT →**  
 “Add Assets: AppIcon placeholder, gradient launch image, symbols: house.fill, chart.line.uptrend.xyaxis, plus.circle.fill, target, graduationcap.fill, person.crop.circle. Build `Icon.swift` mapping usage → SF Symbol name. Ensure VoiceOver labels.”

**Accept:**

* Icons render; Launch shows gradient \+ logo.

---

## **Step 4 — Navigation Shell**

**Goal:** 5 tabs \+ drawer \+ (Log as center tab by default).

**PROMPT →**  
 “Create `MainTabView` with 5 tabs: Home (Locker), Stats, **Log**, Goals, Recruiting. The **Log** tab opens a **bottom sheet** (Live / After / OCR). Add top-right avatar on Home that opens a right-side drawer with: Profile, Parent Mode, Subscriptions, Settings, Help, Feedback. Respect `FAB_VARIANT`: if ‘floating’, overlay a 60pt FAB bottom-right that opens the same sheet.”

**Accept:**

* Tabs switch; sheet opens from center “Log”; drawer slides in; feature flag flips FAB behavior.

---

## **Step 5 — Dashboard (mock)**

**Goal:** first “wow”—header HS|Club toggle \+ tiles \+ AI card placeholder.

**PROMPT →**  
 “Build `DashboardScreen`: header segmented control HS | Club (persist last choice), AI Summary card (mock text), 4 stat tiles (Save%, Saves, Shots, Goals Allowed), goals progress bar, Recent Games list (mock). Add FAB pulse if `FAB_VARIANT=floating`.”

**Accept:**

* Context toggle updates tiles/list (mocked); 60fps scroll; VoiceOver labels.

---

## **Step 6 — Log Game UI \+ validation (official games only)**

**Goal:** full logging flow, no persistence yet.

**PROMPT →**  
 “Implement `LogGameBottomSheet` with three actions: Live Game, After Game, Scan (OCR). Meta chips: HS | Club; **Conference | Non-Conference** (only when HS); Opponent field.  
 After Game form: \+/− counters for Shots, Saves, Goals Allowed, Clears; auto Save% calc; validation `saves ≤ shots` and `goals = shots − saves`; allow override with yellow warning and debug log. On Save, append to in-memory store and show success toast.”

**Accept:**

* Happy path \<90s; validation warnings appear; entry added to mock store.

---

## **Step 7 — Stats (mock from store)**

**Goal:** charts \+ filters \+ compare.

**PROMPT →**  
 “Create `StatsScreen` reading from mock store. Filters: All, Conference, Non-Conference. Scope chips: HS | Club | Compare. In Compare, show split lines for Save% with a concise callout when delta \>5%. Persist filters per user.”

**Accept:**

* Filter and scope change re-render; callouts show; no jank.

---

## **Step 8 — Onboarding (mock)**

**Goal:** capture AthleteDNA basics, no backend.

**PROMPT →**  
 “Build a 5-step Onboarding: (1) Team/Gender, Grad Year, Level (Freshman/JV/Varsity) (2) Position (primary) (3) Club toggle (4) Pick 3 season goals (5) Tone quiz (Hype/Mentor/Analyst/Captain) (6) Review → Enter Locker. Save to in-memory profile; resume if interrupted.”

**Accept:**

* Cannot advance without required fields; resume works.

---

## **Step 9 — Paywall (stub) \+ AI Coach (stub)**

**Goal:** gates and dopamine.

**PROMPT →**  
 “Add `PaywallScreen` with Free (7-day trial), Pro, Elite, Family tiers. Add feature checks for AI/OCR based on plan (stubs). Add `AICoachServiceMock` that generates a 2–3 sentence summary using last game deltas \+ tone, with rule-based fallback. Show AI card after save.”

**Accept:**

* Plan switches gate features; AI card shows instantly.

---

## **Step 10 — Auth \+ Firebase wiring**

**Goal:** real users, sync.

**PROMPT →**  
 “Integrate `AuthServiceFirebase` (Sign in with Apple/Google/Email). Migrate in-memory `Profile` and `GameLog` to a `StoreServiceFirebase` using a simple collection layout: `/users/{uid}/games/{gameId}` and `/users/{uid}/profile`. Add merge from local drafts after login. Preserve DI; keep mocks for Debug.”

**Accept:**

* Sign in works; new logs persist; app restores after relaunch; no crashes offline.

---

## **Step 11 — OCR v1**

**Goal:** photo → parsed numbers (editable).

**PROMPT →**  
 “Implement `OCRService` placeholder with camera capture, text recognition, and field mapping to Shots/Saves/Goals/Clears with confidence chips. Always allow manual edits. Log `[StatLocker][OCR]` with confidences.”

**Accept:**

* Clear image auto-fills; low confidence prompts edits; save works.

---

### **Final polish checklist**

* Haptics on key taps, 44pt minimum targets, Dynamic Type ok.

* VoiceOver labels (e.g., “Log Game”, “Conference chip selected”).

* Empty states friendly; no references to scrimmages/practices.

* Debug logs prefixed `[StatLocker]`.

---

### **Quick answer to “Auth first or UI first?”**

**UI first with mocks**, then add Auth \+ Firebase (Step 10). You’ll move faster, demo sooner, and keep architecture clean with DI. Auth/persistence are easier once the flows exist.

[image1]: <data:image/png;base64,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>