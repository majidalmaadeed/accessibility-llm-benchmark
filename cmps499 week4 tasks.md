# cmps499 week4 tasks

the objective of this week is to complete the first tasks as spesified in the project plan.

## Step 1: Realistic Accessibility Violation Scenarios

### Violations

|Violation|Multiple Causes|Scope|
|---|---|---|
|Missing Labels|No|Universal|
|Missing Alt Text|No|Universal|
|Low Color Contrast|No|Universal|
|Small Touch Targets|No|Universal|
|Missing Language Attributes|No|Universal|
|Decorative Images with Alt|No|Universal|
|Missing Table Headers|No|Universal|
|Flashing Content|No|Universal|
|Generic Link Text|No|Universal|
|Status by Shape Only|No|Universal|
|Auto-playing Media|No|Universal|
|Missing Skip Links|No|Universal|
|Ungrouped Form Controls|No|Universal|
|Insufficient Element Spacing|No|Universal|
|Missing Page Titles|No|Web-specific|
|Focus Management Issues|Yes|Universal|
|Form Validation Problems|Yes|Universal|
|Custom Widget Semantics|Yes|Universal|
|Dynamic Content Updates|Yes|Universal|
|Navigation Structure Issues|Yes|Universal|
|Interactive Control Problems|Yes|Universal|
|Media & Animation Issues|Yes|Universal|
|Mobile Interaction Problems|Yes|Mobile-specific|
|Platform Integration Failures|Yes|Platform-specific|

### Scenarios

**Basic Level (0 Dependencies)**

Unlabeled Media Button : Video play button using only emoji icon without accessible name

Missing Image Alt Text : Product image in e-commerce card without alternative text

Low Contrast Warning Text : Session timeout warning with insufficient color contrast

Small Touch Target : Social share button only 20x20px on mobile interface

Missing Language Attribute : HTML page with mixed English/French content without lang attributes

Decorative Image with Alt Text : Decorative border image has unnecessary descriptive alt text

Missing Table Header : Data table using `<td>` elements instead of `<th>` for column headers

Flashing Advertisement : Sale banner flashing 5 times per second

Generic Link Text : "Read more" link without context about destination

Status by Shape Only : Document approval status indicated only by circle vs square shape

Auto-playing Background Video : Hero section video autoplays without user control

Missing Skip Link : Page navigation without skip-to-content link

Ungrouped Radio Buttons : Contact preference radio buttons without fieldset grouping

Insufficient Button Spacing : Action buttons placed 2px apart instead of minimum 44px

Missing Page Title : Settings page without descriptive `<title>` element

Inaccessible Tooltip : Help icon shows tooltip on hover only, not keyboard accessible

Silent Loading State : Content spinner without screen reader announcement

Color-Only Error Indication : Invalid form field marked only with red border

Keyboard Trap in Widget : Custom date picker traps keyboard focus inside

Right-Click Only Menu : Essential delete option only available via right-click

**Moderate Level (2-3 Dependencies)**

Form Validation Without Association : Login form with username input + password input + error message not linked to specific field

Modal Without Focus Management : Settings dialog with open button + modal overlay + close button but no focus trap

Custom Dropdown Navigation : Filter dropdown with trigger button + options list + selected state indicator

Search with Silent Updates : Search input + suggestions dropdown + results area without announcements

Carousel Without Controls : Image gallery with previous button + image display + next button lacking keyboard support

Auto-Refresh Content Disruption : News feed with article list + update notification + refresh mechanism

Accordion Without State : FAQ section with question headers + content panels + expand/collapse indicators

Toast Notification Issues : Success message with notification popup + dismiss button + auto-hide timer

Tab Interface Problems : Settings tabs with tab buttons + tab panels + active state indication

Progress Indicator Gaps : File upload with progress bar + status text + cancel button

Breadcrumb Navigation Issues : Page hierarchy with breadcrumb links + current page indicator + separator elements

Menu System Problems : Navigation with menu button + dropdown panel + menu items

**Advanced Level (5+ Dependencies)**

Data Table Complex : Employee table with sortable headers + filter inputs + pagination controls + row selection + action toolbar

Multi-Step Wizard : Registration flow with step indicators + form sections + navigation buttons + validation messages + progress tracking

Dashboard Widget : Analytics chart with data visualization + filter controls + legend + tooltip system + export options

Media Player Full Interface : Video player with play controls + volume slider + progress bar + fullscreen toggle + captions menu + quality selector

