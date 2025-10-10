# StatLocker - Next Steps & Roadmap

## 🎯 Current Status (Oct 9, 2025)

### ✅ Completed
- **B-001:** Setup (Colors, fonts, design tokens) ✓
- **B-002:** Auth (Welcome, Sign-in, Firebase) ✓
- **B-003:** Onboarding (8 steps, profile creation) ✓
- **B-004:** Dashboard (Hero card, stats, goals, AI insights, FAB) ✓
- **B-005 Phase 1:** After Game Logging (All positions) ✓

### ⏳ In Progress
- **B-005 Testing:** Log 3-5 games and verify Dashboard updates

---

## 📋 Immediate Next Steps

### 1. Test After Game Flow (30-60 min)
**Priority:** 🔴 HIGH

**Action Items:**
- [ ] Build project (`Cmd+B`)
- [ ] Log 3-5 games with After Game flow
- [ ] Verify Dashboard updates correctly
- [ ] Test validation warnings
- [ ] Test HS/Club context switching
- [ ] Check debug logs in console

**Success Criteria:**
- All games save to Firebase
- Dashboard shows real stats
- AI Insights appear after 3rd game
- Context toggle filters correctly
- No crashes or major bugs

**See:** `instructions/b-005-after-game-testing-guide.md` for detailed checklist

---

## 🗺️ Roadmap: What to Build Next

### Option A: Continue B-005 Logging Features

#### **B-005 Phase 2: Live Game** (3-4 hours)
**Complexity:** 🟡 Medium-High

**What it includes:**
- Real-time timer with pause/resume
- Quarter selector (Q1-Q4)
- Big +/- buttons for stats
- Auto-draft every 10 seconds
- Undo last 3 actions
- Recovery on app interruption
- Works offline

**Why build this:**
- More engaging user experience
- Captures more granular data (quarter breakdowns)
- Real-time logging during games
- Better for competitive players

**Why skip for now:**
- More complex than After Game
- After Game covers core need
- Can defer to Phase 1 polish

---

#### **B-005 Phase 3: OCR Scan** (5-6 hours)
**Complexity:** 🔴 High

**What it includes:**
- Camera integration
- ML/Vision framework for text recognition
- Confidence scoring per field
- Manual override for low confidence
- Helper tips for better scans

**Why build this:**
- Saves time for paper stat sheets
- Cool "wow" feature
- Differentiator from competitors

**Why skip for now:**
- Most complex logging method
- Requires ML training/tuning
- After Game + Live cover 95% of use cases
- Can defer to Phase 2

---

### Option B: Build Stats & Analysis (Recommended)

#### **B-006: Stats Page** (4-5 hours)
**Complexity:** 🟡 Medium

**What it includes:**
- Line charts for Save % over time
- Bar charts for totals
- Filter chips (All/HS/Club/Compare)
- AI insight callouts on charts
- Quarter performance breakdown
- Export stats as image

**Why build this next (Recommended):**
✅ You now have real game data to visualize
✅ Unlocks key user value (seeing trends)
✅ Completes core "log → analyze" loop
✅ Relatively straightforward with SwiftUI Charts
✅ High impact for recruiting use case

**User Stories unlocked:**
- US-003: See trends over the season
- US-013: Share season highlights

---

#### **B-007: Goals Page** (3-4 hours)
**Complexity:** 🟢 Low-Medium

**What it includes:**
- Full goal detail view (expanded from Dashboard)
- GoalPace AI (On Track / Catch Up / Stretch)
- Per-game pace vs target pace
- Smart goal recommendations
- Badges (Consistency, Clutch, Iron Wall)
- Milestone celebrations (25/50/100 saves)
- Edit/add custom goals

**Why build this:**
- Gamification & motivation
- Goal tracking is core value prop
- Relatively simple (mostly UI)
- High user engagement

**Why defer:**
- Dashboard already shows goal progress
- Can polish in Phase 1
- Stats page higher priority

---

### Option C: Advanced Features

#### **B-008: Skills/Drills Tab** (4-5 hours)
**Complexity:** 🟡 Medium

**What it includes:**
- Drill library (organized by position)
- AI drill recommendations based on stats
- Progress tracking (completion streaks)
- Micro-plans (daily 5-10 min drills)

**Why build this:**
- Closes the loop: log → analyze → improve
- High retention (daily engagement)
- Premium feature for paywall

**Why defer:**
- Need more game data to make smart recommendations
- Build after Stats page

---

#### **B-009: Recruiting Page** (3-4 hours)
**Complexity:** 🟢 Low-Medium

