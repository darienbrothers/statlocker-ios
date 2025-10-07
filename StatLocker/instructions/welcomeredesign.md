# 🏆 StatLocker Onboarding Redesign (Elite Version)
_Last updated: Oct 2025_

## 🎯 Overview
This onboarding redesign delivers a **premium, athlete-focused** experience aligned with StatLocker’s brand: data-driven, motivational, and visually striking.  
It consists of **4 swipeable screens** with consistent hero visuals, optimized typography, and smooth animations.

---

## ⚙️ Structure Overview

| Slide | Theme | Core Message | Visual Focus |
|-------|--------|--------------|---------------|
| 1 | Hero Mission | Brand identity & tagline | Athlete hero photo + logo |
| 2 | Track Smarter | Stat tracking made simple | Data dashboard visual |
| 3 | AI Insights | Performance analysis | Futuristic data visualization |
| 4 | Organization & Motivation | Recruiting + goals + focus | Calendar + checklist + badges |

---

## 🟣 Slide Details

### **Slide 1 – Hero Mission**
**Header:**  
> Your Game. Your Stats. Your Story.

**Subtext:**  
> Discover how StatLocker helps you track your performance, visualize your growth, and stay motivated.
> Swipe to explore! → 

**Design Notes:**  
- Use a **dark athlete background** (intense lighting, center focus).  
- Apply **black gradient overlay**:  
  - `LinearGradient(colors: [#000000E6, #00000033], start: top, end: bottom)`  
- Maintain clear spacing:  
  - Title 80px from top safe area  
  - Subtitle 8–10px below title  
- Add soft purple glow (`#6366F1` at 15% opacity) behind the athlete for depth.

---

### **Slide 2 – Track Smarter**
**Header:**  
> Track your performance, effortlessly.

**Subtext:**  
> Log your stats after every game or workout — StatLocker turns your numbers into a story you can see and share.

**Design Notes:**  
- Same athlete image can be reused or switch to a subtle 3D dashboard render.  
- Font hierarchy:
  - Header: `30pt / Bold / White`
  - Subtext: `16pt / Regular / rgba(255,255,255,0.8)`
- Constrain text width to 85% of the screen.  
- Ensure no overflow:
  ```swift
  .minimumScaleFactor(0.9)
  .lineLimit(2)
  .multilineTextAlignment(.center)
  ```
- Maintain spacing consistency across slides.

---

### **Slide 3 – Unlock AI Insights**
**Header:**  
> See patterns. Find your edge.

**Subtext:**  
> AI-powered insights reveal trends, strengths, and areas for improvement — giving you data to perform at your best.

**Design Notes:**  
- Visual: Abstract AI brain or neural graph overlay.  
- Add animated glowing data lines in purple + emerald (`#6366F1 → #10B981`).  
- Keep the tone futuristic but athletic, not overly “techy.”  
- Add subtle fade-in animation for headline + data lines.

---

### **Slide 4 – Stay Organized. Stay Locked In.**
**Header:**  
> Stay organized. Stay locked in.

**Subtext:**  
> Plan your recruiting journey, set season goals, and earn badges as you improve — everything you need to stay focused and motivated.

**Design Notes:**  
- Visual direction:  
  - 3D checklist, calendar, or badge visuals with light gradients.  
  - Maintain brand gradient overlay for cohesion.  
- Use motion to emphasize completion (e.g., checkmark or confetti animation).  

---

## 🎨 Visual Design System

### **Color Palette**
| Purpose | Color | Notes |
|----------|--------|-------|
| Background Gradient | `#0B0B14 → #1A1A2E` | Deep athletic dark tone |
| Primary Accent | `#6366F1` | Brand purple |
| Secondary Accent | `#10B981` | Growth green |
| Button Gradient | `LinearGradient(#6366F1 → #10B981)` | Hero CTA |
| Text | `#FFFFFF` / `rgba(255,255,255,0.8)` | Clean contrast on dark bg |

---

### **Typography**
| Element | Font | Weight | Size | Line Height |
|----------|------|---------|------|--------------|
| Header | Anton / League Spartan | Bold | 28–30pt | 34pt |
| Subtext | Plus Jakarta Sans | Regular | 16–18pt | 22pt |
| Button | Plus Jakarta Sans | SemiBold | 16pt | 22pt |
| Log In link | Plus Jakarta Sans | Medium | 14pt | — |

> **Tip:** Use dynamic font sizing with auto-scaling to avoid cutoff.  
> Maintain horizontal padding `32–36px` for all text blocks.

---

## 🔘 Buttons & Pagination

**Primary CTA Button:**  
- Text: `Get Started`  
- Gradient: Purple → Green (`#6366F1 → #10B981`)  
- Height: 56px  
- Corner Radius: 20px  
- Shadow: `0px 4px 12px rgba(99, 102, 241, 0.4)`

**Pagination Dots:**  
- Total: 4  
- Active Dot: `#6366F1` scaled 1.3x  
- Inactive Dot: `#3F3F46`  
- Fade & scale animation on swipe.

---

## 🧠 Micro-Interactions
- Fade-in animation for each slide:  
  - **Header:** 200ms delay  
  - **Subtext:** 400ms delay  
  - **CTA Button:** 600ms delay
- Parallax motion on swipe (background moves slightly slower).  
- Subtle haptic feedback when reaching the final slide.

---

## 📱 Layout Reference (Safe Area / Vertical Spacing)
| Section | Spacing |
|----------|----------|
| Top Safe Area → Header | 80px |
| Header → Subtext | 8–12px |
| Subtext → Pagination | 24px |
| Pagination → Button | 60px |
| Button → Log In link | 20px |
| Bottom Padding | 34px (for iPhone Pro safe area) |

---

## 💡 Implementation Tips
- Keep `Get Started` button fixed at bottom for all slides.  
- Use identical vertical alignment across all slides to avoid “jumping.”  
- Reuse the same image background for cohesion — different overlays can imply motion.  
- Ensure accessibility contrast ratio ≥ 4.5:1.

---

## ✅ Final Slide Order (UX-Approved)

1️⃣ **Your Game. Your Stats. Your Story.**  
→ Introduces mission and emotional hook.

2️⃣ **Track your performance, effortlessly.**  
→ Explains action + benefit.

3️⃣ **See patterns. Find your edge.**  
→ Communicates AI and data value.

4️⃣ **Stay organized. Stay locked in.**  
→ Reinforces discipline and motivation.

---

## 🏁 Deliverable Goal
When implemented, this onboarding sequence should:
- Feel **cinematic yet clean**
- Scale perfectly across iPhone 12–15 sizes
- Emotionally connect with athletes across all sports
- Leave users with one clear next step: **Get Started**

---

### ✅ Assets Checklist
- [ ] Final background image (high-contrast athlete portrait)
- [ ] Gradient overlay (black 80% → 30%)
- [ ] Gradient button background (Purple → Green)
- [ ] App logo (white / gradient variant)
- [ ] Updated typography (Anton + Plus Jakarta Sans)
- [ ] Lottie or subtle fade animations for transitions

---

**Author:** Product Design Team — StatLocker AI 2.0  
**Version:** 1.0  
**Document Type:** Visual Design Specification  
