# Formatting Guidelines

Rules the template must comply with, drawn directly from the primary source documents.
Use this file as the authoritative checklist when modifying the template.

---

## Sources

| Document | URL | Role |
|----------|-----|------|
| KSP Basic Layout Guidelines (v22.04.2021) | https://www.bibliothek.kit.edu/downloads/KSP/KSP-Basic-Layout-Guidelines.pdf | Primary formatting authority |
| KSP Manuscript Handbook | https://www.bibliothek.kit.edu/downloads/KSP/KSP-Manuskripthandbuch.pdf | Detailed explanations for all rules |
| KSP Toolbox (templates) | https://www.bibliothek.kit.edu/ksp-toolbox-dokumentvorlagen.php | Reference LaTeX templates |
| Promotionsordnung Maschinenbau 2017 (DE) | https://www.sle.kit.edu/downloads/AmtlicheBekanntmachungen/2017_AB_041.pdf | Doctoral regulations (legally binding) |
| Promotionsordnung Amendment 2018 (DE) | https://www.sle.kit.edu/downloads/AmtlicheBekanntmachungen/2018_AB_048.pdf | Amendment (legally binding) |
| KHYS — Publishing Your Dissertation | https://www.khys.kit.edu/english/publishing_dissertation.php | Submission process |

Rule levels follow the KSP Basic Layout Guidelines classification:
- **REQ** — Requirement (binding, red ✓ in the guidelines PDF)
- **REC** — Recommendation (green ✓)
- **NTH** — Nice to have (black ✓)

Status column:
- ✅ — template complies
- ⚠️ — partial compliance or known limitation
- N/A — not applicable (user responsibility or handled by Typst compiler)

---

## Paper Format

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| P1 | REQ | Paper format: DIN A5 (148 × 210 mm) | KSP p.6 | ✅ | `src/page-conf.typ:4-8`, `src/page-setup.typ:121` |
| P2 | REQ | All pages must be in portrait orientation | KSP p.3 | ✅ | `src/page-conf.typ:5-7` (148 mm wide × 210 mm tall — A5 is natively portrait) |

---

## Fonts

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| F1 | REQ | Computer Modern (cm, cmr, cms…) and LM fonts must **not** be used | KSP p.1 | ✅ | `src/kit-fonts.typ:4-8` (Libertinus family only) |
| F2 | REQ | All fonts must be embedded in the final PDF | KSP p.1 | ✅ | Typst embeds all fonts by default at compile time |
| F3 | REQ | Base font size: 10 pt for DIN A5 (no scaling) | KSP p.6 | ✅ | `src/kit-fonts.typ:11`, `src/page-setup.typ:146` |
| F4 | REC | Approved serif fonts (body): Libertinus Serif, Nimbus Roman, URWPalladio, Utopia Roman | KSP p.6 | ✅ | `src/kit-fonts.typ:5` |
| F5 | REC | Approved sans-serif font (headings): Nimbus Sans | KSP p.6 | ⚠️ | `src/kit-fonts.typ:7` — uses Libertinus Sans (visually comparable) |
| F6 | REC | Italics for emphasis only; not used structurally | KSP p.1 | N/A | User responsibility; template does not use italics structurally |

### Font Size Table (DIN A5, no scaling) — REQ

| Element | Size | Status | Code ref |
|---------|------|--------|----------|
| H1 / chapter | 18 pt | ✅ | `src/kit-fonts.typ:13`, `src/page-setup.typ:179` |
| H2 / section | 14 pt | ✅ | `src/kit-fonts.typ:14`, `src/page-setup.typ:194` |
| H3 / subsection | 12 pt | ✅ | `src/kit-fonts.typ:15`, `src/page-setup.typ:209` |
| H4 / subsubsection | 10 pt | ✅ | `src/kit-fonts.typ:16`, `src/page-setup.typ:224` |
| Body text | 10 pt | ✅ | `src/kit-fonts.typ:11`, `src/page-setup.typ:146` |
| Headers, footnotes, captions | 8 pt | ✅ | `src/kit-fonts.typ:22-23`, `src/page-setup.typ:24,249,267` |

---

## Margins

### Side Margin Table (DIN A5, no scaling) — REQ

| Page count | Inner (binding side) | Outer | Status | Code ref |
|-----------|---------------------|-------|--------|----------|
| up to 199 pages | 20 mm | 15–18 mm | ✅ | `src/page-conf.typ:13` (`inside: 20mm, outside: 15mm`) |
| 200–399 pages | 23 mm | 15–18 mm | ✅ | `src/page-conf.typ:14` (`inside: 23mm, outside: 15mm`) |
| 400 pages and above | 25 mm | 15 mm | ✅ | `src/page-conf.typ:15` (`inside: 25mm, outside: 15mm`) |

