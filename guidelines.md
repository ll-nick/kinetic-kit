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

---

## Paper Format

| # | Level | Rule | Source |
|---|-------|------|--------|
| P1 | REQ | Paper format: DIN A5 (148 × 210 mm) | KSP p.6 |
| P2 | REQ | All pages must be in portrait orientation | KSP p.3 |

---

## Fonts

| # | Level | Rule | Source |
|---|-------|------|--------|
| F1 | REQ | Computer Modern (cm, cmr, cms…) and LM fonts must **not** be used | KSP p.1 |
| F2 | REQ | All fonts must be embedded in the final PDF | KSP p.1 |
| F3 | REQ | Base font size: 10 pt for DIN A5 (no scaling) | KSP p.6 |
| F4 | REC | Approved serif fonts (body): Libertinus Serif, Nimbus Roman, URWPalladio, Utopia Roman | KSP p.6 |
| F5 | REC | Approved sans-serif font (headings): Nimbus Sans | KSP p.6 |
| F6 | REC | Italics for emphasis only; not used structurally | KSP p.1 |

### Font Size Table (DIN A5, no scaling) — REQ

| Element | Size |
|---------|------|
| H1 / chapter | 18 pt |
| H2 / section | 14 pt |
| H3 / subsection | 12 pt |
| H4 / subsubsection | 10 pt |
| Body text | 10 pt |
| Headers, footnotes, captions | 8 pt |

---

## Margins

### Side Margin Table (DIN A5, no scaling) — REQ

| Page count | Inner (binding side) | Outer |
|-----------|---------------------|-------|
| up to 199 pages | 20 mm | 15–18 mm |
| 200–399 pages | 23 mm | 15–18 mm |
| 400 pages and above | 25 mm | 15 mm |

All measurements are from the paper edge, including above headers and below pagination.

| # | Level | Rule | Source |
|---|-------|------|--------|
| M1 | REQ | Inner margin must always be wider than outer margin | KSP p.4 |
| M2 | REQ | No elements or text may extend into the page margins | KSP p.4 |

---

## Page Numbering

| # | Level | Rule | Source |
|---|-------|------|--------|
| N1 | REQ | Page numbers on every page except blank pages | KSP p.4 |
| N2 | REQ | Page numbers not placed in the header | KSP p.4 |
| N3 | REQ | Same font characteristics as body text (10 pt) | KSP p.4 |
| N4 | REC | Place page numbers outside (right on odd, left on even pages) | KSP p.4 |
| N5 | REC | First page with quotable content begins with Roman numeral "i" | KSP p.4 |

---

## Headers (Running Heads)

| # | Level | Rule | Source |
|---|-------|------|--------|
| H1 | REQ | Header on all pages with content | KSP p.2 |
| H2 | REQ | Left (even) page: chapter title | KSP p.2 |
| H3 | REQ | Right (odd) page: section heading | KSP p.2 |
| H4 | REQ | No header on the first page of a chapter | KSP p.2 |
| H5 | REQ | Chapters without sub-sections: chapter title on both pages | KSP p.2 |
| H6 | REQ | Headers max one line; shorten if necessary | KSP p.2 |
| H7 | REC | Separated from body text by a horizontal line of 0.3 pt | KSP p.2 |
| H8 | REC | Include chapter numbers | KSP p.2 |
| H9 | REC | No bold, no italics, no uppercase letters | KSP p.2 |
| H10 | REQ | Blank pages have no header | KSP p.2 |

---

## Headings

| # | Level | Rule | Source |
|---|-------|------|--------|
| G1 | REQ | Always ragged (left-aligned), never justified | KSP p.2 |
| G2 | REQ | Multiple consecutive headings indented to the same vertical height | KSP p.2 |
| G3 | REQ | 4th-level indent must not exceed 5 mm | KSP p.2 |
| G4 | REC | Set in bold | KSP p.2 |
| G5 | REC | No hyphenation in headings | KSP p.2 |
| G6 | REC | Second line indented to the height of the first | KSP p.2 |
| G7 | REC | Font sizes must differ by at least 2 pt between levels | KSP p.2 |

---

## Chapter Division

| # | Level | Rule | Source |
|---|-------|------|--------|
| C1 | REQ | New chapters always begin on a right-hand (odd) page; insert blank page if necessary | KSP p.1 |
| C2 | REQ | Blank pages contain no page numbers and no headers | KSP p.1 |
| C3 | REQ | Page breaks used for new chapters only, not for subsections | KSP p.1 |

---

## Body Text

| # | Level | Rule | Source |
|---|-------|------|--------|
| B1 | REQ | Body text in justification (Blocksatz) | KSP p.1 |
| B2 | REQ | Body text 100 % black | KSP p.1 |
| B3 | REC | Line spacing 1.15–1.2 × (`\setstretch{1.15}` in LaTeX) | KSP p.4 |
| B4 | REC | Delete all first-line indents; use paragraph spacing instead | KSP p.3 |
| B5 | NTH | Do not indent first line after blank lines or at top of page | KSP p.3 |
| B6 | REQ | Automatic hyphenation enabled | KSP p.3 |
| B7 | REQ | No individual lines at the start or end of a page (widows/orphans) | KSP p.3 |
| B8 | REC | Consistent spacing between all elements throughout the document | KSP p.4 |