**What it includes:**
- Readiness score (0-100%)
- Checklist (transcript, reel, 10+ games)
- AI email builder for coaches
- Profile export (shareable PDF/image)
- School compatibility scores

**Why build this:**
- Core differentiator for high school athletes
- Premium feature
- High perceived value

**Why defer:**
- Need at least 5-10 games logged first
- Build after Stats page

---

## 🎯 Recommended Build Order

### Phase 0 (MVP - Current)
1. ✅ **B-001:** Setup
2. ✅ **B-002:** Auth
3. ✅ **B-003:** Onboarding
4. ✅ **B-004:** Dashboard
5. ✅ **B-005 Phase 1:** After Game Logging
6. ⏳ **Testing & Bug Fixes**

### Phase 1 (Core Loop)
7. **B-006:** Stats Page ← **Start here next**
8. **B-007:** Goals Page (with badges)
9. **B-011:** Paywall (7-day trial)
10. **Polish:** Bug fixes, performance, accessibility

### Phase 2 (Engagement)
11. **B-005 Phase 2:** Live Game
12. **B-008:** Skills/Drills
13. **B-012:** AI Integration (real OpenAI)
14. **B-010:** Parent Mode

### Phase 3 (Advanced)
15. **B-009:** Recruiting
16. **B-005 Phase 3:** OCR
17. **B-013:** Shareable Season Cards
18. **B-014:** Offline & Sync
19. **B-015:** Social Sharing

---

## 📊 Decision Matrix

| Feature | Impact | Effort | Priority | Build Next? |
|---------|--------|--------|----------|-------------|
| **B-006: Stats Page** | 🟢 High | 🟡 Med | ⭐⭐⭐⭐⭐ | ✅ **YES** |
| **B-007: Goals Page** | 🟡 Med | 🟢 Low | ⭐⭐⭐⭐ | After Stats |
| **B-005 Live Game** | 🟡 Med | 🔴 High | ⭐⭐⭐ | Phase 2 |
| **B-008: Skills** | 🟡 Med | 🟡 Med | ⭐⭐⭐ | Phase 2 |
| **B-009: Recruiting** | 🟡 Med | 🟢 Low | ⭐⭐⭐ | After Stats |
| **B-011: Paywall** | 🟢 High | 🟢 Low | ⭐⭐⭐⭐ | After Goals |
| **B-005 OCR** | 🟢 Low | 🔴 High | ⭐⭐ | Phase 3 |

---

## 🚀 My Recommendation: Build Stats Page Next

### Why?
1. **You have real data now** - After logging 3-5 games, you'll have actual data to visualize
2. **High user value** - Seeing trends is core to the value proposition
3. **Unlocks recruiting** - Need stats page before building recruiting features
4. **Medium complexity** - Challenging but achievable (SwiftUI Charts API)
5. **Completes core loop** - Log → View Stats → Track Goals

### What it looks like:
```
Stats Tab
├── Chart View (Line/Bar toggle)
├── Filter Chips (All/HS/Club/Compare)
├── AI Insights on charts ("Your Q3 is strong!")
├── Quarter breakdown table
├── Game history list
└── Export button
```

### Estimated time: 4-5 hours
- 1-2 hours: Chart setup (SwiftUI Charts)
- 1 hour: Filter logic
- 1 hour: AI insight integration
- 1 hour: Polish & testing

---

## 📝 Alternative: Quick Wins Before Stats

If you want smaller wins first:

### Quick Win 1: Dashboard Polish (30 min)
- Add pull-to-refresh
- Add loading states
- Improve empty state copy
- Add skeleton loaders

### Quick Win 2: Profile Picture Upload (45 min)
- Add photo picker to profile
- Save to Firebase Storage
- Display in Hero Card
- Update throughout app

### Quick Win 3: Goal Editing (30 min)
- Make Goals card fully functional
- Edit existing goals
- Add new custom goals
- Delete goals

---

## 🎬 Next Command

After testing After Game:

**If ready to build Stats:**
```
"Let's implement B-006 Stats Page with charts and filters"
```

**If you want polish first:**
```
"Let's add pull-to-refresh and profile picture upload to Dashboard"
```

**If you want Live Game:**
```
"Let's implement B-005 Phase 2 Live Game with timer and quarters"
```

---

## 📊 Current Progress: 31% Complete

**Features Built:** 5 / 16 major features
- Setup ✓
- Auth ✓
- Onboarding ✓
- Dashboard ✓
- After Game Logging ✓

**Next milestone:** 50% (8/16) - Complete core loop
- Add: Stats Page, Goals Page, Paywall

**MVP Target:** 65% (10/16) - Launchable product

---

**You're doing great! Test the After Game flow, then let's build Stats Page next. 🚀**