All measurements are from the paper edge, including above headers and below pagination.

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| M1 | REQ | Inner margin must always be wider than outer margin | KSP p.4 | ✅ | `src/page-conf.typ:12-16` (inside 20/23/25 mm > outside 15 mm for all presets) |
| M2 | REQ | No elements or text may extend into the page margins | KSP p.4 | ✅ | Enforced by Typst's standard page layout engine |

---

## Page Numbering

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| N1 | REQ | Page numbers on every page except blank pages | KSP p.4 | ✅ | `src/page-setup.typ:130-143` (footer); blank pages: `src/page-setup.typ:171`; title page: `src/title-page.typ:55` |
| N2 | REQ | Page numbers not placed in the header | KSP p.4 | ✅ | `src/page-setup.typ:130` (footer, not header) |
| N3 | REQ | Same font characteristics as body text (10 pt) | KSP p.4 | ✅ | `src/page-setup.typ:137` (`font: fonts.serif, size: font-sizes.base`) |
| N4 | REC | Place page numbers outside (right on odd, left on even pages) | KSP p.4 | ✅ | `src/page-setup.typ:138-142` |
| N5 | REC | First page with quotable content begins with Roman numeral "i" | KSP p.4 | ✅ | `src/dissertation.typ:142-143` (`setup-front-matter` + `counter(page).update(0)`) |

---

## Headers (Running Heads)

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| H1 | REQ | Header on all pages with content | KSP p.2 | ✅ | `src/page-setup.typ:23-72` (`_header`) |
| H2 | REQ | Left (even) page: chapter title | KSP p.2 | ✅ | `src/page-setup.typ:50-52` |
| H3 | REQ | Right (odd) page: section heading | KSP p.2 | ✅ | `src/page-setup.typ:53-70` |
| H4 | REQ | No header on the first page of a chapter | KSP p.2 | ✅ | `src/page-setup.typ:28-32` (suppressed when a level-1 heading is on the current page) |
| H5 | REQ | Chapters without sub-sections: chapter title on both pages | KSP p.2 | ✅ | `src/page-setup.typ:57-68` (falls back to chapter label when no sections found) |
| H6 | REQ | Headers max one line; shorten if necessary | KSP p.2 | N/A | User responsibility; template exposes the full heading text verbatim |
| H7 | REC | Separated from body text by a horizontal line of 0.3 pt | KSP p.2 | ✅ | `src/page-setup.typ:71` (`line(length: 100%, stroke: 0.3pt + kit-colors.black)`) |
| H8 | REC | Include chapter numbers | KSP p.2 | ✅ | `src/page-setup.typ:43-47` |
| H9 | REC | No bold, no italics, no uppercase letters | KSP p.2 | ✅ | `src/page-setup.typ:24` (regular weight sans-serif; no uppercase transform applied) |
| H10 | REQ | Blank pages have no header | KSP p.2 | ✅ | `src/page-setup.typ:171` (`set page(header: none, footer: none)` scoped to the pagebreak that creates blank pages) |

---

## Headings

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| G1 | REQ | Always ragged (left-aligned), never justified | KSP p.2 | ✅ | `src/page-setup.typ:176,191,206,221` (`set par(justify: false)` inside every heading block) |
| G2 | REQ | Multiple consecutive headings indented to the same vertical height | KSP p.2 | ✅ | Typst's built-in heading numbering indent handles this; `src/page-setup.typ:164-232` |
| G3 | REQ | 4th-level indent must not exceed 5 mm | KSP p.2 | ✅ | `src/page-setup.typ:218-232` (level-4 headings have no extra indent; uses only default numbering width) |
| G4 | REC | Set in bold | KSP p.2 | ✅ | `src/page-setup.typ:180,195,210,225` (`weight: "bold"` for all levels) |
| G5 | REC | No hyphenation in headings | KSP p.2 | ✅ | `src/page-setup.typ:181,196,211,226` (`hyphenate: false` for all levels) |
| G6 | REC | Second line indented to the height of the first | KSP p.2 | ✅ | Handled naturally by Typst's `block` text wrapping |
| G7 | REC | Font sizes must differ by at least 2 pt between levels | KSP p.2 | ✅ | `src/kit-fonts.typ:13-16` (18 → 14 → 12 → 10 pt; minimum gap is 2 pt) |

---