---

## Footnotes

| # | Level | Rule | Source |
|---|-------|------|--------|
| FN1 | REQ | Footnotes 2 pt smaller than body text (8 pt for 10 pt base) | KSP p.2 |
| FN2 | REQ | Numbers superscript in running text and front-aligned in footnote list | KSP p.2 |
| FN3 | REQ | Spacing between body text and footnote separator: approx. 2 lines (LaTeX: 20 pt) | KSP p.2 |
| FN4 | REC | Align footnote text from second line with height of first line | KSP p.2 |
| FN5 | REC | Do not allow footnotes to span across pages | KSP p.2 |
| FN6 | NTH | Restart footnote numbering for each chapter | KSP p.2 |

---

## Figures and Tables

| # | Level | Rule | Source |
|---|-------|------|--------|
| FT1 | REQ | Long captions (≥ 3 lines): left-justified | KSP p.3 |
| FT2 | REQ | Use full type-area width for layout | KSP p.3 |
| FT3 | REQ | Position table headings consistently: always above or always below | KSP p.3 |
| FT4 | REQ | Caption numbering includes chapter number (e.g. Figure 2.3) | KSP p.3 |
| FT5 | REC | 1-line captions: centred (exception: if line spans nearly full width, left-align) | KSP p.3 |
| FT6 | REC | Sources for captions in parentheses | KSP p.3 |
| FT7 | REC | Minimum image resolution: 200 dpi | KSP p.3 |
| FT8 | REC | Small illustrations remain centred | KSP p.3 |
| FT9 | REC | Tables: cells left-justified to avoid gaps | KSP p.5 |
| FT10 | NTH | Tables: additional line above first and last row | KSP p.5 |

---

## Formulas

| # | Level | Rule | Source |
|---|-------|------|--------|
| FM1 | REQ | All formulas consistently centred, or all at left margin — not mixed | KSP p.2 |
| FM2 | REC | Formula numbers right-justified at the type-area margin | KSP p.2 |

---

## Enumerations (Lists)

| # | Level | Rule | Source |
|---|-------|------|--------|
| E1 | REQ | Items ≥ 3 lines: justified; second line aligned to height of first | KSP p.1 |
| E2 | REC | Items 1–2 lines: left-aligned with early line breaks | KSP p.1 |
| E3 | NTH | Consistent bullet point characters | KSP p.1 |

---

## Table of Contents

| # | Level | Rule | Source |
|---|-------|------|--------|
| T1 | REQ | All headings up to 3rd level included | KSP p.5 |
| T2 | REQ | The TOC heading itself is **not** listed in the TOC | KSP p.5 |
| T3 | REQ | Page numbers right-aligned at the right margin of the type area | KSP p.5 |
| T4 | REQ | All entries begin at the same vertical height | KSP p.5 |
| T5 | REQ | Entries wrap before running into page numbers | KSP p.5 |
| T6 | REC | Maximum three heading levels listed | KSP p.5 |
| T7 | REC | Main chapters (level 1) in bold | KSP p.5 |
| T8 | REC | Dotted lines from entry to page number (including chapter entries) | KSP p.5 |
| T9 | REC | Set in ragged text (flutter text) | KSP p.5 |
| T10 | REC | No hyphenation in TOC entries | KSP p.5 |
| T11 | NTH | Slightly increase space between number and text for multi-digit numbers | KSP p.5 |

---

## Lines

| # | Level | Rule | Source |
|---|-------|------|--------|
| L1 | REC | All lines (rules, borders) at least 0.3 pt (0.1 mm) in final format | KSP p.4 |

---

## Bookmarks / Hyperlinks

| # | Level | Rule | Source |
|---|-------|------|--------|
| BM1 | REQ | Comments and links set to "not printing" | KSP p.1 |
| BM2 | REC | Links and bookmarks included for the online version | KSP p.1 |

---

## Promotionsordnung Requirements (Faculty of Mechanical Engineering)

These govern submission, not formatting. The template cannot enforce them but they are
listed here for completeness.

| # | Level | Rule | Source |
|---|-------|------|--------|
| PR1 | REQ | Language: German or English; if foreign language, German summary must precede | Prom. §10 |
| PR2 | REQ | Submit three firmly bound copies (no ring binding) | Prom. §10 |
| PR3 | REQ | Submit an electronic version (PDF) | Prom. §10 |
| PR4 | REQ | Publish within one year after oral examination | Prom. §10 |
| PR5 | REQ | Include signed affidavit (Annex 3), criminal consequences declaration (Annex 4), good scientific practice declaration (Annex 5b) | Prom. §10 |
