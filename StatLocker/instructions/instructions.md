# StatLocker 2.0 — iOS App Requirements (Official Games Only)

You are an experienced iOS app developer who explains things in grade 5 level English without technical jargon.
Create a simple, step-by-step REQUIREMENTS DOCUMENT for StatLocker 2.0, an AI-powered iOS sports app built with Swift, SwiftUI, and Xcode.

---

## 1. App Overview
StatLocker helps high school and club athletes track **official game** stats and improvement. After each game, the app gives a short, friendly AI summary that explains what went well and what to do next. It shows season trends, goals, and a simple path for recruiting.

---

## 2. Main Goals
1. Make logging **official games** super easy and fast.
2. Give **instant AI feedback** after each game.
3. Show clear **trends** and **goal progress**.
4. Let athletes switch between **High School** and **Club** teams.
5. Keep a simple **recruiting roadmap**.
6. Offer a **positive Parent Mode** (read‑only).
7. Provide a **7‑day free trial** and paid plans.

---

## 3. User Stories
- [ ] **US-001**: As an athlete, I want to log my game stats quickly so I don't forget.
- [ ] **US-002**: As an athlete, I want AI to tell me what I did well and what to do next.
- [ ] **US-003**: As an athlete, I want to see my trends over the season.
- [ ] **US-004**: As a player on school and club teams, I want to switch views easily.
- [x] **US-005**: As a new user, I want onboarding that is short and clear.
- [ ] **US-006**: As a parent, I want a weekly positive summary to celebrate wins.
- [ ] **US-007**: As a user, I want to try the app for free before paying.
- [ ] **US-008**: As a user, I want my data backed up and safe.
- [ ] **US-009**: As a coach, I want consistent, accurate logs.
- [x] **US-010**: As a user, I want the app to feel clean, modern, and motivating.
- [ ] **US-011**: As a new player, I want to see practice drill recommendations before my first game.
- [ ] **US-012**: As an athlete, I want to earn badges for my achievements.
- [ ] **US-013**: As a user, I want to share my season highlights with friends.
- [ ] **US-014**: As a family, I want to track multiple athletes with one account.
- [ ] **US-015**: As a user, I want the app to work even when I'm offline.

---

## 4. Features
- [ ] **F-001. Game Logging**
- Log **official games only** (no scrimmages, no practices).
- Choose **Context**: High School (HS) or Club.
- If HS → pick **Conference** or **Non‑Conference**.
- Enter **Opponent**.
- Enter stats: **Shots Faced**, **Saves**, **Goals Allowed**, **Clears**.
- Validate math: **Saves + Goals = Shots**. If not, show a friendly alert.
- Save with **Date**, **Context**, **Opponent**, and **Source** (Live / After / OCR).

- [ ] **F-002. Live Game Mode**
- **Timer**: Start/Pause with quarter selector (Q1–Q4).
- Large +/− buttons for Saves, Shot Against, Goal Allowed, Clears.
- **Quarter Management**: End quarter locks tally; editable via "Adjust".
- **Auto‑draft**: Every 10 seconds; auto-pause on phone lock.
- **Recovery**: "Resume Live?" prompt when returning to app.
- **Haptics**: Light tick on each +; medium on quarter end.
- **Undo**: Available for last 3 actions (4s undo pill).
- Works offline; sync later.

- [ ] **F-003. OCR Scan Mode**
- Take a photo of a paper stat sheet.
- **Confidence Scoring**: Shows confidence chips for each field.
- **Validation**: Fields below 70% confidence highlighted for review.
- **Smart Detection**: Attempts to auto-detect team context.
- **Manual Override**: User can edit any field before saving.
- **Helper Tips**: "Good light helps. Tip: tilt phone to avoid glare."
- **Success Message**: "OCR saved you ~40 taps. Nice."

- [ ] **F-004. Dashboard (Home)**
- Greeting, HS|Club toggle, stat tiles, goal bars.
- AI summary card (2–3 lines) with one "Next step". 
- **Recent Games** list with tap-to-view AI summaries.
- **Badges & Streaks** display.
- **Skills Micro-Plan**: "Today's Plan: 5-min Reflex L2".
- Floating Action Button (FAB) to log a game.
- **Empty State**: For new users, shows skills recommendations and demo data.

- [ ] **F-005. Stats Page**
- **Charts**: Save% and totals over time with AI callouts.
- **Smart Insights**: "You perform 18% better in the 3rd quarter."
- **Filters**: **All**, **HS**, **Club** (persist per user).
- **Compare View**: Side-by-side HS vs Club performance.
- **Quarter Breakdown**: Performance by quarter.
- **Situational Analysis**: Home/away, opponent type comparisons.

- [ ] **F-006. Goals Page** (goal reminders notifications in apple keys)
- **Season Goals**: "100 total saves", "75% Save Rate".
- **GoalPace AI**: **On Track**, **Catch Up**, or **Stretch** messages.
- **Smart Recommendations**: AI suggests realistic stretch goals.
- **Progress Tracking**: Visual progress bars and pace indicators.
- **Badges**: Consistency (3/5/10 logs), Clutch (best Save%), Iron Wall (low GA streak).
- **Milestones**: 25/50/100 saves; target Save% achieved.
- **Streak Protection**: Pauses during illness/injury (no penalty).