## Chapter Division

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| C1 | REQ | New chapters always begin on a right-hand (odd) page; insert blank page if necessary | KSP p.1 | ✅ | `src/page-setup.typ:172` (`pagebreak(weak: true, to: "odd")`) |
| C2 | REQ | Blank pages contain no page numbers and no headers | KSP p.1 | ✅ | `src/page-setup.typ:171` (`set page(header: none, footer: none)` applied in the same scope as the pagebreak, covering inserted blank pages) |
| C3 | REQ | Page breaks used for new chapters only, not for subsections | KSP p.1 | ✅ | Template only inserts pagebreaks in the level-1 heading show rule; `src/page-setup.typ:164-187` |

---

## Body Text

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| B1 | REQ | Body text in justification (Blocksatz) | KSP p.1 | ✅ | `src/page-setup.typ:148` (`justify: true`) |
| B2 | REQ | Body text 100 % black | KSP p.1 | ✅ | Typst default; no fill override applied to body text |
| B3 | REC | Line spacing 1.15–1.2 × (`\setstretch{1.15}` in LaTeX) | KSP p.4 | ✅ | `src/kit-fonts.typ:29` (`leading = 0.75em` ≈ 1.15×), `src/page-setup.typ:151` |
| B4 | REC | Delete all first-line indents; use paragraph spacing instead | KSP p.3 | ✅ | `src/page-setup.typ:149` (`first-line-indent: 0pt`), `src/page-conf.typ:25` (`par-spacing = 1.0em`) |
| B5 | NTH | Do not indent first line after blank lines or at top of page | KSP p.3 | ✅ | `src/page-setup.typ:149` (`first-line-indent: 0pt` applied globally) |
| B6 | REQ | Automatic hyphenation enabled | KSP p.3 | ✅ | Typst enables hyphenation by default for justified text; `src/page-setup.typ:148` |
| B7 | REQ | No individual lines at the start or end of a page (widows/orphans) | KSP p.3 | ⚠️ | Typst has no built-in widow/orphan penalty; manual `#pagebreak` in content is required as a workaround |
| B8 | REC | Consistent spacing between all elements throughout the document | KSP p.4 | ✅ | Enforced via consistent show rules and spacing constants in `src/page-setup.typ` |

---

## Footnotes

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| FN1 | REQ | Footnotes 2 pt smaller than body text (8 pt for 10 pt base) | KSP p.2 | ✅ | `src/kit-fonts.typ:23` (`footnote: 8pt`), `src/page-setup.typ:267` |
| FN2 | REQ | Numbers superscript in running text and front-aligned in footnote list | KSP p.2 | ✅ | Superscript in text: Typst default; front-aligned in list: `src/page-setup.typ:266-276` (custom grid layout) |
| FN3 | REQ | Spacing between body text and footnote separator: approx. 2 lines (LaTeX: 20 pt) | KSP p.2 | ✅ | Typst default footnote separator spacing |
| FN4 | REC | Align footnote text from second line with height of first line | KSP p.2 | ✅ | `src/page-setup.typ:266-276` (grid layout: superscript number in `auto`-width column + 0.3em gutter, body text fills remainder) |
| FN5 | REC | Do not allow footnotes to span across pages | KSP p.2 | ✅ | Typst does not split footnotes across pages by default |
| FN6 | NTH | Restart footnote numbering for each chapter | KSP p.2 | ✅ | `src/page-setup.typ:169` (`counter(footnote).update(0)` in level-1 heading show rule) |

---

## Figures and Tables

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| FT1 | REQ | Long captions (≥ 3 lines): left-justified | KSP p.3 | ✅ | `src/page-setup.typ:247-264` (height threshold: `font-sizes.small * 2.5`) |
| FT2 | REQ | Use full type-area width for layout | KSP p.3 | ✅ | Typst figures default to full container width |
| FT3 | REQ | Position table headings consistently: always above or always below | KSP p.3 | N/A | User responsibility; template does not constrain caption position |
| FT4 | REQ | Caption numbering includes chapter number (e.g. Figure 2.3) | KSP p.3 | ✅ | `src/page-setup.typ:280-283` (`numbering("1.1", ch, it)`) |
| FT5 | REC | 1-line captions: centred (exception: if line spans nearly full width, left-align) | KSP p.3 | ✅ | `src/page-setup.typ:259-263` (center for short captions, left for ≥ 3 lines) |
| FT6 | REC | Sources for captions in parentheses | KSP p.3 | N/A | User responsibility |
| FT7 | REC | Minimum image resolution: 200 dpi | KSP p.3 | N/A | Cannot be enforced at template level; user responsibility |
| FT8 | REC | Small illustrations remain centred | KSP p.3 | ✅ | Typst centers figures by default |
| FT9 | REC | Tables: cells left-justified to avoid gaps | KSP p.5 | N/A | User responsibility; template does not set default table cell alignment |
| FT10 | NTH | Tables: additional line above first and last row | KSP p.5 | N/A | User responsibility |

