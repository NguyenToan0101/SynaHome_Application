---
name: Lumina Ambient
colors:
  surface: '#faf9fe'
  surface-dim: '#dad9df'
  surface-bright: '#faf9fe'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f4f3f8'
  surface-container: '#eeedf3'
  surface-container-high: '#e9e7ed'
  surface-container-highest: '#e3e2e7'
  on-surface: '#1a1b1f'
  on-surface-variant: '#414755'
  inverse-surface: '#2f3034'
  inverse-on-surface: '#f1f0f5'
  outline: '#717786'
  outline-variant: '#c1c6d7'
  surface-tint: '#005bc1'
  primary: '#0058bc'
  on-primary: '#ffffff'
  primary-container: '#0070eb'
  on-primary-container: '#fefcff'
  inverse-primary: '#adc6ff'
  secondary: '#006e28'
  on-secondary: '#ffffff'
  secondary-container: '#6ffb85'
  on-secondary-container: '#00732a'
  tertiary: '#894d00'
  on-tertiary: '#ffffff'
  tertiary-container: '#ac6300'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d8e2ff'
  primary-fixed-dim: '#adc6ff'
  on-primary-fixed: '#001a41'
  on-primary-fixed-variant: '#004493'
  secondary-fixed: '#72fe88'
  secondary-fixed-dim: '#53e16f'
  on-secondary-fixed: '#002107'
  on-secondary-fixed-variant: '#00531c'
  tertiary-fixed: '#ffdcbf'
  tertiary-fixed-dim: '#ffb874'
  on-tertiary-fixed: '#2d1600'
  on-tertiary-fixed-variant: '#6a3b00'
  background: '#faf9fe'
  on-background: '#1a1b1f'
  surface-variant: '#e3e2e7'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 34px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: 0em
  body-lg:
    fontFamily: Inter
    fontSize: 17px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: 0em
  body-md:
    fontFamily: Inter
    fontSize: 15px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-caps:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  label-sm:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '500'
    lineHeight: 18px
    letterSpacing: 0em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  container-margin: 24px
  gutter: 16px
---

## Brand & Style

The design system is engineered for the high-end smart home market, focusing on "invisible technology"—where the interface recedes to let the physical environment take center stage. The aesthetic is a fusion of **High-End Minimalism** and **Glassmorphism**, drawing inspiration from the clarity of Apple HomeKit and the technical sophistication of Nothing OS.

The emotional response should be one of calm, control, and premium reliability. Every interaction is designed to feel deliberate and effortless. The visual language utilizes heavy whitespace, precision typography, and subtle material effects to differentiate between interactive controls and ambient information.

## Colors

This design system uses a sophisticated palette centered on deep neutrals. The light mode employs "off-white" tones to reduce eye strain, while the dark mode utilizes a true "Obsidian" black to maximize OLED efficiency and create a sense of infinite depth.

- **Primary (Action):** Apple Blue (#007AFF) for active states and primary buttons.
- **Success (Active):** Green (#34C759) specifically for "On" states, active sensors, and secure locks.
- **Warning (Alert):** Orange (#FF9500) for security bypasses, low battery, or sensor obstructions.
- **Surface Strategy:** Surfaces are layered. In light mode, surfaces use pure white against a light gray background. In dark mode, surfaces use a tiered charcoal (#1C1C1E) against a pure black background.

## Typography

Typography is systematic and utilitarian. **Inter** is used across all levels to ensure maximum legibility and a modern, technical feel.

- **Hierarchy:** Use `display-lg` for ambient information (e.g., current temperature) and `headline-lg` for room names. 
- **Letter Spacing:** Larger headings use slightly negative letter spacing for a tighter, premium look. `label-caps` uses generous tracking (5%) to improve readability in small, all-caps metadata contexts.
- **Weight:** Reserve bold weights for primary information. Body text should stick to Regular (400) weight to maintain the minimalist aesthetic.

## Layout & Spacing

The system is built on a strict **8px grid**. All margins, paddings, and component heights must be multiples of 8.

- **Grid Model:** Use a 12-column fluid grid for desktop and a 4-column fluid grid for mobile.
- **Margins:** High-end feel is achieved through generous 24px outer margins on mobile. This "breathability" prevents the dashboard from feeling cluttered.
- **Reflow:** On tablets, cards should tile into a masonry or balanced grid layout. On mobile, cards stack vertically or scroll horizontally in "Room" carousels.

## Elevation & Depth

Depth is used to communicate interactivity and importance, following two distinct logic paths based on the theme:

- **Light Mode (Soft Depth):** Uses very soft, high-diffusion shadows (0px 4px 20px rgba(0,0,0,0.05)) to lift cards off the background. Background blurs (20px-30px) are used for navigation bars to maintain context of the content underneath.
- **Dark Mode (Luminous Depth):** Instead of shadows, use subtle 1px inner borders (top/left) with 10% white opacity to catch the "light" and define edges. Active elements use a "glow" effect—a soft outer shadow using the primary or secondary color at 20% opacity.
- **Glassmorphism:** Navigation bars, overlays, and modals must use a backdrop-filter (blur: 20px) and a semi-transparent background (White 70% or Black 70%) to create a sense of premium material.

## Shapes

The shape language is defined by large, friendly radii that mirror modern hardware design.

- **Primary Cards:** Always use a 22px corner radius. This is the signature look of the system.
- **Buttons & Inputs:** Follow the `rounded-lg` (16px) or `rounded-xl` (24px) patterns to maintain consistency with the large cards.
- **Toggles:** Toggle tracks should be fully pill-shaped (radius: 100px).
- **Clipping:** Ensure all nested elements (like image headers) respect the 22px radius of the parent container.

## Components

### Cards
Cards are the primary interface unit. They should be 1:1 or 2:1 aspect ratio.
- **Status:** Use a small 8px "indicator dot" in the corner for connectivity status.
- **Interaction:** Cards should scale down slightly (0.98x) when pressed to provide tactile feedback.

### Navigation
- **Bottom Bar:** Fixed to the bottom with a 30px backdrop blur. Use thin, 2px stroke icons with a 24x24px bounding box.
- **Active State:** The active icon should be the Primary color with a subtle dot underneath.

### Controls
- **Sliders (Dimming/Volume):** Thick, 24px height tracks with a hidden thumb that only appears on touch. The track itself fills with the primary color as it increases.
- **Switches:** Apple-style toggles. Use Green (#34C759) for "On" states.

### Input Fields
- **Search & Text:** Minimalist borders (1px) with 12px padding. In dark mode, inputs should have a slightly darker fill than the card surface to create a "well" effect.

### Skeleton States
Use a slow, 2-second pulse animation with a linear gradient moving from left to right. Colors should be +/- 5% of the surface color.