- [ ] **F-007. Recruiting Page**
- **Readiness Score**: 0-100% completion bar.
- **Checklist**: Upload transcript, add highlight reel, log 10+ games.
- **AI Email Builder**: Custom templates for college coaches.
- **Recruiting Roadmap**: Dynamic compatibility scoring with schools.
- **Profile Export**: Clean, shareable recruiting profile.
- **Email Templates**: "Hi Coach [Name], I'm a [Grad Year] [Position] with a [Save%]."

- [ ] **F-008. Parent Mode**
- **Read‑Only Dashboard**: No editing capabilities.
- **Weekly Digest**: "London's save % improved 12% this month."
- **Celebration Focus**: Positive highlights and milestones.
- **Multi-Athlete**: Family Plan supports 2-4 athletes.
- **Shareable Moments**: "Proud Parent Moments" for social media.
- **Progress Insights**: Easy-to-read growth summaries.

- [ ] **F-009. Paywall + Trial**
- **7‑day free trial** with full feature preview.
- **Free**: Basic logging, 3 AI summaries, limited features.
- **Pro ($9.99/mo)**: 10 AI summaries/mo, weekly reports, limited OCR, recruiting basics.
- **Elite ($19.99/mo)**: Unlimited AI insights, advanced analytics, full OCR, recruiting roadmap + email builder.
- **Family ($24.99/mo)**: 2-4 athletes + Parent Mode+ with shared billing.
- **Feature Gates**: Clear upgrade prompts when hitting limits.

- [ ] **F-010. AI Coach Feedback**
- **Instant Summaries**: 2-3 sentences after each game.
- **Tone Options**: **Hype**, **Mentor**, **Analyst**, **Captain**.
- **Always Ends**: With one concrete next step.
- **Context Awareness**: Different messaging for HS vs Club games.
- **Fallback**: Rule-based copy if AI unavailable.
- **Micro-Actions**: "Run 8 mins of Reflex Drill 2 tonight."

- [ ] **F-011. Skills/Drills Tab**
- **AI Skill Recommender**: "Your lateral reaction time is lagging — try Reflex Wall Drill Level 2."
- **Drill Library**: Organized by position and skill focus.
- **Progress Tracking**: Completion streaks and improvement metrics.
- **Drill Recommendations**: For new users before first game.
- **Micro-Plans**: Daily 5-10 minute focused drills.

- [ ] **F-012. Badges & Achievements**
- **Consistency Badges**: 3/5/10 game logging streaks.
- **Performance Badges**: Clutch, Iron Wall, Comeback.
- **Milestone Badges**: 25/50/100 saves, recruiting achievements.
- **Celebration**: Confetti animations and haptic feedback.
- **Social Sharing**: Badge unlock notifications.

- [ ] **F-013. Shareable Season Cards**
- **AI-Generated**: "Your save consistency is elite" taglines.
- **Key Stats**: Top 3 performance metrics.
- **Visual Export**: Image format for social media.
- **One-Click Share**: Built-in sharing to Instagram, Twitter.

- [ ] **F-014. Offline & Sync**
- **Offline Logging**: Queue logs locally when no connection.
- **Auto-Sync**: Upload when connection restored.
- **Draft Recovery**: Auto-save every 10 seconds in Live mode.
- **Conflict Resolution**: Smart merge for simultaneous edits.
- **Zero Data Loss**: Guaranteed on app crash or network loss.

---

## 5. Screens
- [x] **S-001. Welcome** — Tagline, Get Started, Log In.
- [x] **S-002. Auth** — Sign in with Apple, Google, or Email.
- [x] **S-003. Onboarding (8 steps)** — Sport, Team + Gender, Profile Details, Position, Team Info, Season Goals, Tone quiz, Review.
- [ ] **S-004. Dashboard (Locker)** — AI card, tiles, goal bars, badges, FAB.
- [ ] **S-005. Log Game (Bottom Sheet)** — Live / After / OCR, HS|Club, Conference chip (HS only), Opponent, Stats, Validation.
- [ ] **S-006. Stats** — Charts, filters (All / HS / Club), HS|Club|Compare, AI insights.
- [ ] **S-007. Goals** — Progress, pace, badges, GoalPace AI.
- [ ] **S-008. Skills** — Drill library, AI recommendations, progress tracking.
- [ ] **S-009. Recruiting** — Readiness, checklist, AI email builder.
- [ ] **S-010. Parent Mode** — Weekly digest, multi-athlete view.
- [ ] **S-011. Paywall** — Trial + plans (Free/Pro/Elite/Family).
- [ ] **S-012. Settings Drawer** — Profile, Parent Mode, Subscriptions, Help, Feedback, Logout.
- [ ] **S-013. Badges** — Achievement gallery, unlock criteria.
- [ ] **S-014. Share Card** — Season highlights, social export.

---