---

## Formulas

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| FM1 | REQ | All formulas consistently centred, or all at left margin — not mixed | KSP p.2 | ✅ | Typst centers all block equations by default; template does not override alignment |
| FM2 | REC | Formula numbers right-justified at the type-area margin | KSP p.2 | ✅ | `src/page-setup.typ:288-291` (equation numbering set; Typst places numbers right-aligned) |

---

## Enumerations (Lists)

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| E1 | REQ | Items ≥ 3 lines: justified; second line aligned to height of first | KSP p.1 | ✅ | Inherits `justify: true` from global `set par`; `src/page-setup.typ:148` |
| E2 | REC | Items 1–2 lines: left-aligned with early line breaks | KSP p.1 | N/A | User responsibility; template cannot automatically distinguish short vs. long list items |
| E3 | NTH | Consistent bullet point characters | KSP p.1 | ✅ | Typst uses consistent bullet characters by default |

---

## Table of Contents

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| T1 | REQ | All headings up to 3rd level included | KSP p.5 | ✅ | `src/outlines.typ:22` (`depth: 3`) |
| T2 | REQ | The TOC heading itself is **not** listed in the TOC | KSP p.5 | ✅ | Typst automatically excludes the outline's own title from the outline |
| T3 | REQ | Page numbers right-aligned at the right margin of the type area | KSP p.5 | ✅ | Typst default outline layout |
| T4 | REQ | All entries begin at the same vertical height | KSP p.5 | ✅ | `src/outlines.typ:23` (`indent: 1.6em`) |
| T5 | REQ | Entries wrap before running into page numbers | KSP p.5 | ✅ | Typst outline handles entry wrapping automatically |
| T6 | REC | Maximum three heading levels listed | KSP p.5 | ✅ | `src/outlines.typ:22` (`depth: 3`) |
| T7 | REC | Main chapters (level 1) in bold | KSP p.5 | ✅ | `src/outlines.typ:13-16` (`strong(it)` for level-1 entries) |
| T8 | REC | Dotted lines from entry to page number (including chapter entries) | KSP p.5 | ✅ | `src/page-setup.typ:231` (`set outline.entry(fill: repeat(".", gap: 0.4em))`) |
| T9 | REC | Set in ragged text (flutter text) | KSP p.5 | ✅ | `src/page-setup.typ:232` (`show outline: set par(justify: false)`) |
| T10 | REC | No hyphenation in TOC entries | KSP p.5 | ✅ | `src/page-setup.typ:233` (`show outline: set text(hyphenate: false)`) |
| T11 | NTH | Slightly increase space between number and text for multi-digit numbers | KSP p.5 | ⚠️ | Not explicitly handled; Typst's fixed `indent: 1.6em` may be tight for double-digit appendix numbering |

---

## Lines

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| L1 | REC | All lines (rules, borders) at least 0.3 pt (0.1 mm) in final format | KSP p.4 | ✅ | `src/page-setup.typ:71` (header rule: `stroke: 0.3pt`) |

---

## Bookmarks / Hyperlinks

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| BM1 | REQ | Comments and links set to "not printing" | KSP p.1 | ⚠️ | Typst renders links as inline colored text (not PDF annotation objects), so they always print. Use `colored-links: false` to make them visually indistinguishable from body text; `src/page-setup.typ:155-161` |
| BM2 | REC | Links and bookmarks included for the online version | KSP p.1 | ✅ | Typst automatically generates PDF outline bookmarks from all headings |

---

## Promotionsordnung Requirements (Faculty of Mechanical Engineering)

These govern submission, not formatting. The template cannot enforce them but they are
listed here for completeness.

| # | Level | Rule | Source | Status | Code ref |
|---|-------|------|--------|--------|----------|
| PR1 | REQ | Language: German or English; if foreign language, German summary must precede | Prom. §10 | N/A | Submission requirement; template supports both `lang: "de"` and `lang: "en"` |
| PR2 | REQ | Submit three firmly bound copies (no ring binding) | Prom. §10 | N/A | Physical submission requirement |
| PR3 | REQ | Submit an electronic version (PDF) | Prom. §10 | N/A | Typst produces PDF output |
| PR4 | REQ | Publish within one year after oral examination | Prom. §10 | N/A | Deadline requirement |
| PR5 | REQ | Include signed affidavit (Annex 3), criminal consequences declaration (Annex 4), good scientific practice declaration (Annex 5b) | Prom. §10 | N/A | Document content requirement; user must add these pages |