Shopping Cart System : E-commerce cart with item list + quantity controls + price calculator + promo code input + checkout buttons + shipping options

Calendar Application : Event calendar with month/week/day views + event creation + time slots + recurring options + reminder settings + category filters

Rich Text Editor : Content editor with formatting toolbar + text area + style panels + media insertion + undo/redo + word count

Complex Search Interface : Product search with query input + filter sidebar + sort options + result cards + pagination + view toggles

Interactive Map : Location finder with map display + zoom controls + marker system + info windows + search overlay + layer toggles

Social Media Feed : News feed with post cards + like/share buttons + comment sections + infinite scroll + notification system + user menus

### Frameworks

**Web Frameworks**

- React, Vue, Angular, Svelte
- Next.js, Nuxt, SvelteKit

**Mobile Native**

- iOS: SwiftUI, UIKit
- Android: Jetpack Compose, Android Views

**Cross-Platform Mobile**

- React Native, Flutter
- Xamarin, Ionic

**Desktop Native**

- Windows: WPF, WinUI
- macOS: SwiftUI, AppKit
- Linux: GTK, Qt

**Cross-Platform Desktop**

- Electron, Tauri
- Qt, .NET MAUI
- Flutter Desktop

## Step 2: Infrastructure Setup and Progress

### Hardware and Platform Configuration

Our testing environment consists of multiple platforms to ensure comprehensive accessibility evaluation across all major operating systems and devices:

**Physical Hardware:**

- 1 macOS machine - Primary development and iOS testing
- 1 Windows machine - Windows application testing and development
- 1 Linux machine - Linux desktop environment testing
- 1 iPhone - Physical iOS device testing for real-world validation
- Virtual OS capabilities - Additional platform testing when needed

**Emulation and Simulation:**

- Android emulator via Android Studio - Android application testing
- iOS Simulator via Xcode - iOS application development and testing

**Development Environments:**

- **Xcode** - macOS and iOS application development and simulation
- **Visual Studio** - Windows desktop application development (WPF, WinUI)
- **Android Studio** - Android application development and emulation
- **Web Browsers** - Cross-browser testing using Brave, Firefox, Safari, and Edge

**Screen Reader Coverage:**

- **NVDA** - Windows screen reader for desktop accessibility testing
- **TalkBack** - Android screen reader for mobile accessibility validation
- **Orca** - Linux screen reader for desktop environment testing
- **VoiceOver** - macOS and iOS screen reader for Apple ecosystem testing

### Version Control and Repository Structure

**GitHub Selection and Rationale:** GitHub was selected as our version control platform due to its industry-standard Git integration, collaborative features, and comprehensive project management capabilities. Git provides distributed version control allowing seamless work across multiple machines and platforms, while GitHub offers cloud-based repository hosting, issue tracking, and documentation features essential for research project management.

**Repository Architecture:** Our project repository `accessibility-llm-benchmark` follows a structured organization designed for systematic testing and evaluation:

```
accessibility-llm-benchmark/
├── scenarios/           # Test violation cases organized by complexity
│   ├── basic/          # 0 dependencies - independent components
│   ├── moderate/       # 2-3 dependencies - interconnected elements
│   └── advanced/       # 5+ dependencies - complex systems
├── frameworks/         # Platform-specific implementation examples
│   ├── web/           # React, Vue, Angular, Svelte
│   ├── mobile/        # React Native, Flutter, Swift, Kotlin
│   └── desktop/       # Electron, WPF, SwiftUI, GTK
├── evaluation/         # Scoring systems and analysis tools
├── results/           # LLM response outputs and test results
├── reports/           # Weekly progress and evaluation findings
└── documentation/     # Setup guides and methodology documentation
```

This structure enables systematic organization of test scenarios, clear separation of platform-specific code, and comprehensive tracking of evaluation results across different complexity levels and frameworks.

### Development Environment

**Integrated Development Environment:** Cursor IDE was selected as the primary development environment across all platforms due to its AI-assisted coding capabilities, cross-platform compatibility, and integrated support for multiple programming languages and frameworks. This ensures consistent development experience whether working on web applications, mobile apps, or desktop software.

**Manual Testing Focus:** Our methodology deliberately avoids automated accessibility testing tools in favor of manual validation using actual screen readers and assistive technologies. This approach ensures authentic user experience evaluation and provides more reliable assessment of real-world accessibility improvements generated by LLM models.