## 6. Data
- [x] **D-001. Athlete Profile** — Name, Email, Grad Year, Position, Level, Tone.
- [x] **D-002. Team Info** — HS name, Club name (optional), Level, City, State.
- [ ] **D-003. Game Log** — Date, Context (HS/Club), Conference (HS only), Opponent, Shots, Saves, Goals, Clears, Source, AI summary text, Quarter breakdowns.
- [x] **D-004. Goals** — Type, Target, Progress, Status (On Track / Catch Up / Stretch), AI recommendations.
- [ ] **D-005. Recruiting** — Readiness score, Checklist items, Coach email sent flag, School compatibility scores.
- [ ] **D-006. Subscription** — Plan, Trial start/end, Feature usage limits.
- [ ] **D-007. Parent Link** — Linked athlete IDs; digest summaries, visibility settings.
- [ ] **D-008. Badges** — Type, Unlock criteria, Date earned, Shared status.
- [ ] **D-009. Skills/Drills** — Drill ID, Completion date, Duration, Improvement metrics.
- [ ] **D-010. Sync Queue** — Offline logs, Conflict resolution data, Last sync timestamp.
- [ ] **D-011. AthleteDNA** — Performance patterns, Behavior insights, Export/delete controls.

---

## 7. Extra Details
- **Internet**: Needed for login and AI; logging works offline.
- **Camera Permission**: Required for OCR functionality.
- **Local Storage**: Drafts auto-saved; syncs to cloud when online.
- **Dark Mode**: Fully supported with proper contrast ratios.
- **iOS Version**: Minimum iOS 17.0.
- **Accessibility**: Dynamic Type, high contrast, 44pt tap targets, VoiceOver labels.
- **Haptics**: Light tick on interactions, medium on confirmations.
- **Performance**: Smooth 60fps animations, lazy loading for large lists.
- **Security**: No PII in logs, export/delete AthleteDNA controls.
- **Privacy**: Clear consent for AI use, parent controls for minors.

---

## 8. Build Steps
- [x] **B-001**: **Setup** — Add colors, fonts, logos, and design tokens.
- [x] **B-002**: **Auth** — Build Welcome (S‑001) and Auth (S‑002) with Firebase.
- [x] **B-003**: **Onboarding** — Build Onboarding (S‑003) and save profile (D‑001, D‑002).
- [ ] **B-004**: **Dashboard** — Build Dashboard (S‑004) with FAB and empty states.
- [ ] **B-005**: **Logging** — Build Log Game (S‑005) with validation and all three modes.
- [ ] **B-006**: **Stats** — Build Stats (S‑006) with AI insights and smart filters.
- [ ] **B-007**: **Goals** — Build Goals (S‑007) with GoalPace AI and badges. (badge notifications in apple keys)
- [ ] **B-008**: **Skills** — Build Skills tab (S‑008) with drill library and AI recommendations.
- [ ] **B-009**: **Recruiting** — Build Recruiting (S‑009) with AI email builder.
- [ ] **B-010**: **Parent Mode** — Build Parent Mode (S‑010) with family plan support. (weekly digest notifications in apple keys)
- [ ] **B-011**: **Paywall** — Build Paywall (S‑011) with all tiers and feature gates.
- [ ] **B-012**: **AI Integration** — Connect AI Coach feedback (F‑010) with fallbacks.
- [ ] **B-013**: **OCR** — Implement OCR (F‑003) with confidence scoring.
- [ ] **B-014**: **Offline** — Add offline sync and draft recovery.
- [ ] **B-015**: **Sharing** — Build shareable season cards and social features.
- [ ] **B-016**: **Testing** — End‑to‑end testing; polish design and accessibility.

---

## 9. Validation & Edge Cases

### **Critical Validation Rules**
- **Math Validation**: Saves + Goals = Shots (with warning banner if mismatch)
- **Impossible Values**: Block only truly impossible (e.g., Saves > Shots when locked)
- **Data Integrity**: Never silently mutate user-entered stats
- **Override Options**: Allow user override with clear warnings and debug logs

### **Edge Cases**
- **Poor Network**: Save partial data locally; resume later
- **App Interruption**: Auto-pause Live Game timer; prompt "Resume Live?"
- **OCR Failures**: Confidence < 70% shows manual entry prompt
- **Duplicate Games**: Allow same date if different context (HS vs Club)
- **Missing Data**: Skip plotting bad data; prompt for fixes

### **Accessibility Requirements**
- **Touch Targets**: Minimum 44pt for all interactive elements
- **Dynamic Type**: Support all iOS text size preferences
- **VoiceOver**: Proper labels for all UI elements
- **High Contrast**: Support for accessibility color preferences
- **Haptics**: Light feedback on primary actions

### **Performance Targets**
- **Logging Speed**: FAB tap to saved After Game ≤ 90 seconds
- **Live Game**: FAB tap to running timer ≤ 3 taps
- **OCR Accuracy**: ≥ 85% field recognition confidence
- **App Launch**: ≤ 2 seconds to dashboard
- **Offline Sync**: Queue up to 50 logs; sync within 30 seconds of connectivity

---

App name: StatLocker
Tagline: Your Game. Your Stats. Your Story.
Focus: Official games only.
