# Smart Home Application Redesign & Completion Plan

Redesign and complete all 14 screens of the Syna smart home application to closely match the premium, minimalist, and glassmorphic designs provided in the `stitch_syna_home_systems` reference assets.

## User Review Required

> [!IMPORTANT]
> - We will update the mock repositories/providers to add missing rooms/devices (`Garage`, `Bathroom`, `Garden`) to align the data across all screens (Home, Rooms, Energy, Camera, etc.).
> - Navigation routes will remain exactly as configured in `lib/app/router/app_router.dart`, but the design of `ShellScaffold` will be upgraded from a generic Material 3 `NavigationBar` to a custom glassmorphic bottom bar with thin stroke icons and active status dots.

## Open Questions

> [!NOTE]
> No critical open questions at this stage. We have full reference specs in the HTML files and will proceed to build equivalent native widgets in Flutter.

## Proposed Changes

---

### Core UI Framework & Helpers

#### [MODIFY] [app_card.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/core/widgets/app_card.dart)
- Upgrade `AppCard` to be stateful.
- Implement a subtle down-scale tap animation (scaling down to `0.98` when active/pressed and back to `1.0` on release) to provide a high-end tactile feel as defined in `lumina_ambient/DESIGN.md`.
- Implement glassmorphic properties (semi-transparent backgrounds with backdrop blur when possible, thin borders, and soft diffusion shadows).

#### [MODIFY] [app_button.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/core/widgets/app_button.dart)
- Redesign `AppButton` to support the premium rounded corner layout (`rounded-xl`), custom height (52px), custom letter spacing, and shadow overlays matching the primary accent color.

#### [MODIFY] [app_text_field.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/core/widgets/app_text_field.dart)
- Adjust prefix icons, text paddings, border radius (`rounded-xl` / 16px), border colors, and focused rings to match the input specifications in the design system.

#### [MODIFY] [shell_scaffold.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/app/router/shell_scaffold.dart)
- Redesign navigation to use a custom glassmorphism bottom bar with a 30px backdrop blur and semi-transparent background (white at 70% in light mode, dark/charcoal at 70% in dark mode).
- Use thin line icons and render a small indicator dot below the selected active icon.

---

### Shared Mock Repositories

#### [MODIFY] [mock_device_repository.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/devices/data/mock_device_repository.dart)
- Extend mock devices to include newly-required fields and add missing devices in Garage, Bathroom, and Garden to align with other screens.

#### [MODIFY] [room_providers.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/rooms/data/room_providers.dart)
- Add missing rooms: `Garage`, `Bathroom`, `Garden` and map their active/connected device counts.

---

### Feature Presentation Screens

#### [MODIFY] [splash_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/splash/presentation/splash_screen.dart)
- Implement light/dark radial gradient background with soft glowing atmosphere bubbles in corners.
- Render central geometric logo card with thin white borders, glassmorphic styling, and glowing effects.
- Add linear loading indicator with linear moving sweep animation.
- Add "Lumina" brand footer with tracked typography.

#### [MODIFY] [onboarding_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/onboarding/presentation/onboarding_screen.dart)
- Build a 3-step paging system representing onboarding slides (Control your world, Intuitive Automation, Total Security).
- Add background image parallax motion using the design's asset URL.
- Show active indicator dots as sliding pills and inactive as small grey dots.
- Support "Get Started", "Continue", and "Complete Setup" actions, alongside terms agreement.

#### [MODIFY] [login_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/authentication/presentation/login_screen.dart)
- Implement ambient blur gradients, a central welcome banner, and a premium glass card form.
- Add standard password visibility toggle and a "Sign in with FaceID" button.

#### [MODIFY] [register_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/authentication/presentation/register_screen.dart)
- Redesign register layout with custom fields, Terms and Conditions checkbox, and social divider.

#### [MODIFY] [home_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/home/presentation/home_screen.dart)
- Redesign app bar with profile avatar circle and notifications button.
- Build premium weather greeting section.
- Upgrade security status card to show active counts and status pills ("Front Door Locked", "Cameras On").
- Redesign Quick Scenes to display squircle cards with custom micro-animations.
- Redesign Lumina AI card with dark background and purple glowing accents.
- Rebuild Favorite Devices grid to show specialized cards depending on type:
  - Climate controls: with cooling state, target temperature, and minus/plus buttons.
  - Smart lock: with locking status indicators and custom tap-to-unlock bottom buttons.
  - Music speaker: with sound waves animations and track progress.
  - Lights: with brightness labels and bottom progress bar sliders.
- Redesign recent activity tiles with vertical connector line.

#### [MODIFY] [rooms_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/rooms/presentation/rooms_screen.dart)
- Render rooms as a list of high-fidelity background image cards (Living Room, Bedroom, Kitchen, Garage, Bathroom, Garden).
- Overlay cards with a transparent black gradient and a sliding glass footer containing active/total status counts and a chevron navigation arrow.

#### [MODIFY] [ai_assistant_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/ai_assistant/presentation/ai_assistant_screen.dart)
- Build a full chat console with user message bubbles, robot avatar messages, suggested action chips, and a voice mic trigger with animation.

#### [MODIFY] [automation_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/automation/presentation/automation_screen.dart)
- Render visual IF-THEN connector diagram.
- Build active rules lists (Sunset Routine, Arrive Home) with detail highlights.
- Add Quick Scenes horizontal image cards (Movie Night, Good Night, Focus Mode).

#### [MODIFY] [energy_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/energy/presentation/energy_screen.dart)
- Implement Daily/Weekly/Monthly segment tabs.
- Build a custom line graph painter to display consumption over time, complete with area shading gradients and a peak badge.
- Build progress-bar list representing category distribution (AC, fridge, lights, others).
- Add bento-card grids for Total Consumption, Cost, and Carbon footprint.

#### [MODIFY] [camera_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/camera/presentation/camera_screen.dart)
- Build Front Door live view feed with badge overlay and center player overlay controls.
- Add 4-column quick actions panel (Motion, Record, Talk, Snapshot).
- Build active feeds grid (Patio, Driveway, Kitchen) with small live badges.
- Build snap-to timeline horizontal lists for history captures.

#### [MODIFY] [profile_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/profile/presentation/profile_screen.dart)
- Redesign profile header to show avatar with "PRO" badge, "Home Member" label, and overlapping family member icons.
- Add language switcher and theme mode toggle switch.

#### [MODIFY] [settings_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/settings/presentation/settings_screen.dart)
- Re-architect settings items into styled groups (Appearance, Notifications, Connectivity, Security, System) inside rounded containers.

#### [MODIFY] [notifications_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/notifications/presentation/notifications_screen.dart)
- Redesign notifications list to separate swipable Security Alerts (Patio motion, Door left unlocked), low-battery/offline alerts, and completed automations logs.

#### [MODIFY] [device_detail_screen.dart](file:///d:/FPT/Ki_9/SEP490/Project/App/syna/lib/features/devices/presentation/device_detail_screen.dart)
- Redesign temperature control to use an interactive dial with circular progress track, interactive buttons (+/-), and indoor reference metrics.
- Style fan speed controls as clean horizontal segments.
- Add stats history graph and quick automation link triggers.

## Verification Plan

### Automated Tests
- Run `flutter test` to ensure there are no breaking changes or build issues.

### Manual Verification
- Launch the application on simulated/physical phone and tablet platforms.
- Verify that spacing, glassmorphic themes, responsive sizes, and interactive widgets render identically to the reference HTML designs.
