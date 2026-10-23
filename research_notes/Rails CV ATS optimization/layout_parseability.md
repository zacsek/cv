# ATS Parseability of the AltaCV and DeveloperCV Layouts (EN + DE)

Method and evidence base (applies to all sections below):
- All four PDFs were built from the committed sources on 2026-10-23. `make en` / `make de` **currently fail**. The `zacsek/miktex` image aborts with ``! LaTeX Error: File `l3backend-pdftex.def' not found.`` and `miktex packages install l3backend` inside the container fails with "Unknown archive file size". The local TeX Live has no `pdflatex.fmt`. Workaround that needed no repo changes: download the current `l3kernel.tds.zip` from CTAN (in 2026 it ships the `l3backend-*.def` files) into the scratchpad and run the same image with `--entrypoint sh` and `pdflatex -include-directory=<scratch>/inc`, two passes each, into `output/`. The resulting PDFs were copied to `Zoltan_Szocs_CV.{altacv,developercv}.{en,de}.pdf`.
- Extractors used: poppler `pdftotext` (default, `-layout`, `-raw`), `pdffonts`, `pdfinfo`. In a scratch venv: pdfminer.six 20260107, pypdf 6.21.2 (plain and `extraction_mode="layout"`), PyMuPDF 2.0 (`get_text()`, `get_links()`, `metadata`, image count). These are the same three families of extraction approaches (geometry-sorted, reading-order analysis, content-stream order) used by the 2026 Enhancv extraction study ([Enhancv](https://enhancv.com/blog/two-column-resume-ats-test/)).
- Candidate fixes were then tested on a **scratch copy** of the repo, with no tracked files changed. Results are under each question.
- Side note: during this session another process changed `content/en/experience/2004_neogen.tex` in the working tree (mtime 00:22, after my 00:21 build). It removed a third Neogen bullet ("Developed features for recognizing, validating, and importing e-invoices in SMART Connect."), which in HEAD duplicates a Wolters Kluwer bullet. The EN extracts quoted below come from HEAD and therefore still contain it.

## Q1. Reading order: do the columns, sidebar and date margins interleave? Are dates attached to roles? Are section headings recognizable?

### Takeaway
AltaCV (25/75 `paracol` sidebar) keeps a correct order in content-stream extractors. Geometry or reading-order extractors interleave the sidebar (skills tags, languages) with "About Me", but the dates stay attached to each role because AltaCV prints them on a line under the title. DeveloperCV is mostly single-column, but its date margin (a separate 17% `minipage` beside each entry) gets **detached from roles** in pdfminer.six: all the page-1 dates come out as one block before the first job. Its side-by-side Skills/Languages minipages interleave in `pdftotext` default mode. Headings are plain text in both, but some are non-standard ("TECH STACK", "ABOUT ME", "SUMMARY", DE "STUDIUM").

### Cited Findings
- **AltaCV, `pdftotext -raw` (content-stream order), EN.** Correct order. paracol writes the left column first, then the right:
  ```
  TECH STACK
  Rails Ruby Kotlin
  Java Ansible
  ...
  LANGUAGES
  Hungarian: Native
  ...
  ABOUT ME
  Senior Software Engineer with over 20 years ...
  EXPERIENCE
  Sr. Software Engineer | Wolters Kluwer
  z 2021 – current { Java, Kotlin, PostgreSQL * Ludwigsburg, Germany
  ```
  (Empirical: `pdftotext -raw output/altacv_en.pdf`.)
- **AltaCV, `pdftotext` default (reading-order analysis), EN.** The sidebar interleaves with the About Me paragraph:
  ```
  TECH STACK
  ABOUT ME
  Rails
  Ruby
  Java
  Ansible
  Senior Software Engineer with over 20 years of experience building eﬃcient
  ...
  knowledge to a focused engineering team.
  PostgreSQL
  Linux
  Kotlin
  ```
  pdfminer.six does the same with the headings ("TECH STACK" / "ABOUT ME" back to back, then the skills, then LANGUAGES, then the About text). (Empirical.)
- **AltaCV, `pdftotext -layout` / pypdf layout.** Both columns print side by side on the same text lines ("TECH STACK                  ABOUT ME" / " Rails   Ruby      Kotlin   Senior Software Engineer with..."). A line-oriented parser would merge sidebar words into summary sentences. (Empirical.)
- **AltaCV dates.** Every extractor tested keeps `<icon> 2021 – current` directly under "Sr. Software Engineer | Wolters Kluwer", so the date is not detached. Title and company are joined with " | ", a separator parsers can split on. (Empirical.)
- **DeveloperCV, pdfminer.six (EN and DE).** The date column is detached:
  ```
  EXPERIENCE
  2021 – current
  2015 – 2020
  2014 – 2015
  2011 – 2014
  Sr. Software Engineer
  Wolters Kluwer – Ludwigsburg, Germany
  • Designed and implemented ...
  ```
  pdfminer groups the narrow left minipage text into one text box per page, so four date ranges precede the first role. (Empirical: `extract_text(output/developercv_en.pdf)`.)
- **DeveloperCV, `pdftotext -raw` and default.** The date stays on the role's line, but role and company merge with no delimiter: `2021 – current Sr. Software Engineer Wolters Kluwer – Ludwigsburg, Germany`. One long entry wraps: `2011 – 2014 Sr. Software Engineer, Android LogMeIn (Developer of Remote Access and Support Solutions) – Budapest,` / `Hungary`. (Empirical.)
- **DeveloperCV, `pdftotext` default: Skills and Languages interleave.**
  ```
  LANGUAGES
  Hungarian: Native
  SKILLS
  TECH STACK:
  Rails
  Ruby
  Linux
  Docker
  Kotlin
  ```
  The skill pills also lose their order (Rails, Ruby, Linux, Docker, Kotlin, Git, Java ...). (Empirical.)
- **DeveloperCV tech line is placed after the bullets** and starts with a junk glyph: `r Java, Kotlin, PostgreSQL` (the FontAwesome 4 wrench). Without a label it reads as a stray bullet line and is not identifiable as "technologies". (Empirical.)
- **Headings extracted.**
  - AltaCV EN: "TECH STACK", "LANGUAGES", "ABOUT ME", "EXPERIENCE", "EDUCATION".
  - AltaCV DE: "TECH STACK" (English heading in the German CV), "SPRACHEN", "ÜBER MICH", "BERUFSERFAHRUNG", "STUDIUM".
  - DeveloperCV EN: "SUMMARY", "SKILLS" + "TECH STACK:", "LANGUAGES", "EXPERIENCE", "EDUCATION".
  - DeveloperCV DE: "ÜBER MICH", "FÄHIGKEITEN", "SPRACHEN", "BERUFSERFAHRUNG", "AUSBILDUNG".
  - AltaCV has **no "Skills" heading**; the only skills header is the group name "TECH STACK". (Empirical.)
- **Greenhouse's own support article** lists "Multi-column layouts", "Unclear sections or inconsistent formatting across sections", "Complex layouts with tables, headers, and footers" and "Incomplete job titles, such as abbreviations" as causes of an unsuccessful parse — [Greenhouse Support: Unsuccessful resume parse](https://support.greenhouse.io/hc/en-us/articles/200989175-Unsuccessful-resume-parse)
- **Textkernel on column CVs.** It estimates "at least 15%" of CVs use columns. Rendering text in plain top-down, left-to-right order "mixes content from different columns". Its older rule-based column detection rendered 62% of CVs well; a newer gradient-boosting model reached 90%, and contact-info fill rates rose 4–10% absolute — [Textkernel blog: Improving extraction from column resumes](https://textkernel.com/learn-support/blog/improving-extraction-from-column-resumes)

### Inferences
- For AltaCV, the outcome depends on the parser's extraction strategy. A content-stream parser gets a clean order. A geometry or reading-order parser (pdfminer-style, or a poppler default-style) puts the sidebar keywords inside the summary. The keywords themselves survive.
- DeveloperCV's date margin is the riskiest single construct across both layouts. A parser that groups text blocks the way pdfminer does would assign dates to the wrong jobs or to none. Putting the date on the same line as the title, or right after it in the same text flow, removes the risk.
- Using "Skills" / "Kenntnisse" (or "Fähigkeiten") as a real section heading helps section classifiers. Today AltaCV only says "TECH STACK", and the DE AltaCV mixes languages.

### Gaps
- I could not run the CVs through a commercial parser (Textkernel Tx, Daxtra, Sovren/Textkernel, Workday, Greenhouse). The results above are from open-source extractors that stand in for those engines. Commercial engines add layout models on top (see Textkernel above), so their output may be better.
- `pdftotext -raw` produced one anomaly that I could not explain. On the **first line of the DeveloperCV EN summary only**, it drops word spaces: `SeniorSoftwareEngineer with over 20years of experiencebuildingefficientandscalablesolutions. WhileproficientinKotlin,`. pdftotext default, pdfminer, pypdf and PyMuPDF all extract this line correctly. Turning on `\pdfinterwordspaceon` (real space glyphs) did not fix this line in `-raw` mode. The cause was not determined.

## Q2. Garbled characters: ligatures, Hungarian ő, German umlauts, FontAwesome icons, bullets, dashes; font/Unicode configuration

### Takeaway
Accented characters are clean in both layouts: Ő (U+0150, double acute), Á, ä/ö/ü/Ä/Ö/Ü/ß all extract correctly, all fonts are embedded Type 1 with ToUnicode maps, and bullets and dashes come out as U+2022 / U+2013. There are two real problems:
1. **AltaCV outputs Unicode ligature code points** (ﬁ U+FB01, ﬂ U+FB02, ﬀ U+FB00, ﬃ U+FB03) inside keywords such as "eﬃcient", "proﬁcient" and "workﬂows".
2. **FontAwesome icons leak as junk.** AltaCV's contact line comes out as literal `\faAt :`, `\faPhone :` and so on, and its event icons as `z` `{` `*`. DeveloperCV's icons come out as `Ó`, `½`, `R`, U+0087, `°` and `r`.

### Cited Findings
- **`pdffonts`, AltaCV.** RobotoSlab-Bold, Lato-{Regular,Bold,Italic}, FontAwesome5Free-Solid and FontAwesome5Brands-Regular. All are Type 1, embedded, subset, `uni yes`. (Empirical.)
- **`pdffonts`, DeveloperCV.** Raleway-{Regular,Bold,Italic} and FontAwesome (v4). All are Type 1, embedded, subset, `uni yes`. (Empirical.)
- **AltaCV Unicode configuration.** In the pdfTeX branch, `altacv.cls` loads `cmap`, `inputenc[utf8]`, `fontenc[T1]` and `\input{glyphtounicode}`. It then explicitly maps `f_f→FB00, f_f_i→FB03, f_f_l→FB04, f_i→FB01` and sets `\pdfgentounicode=1` (lines 71–79). The comment says the intent was for ligatures to "copy-paste as normal characters", but FB0x **are** the ligature code points. The class also loads `pdfx[a-1b]`, which re-inputs `glyphtounicode.tex` (seen in the log), so later overrides in the class are reset. (Empirical: altacv.cls, `output/altacv_en.log`.)
- **DeveloperCV Unicode configuration.** `developercv.cls` loads `inputenc[utf8]`, `fontenc[T1]` and `raleway`. It has no `cmap`, no `glyphtounicode` and no `\pdfgentounicode`. Its ligatures still extract as plain "fi"/"fl" ("efficient", "workflows"), because the Raleway Type 1 fonts carry a usable ToUnicode. (Empirical.)
- **Non-ASCII character inventory (PyMuPDF), AltaCV EN.** U+00C1 Á ×1, U+0150 Ő ×1, U+2013 – ×8, U+2019 ’ ×6, U+2022 • ×21, **U+FB00 ×1, U+FB01 ×5, U+FB02 ×2, U+FB03 ×3**. AltaCV DE additionally has ä/ö/ü/Ä/Ö/Ü/ß, all correct, plus FB00 ×3, FB01 ×3, FB02 ×1 and FB03 ×2 (e.g. "oﬀener", "eﬃzienter", "Veriﬁzierungstools"). (Empirical.)
- **Non-ASCII character inventory, DeveloperCV EN.** Á, Ő, –, ’, • are all correct, and there are **no ligature code points**. Junk icon characters remain: U+00D3 "Ó" (phone), U+00BD "½" (map marker), U+0087 (control character, GitHub), U+00B0 "°" (LinkedIn). pdfminer shows `(cid:211)` and `(cid:135)`; pypdf shows `/ne` and `/gtb`. (Empirical.)
- **AltaCV contact line in pdftotext / PyMuPDF:** `\faAt : zacsek@gmail.com \faPhone : +49-157-58094107 \faMapMarker : Esslingen am Neckar, Germany` / `\faLinkedin : zoltan-szocs \faGithub : zacsek`.
  - Cause: `\printinfo` wraps each field in `\BeginAccSupp{method=escape,ActualText={#1:~#2}}`, and `#1` is the unexpanded icon macro, so the macro *name* becomes the ActualText (altacv.cls line 139).
  - PyMuPDF even splits it: `\` / `faAt : ` / `zacsek@gmail.com`, and `\ faMapMark er : Esslingen...`.
  - pdfminer ignores ActualText and outputs the glyphs instead: `@ zacsek@gmail.com`, `(cid:239) zoltan-szocs`, `§ zacsek`, `(cid:131) +49-...`, `* Esslingen ...`. (Empirical.)
- **AltaCV event-line icons.** `\faCalendar`, `\faTools` and `\faMapMarker` (altacv.cls lines 294–296) extract as `z`, `{` and `*`: `z 2021 – current { Java, Kotlin, PostgreSQL * Ludwigsburg, Germany`. (Empirical.)
- **Line-end hyphens.** Only real compound hyphens break across lines (e.g. "Ruby-" / "Ökosystem", "Zahlungsavis-" / "Dokumenten", "proof-of-" / "concept"). No automatic hyphenation splits of ordinary words were found, because `ragged2e` / ragged layout keeps lines unhyphenated. (Empirical.)
- **pdfTeX ligature fix in the literature.** The classic pdfLaTeX fix maps ligature glyphs to their component letters with `\pdfglyphtounicode` (e.g. fi → `0066 0069`), or disables ligatures with microtype. `\pdfinterwordspaceon` was added to pdfTeX to emit real space characters for copy and paste — [pdfTeX mailing list / latex.org threads summarized via search](https://latex.org/forum/viewtopic.php?p=3653); [ntg-pdftex list](https://mailman.ntg.nl/archives/list/ntg-pdftex@ntg.nl/thread/YEUCQORJVYFSJJEBX6FGTM2OFA4D4S74) (community sources, not official docs).
- **Missing or broken ToUnicode maps** are the usual cause of "garbled characters and symbols" in PDF text extraction. Pipelines fall back to OCR when they detect it — [Docparser help](https://help.docparser.com/hc/en-us/articles/16254860582676-What-to-do-when-a-PDF-document-is-converted-to-garbled-characters-and-symbols)

**Scratch-copy fix tests:**
- **Ligature remap.** Remapping the ligatures to `0066 0069` etc. inside `altacv.cls` **did not work**: the FB0x code points remained, because `pdfx` re-inputs `glyphtounicode.tex`. Adding `\usepackage{microtype}\DisableLigatures[f]{encoding=*,family=*}` to `layouts/altacv/main_en.tex` **removed every ligature code point**. The text then read "efficient", "proficient". (Empirical.)
- **AltaCV contact line.** Changing the `\printinfo` ActualText to `{#2}` produced `zacsek@gmail.com +49-157-58094107 Esslingen am Neckar, Germany` / `zoltan-szocs zacsek` in pdftotext. Wrapping the event icons as `\BeginAccSupp{ActualText={}}\faCalendar\EndAccSupp{}` and `ActualText={Tech: }` for the tools icon produced `2021 – current Tech: Java, Kotlin, PostgreSQL Ludwigsburg, Germany`. **pdfminer.six ignores ActualText**, though, and still emits `@`, `(cid:239)`, `§`. (Empirical.)
- **DeveloperCV icons.** Wrapping the `\icon` glyph in `\BeginAccSupp{method=plain,ActualText={}}` removed Ó/½/R/°/U+0087 in pdftotext and PyMuPDF. pdfminer still shows `(cid:211)` and `(cid:135)`. With `ActualText={Tech: }` on the wrench, the line read `Tech: Java, Kotlin, PostgreSQL`. (Empirical.)

### Inferences
- The ligature code points matter for keyword matching. A recruiter search for "efficient" or "workflows" fails against "eﬃcient" / "workﬂows" unless the ATS applies Unicode NFKC normalization. No vendor documents whether it does (see Gaps). The fix is cheap: microtype `\DisableLigatures`, tested above. Running under LuaLaTeX/XeLaTeX with fontspec is another option.
- ActualText suppression only helps parsers that honor it (poppler- and MuPDF-based). pdfminer-based pipelines, and probably some commercial ones, still see the glyphs. The robust fix is to **not draw icon glyphs at all in an ATS variant**, and in the designed variants to put a real text label ("Email:", "Phone:", "LinkedIn:") next to or instead of the icon.
- Hungarian and German characters are fine in both layouts, so no change is needed for them.

### Gaps
- No public documentation was found on whether Workday, Greenhouse, Textkernel or Daxtra apply NFKC (ligature folding) before keyword search. The impact of U+FB01 is therefore inferred, not verified.
- No Textkernel or Daxtra documentation was found on whether they honor PDF ActualText.

## Q3. Skills (TikZ pills), contact info and hyperlinks

### Takeaway
The TikZ skill "pills" (AltaCV `\cvtag`, DeveloperCV `\cvtag` via `\foreach`) are real text in every extractor: no skill is lost. They come out one per line or in scrambled order, though, with no commas, so the list is not a sentence. Contact info is extractable in both layouts, but neither prints a recognisable **LinkedIn or GitHub URL** in the visible text. AltaCV shows only `zoltan-szocs` / `zacsek`; DeveloperCV shows `github.com/zacsek` and `/in/zoltan-szocs`. The real URLs exist only as link annotations.

### Cited Findings
- **All 12 skills extract in all layouts** (Rails, Ruby, Kotlin, Java, Ansible, PostgreSQL, MySQL, Linux, Docker, Git, RabbitMQ, Sidekiq). PyMuPDF puts each on its own line. DeveloperCV in pdftotext default gives the scrambled order "Rails, Ruby, Linux, Docker, Kotlin, Git, Java, Ansible, RabbitMQ, PostgreSQL ...". (Empirical.)
- **Hyperlink annotations (PyMuPDF `get_links`).**
  - AltaCV: `mailto:zacsek@gmail.com`, `tel:+49-157-58094107`, `https://linkedin.com/in/zoltan-szocs`, `https://github.com/zacsek`.
  - DeveloperCV: `mailto:zacsek@gmail.com`, `https://github.com/zacsek`, `https://linkedin.com/in/zoltan-szocs`. The phone is not linked. (Empirical.)
- **Visible text, AltaCV:** `\faLinkedin : zoltan-szocs` / `\faGithub : zacsek`; in pdfminer `(cid:239) zoltan-szocs` / `§ zacsek`. **Visible text, DeveloperCV:** `github.com/zacsek` and `/in/zoltan-szocs`. (Empirical.)
- **Contact block order.** The DeveloperCV header is three side-by-side minipages (name | phone/location/email | GitHub/LinkedIn), and each extractor orders it differently:
  - pdftotext default: phone, GitHub, LinkedIn, location, email.
  - pdfminer: phone, GitHub, location, email, LinkedIn.
  - In all of them the name and tagline come first, which is good. (Empirical.)
- **Greenhouse** lists "Name and contact information placed in a header, footer, or text box" and "Letters spaced apart" among causes of parse failure — [Greenhouse Support](https://support.greenhouse.io/hc/en-us/articles/200989175-Unsuccessful-resume-parse)
- **Personio** (common in DACH) uses Textkernel as a subprocessor for CV parsing. Extracted fields include name, location, phone, email, current employer/title, years of experience and "public profile" — [Personio Help Center (summary via search)](https://support.personio.de/hc/en-us/articles/360010193018)
- **Textkernel** names contact details (name, phone, address) as the fields most often lost on column CVs whose columns were not detected — [Textkernel blog](https://textkernel.com/learn-support/blog/improving-extraction-from-column-resumes)

### Inferences
- A parser's "public profile / LinkedIn" field will most likely stay empty for AltaCV, which shows only the bare handle. DeveloperCV's `/in/zoltan-szocs` is ambiguous too. Printing `linkedin.com/in/zoltan-szocs` and `github.com/zacsek` as visible text fixes this in every layout.
- For skills, a plain comma-separated line (`Skills: Ruby, Rails, Sidekiq, PostgreSQL, ...`) is strictly better for parsers than pills. In the designed layouts the pills can stay if an ATS variant exists.

### Gaps
- It is not documented whether commercial parsers read PDF link annotations (`/URI`) as a fallback for profile URLs.

## Q4. Photo, images, headers/footers, PDF metadata

### Takeaway
Both layouts embed one raster image, the portrait. Neither uses LaTeX page headers or footers: the name and contact block is in the body, which is good. All four PDFs have **empty Title, Author, Subject and Keywords** in the Info dictionary. AltaCV is PDF/A-1b via `pdfx` but has no `.xmpdata` file, so its XMP has no document title or author either.

### Cited Findings
- **Image count (PyMuPDF):** 1 per PDF in all four. The AltaCV photo is drawn with TikZ `fill overzoom image` in a circle (altacv.cls line 217); the DeveloperCV photo is a plain `\includegraphics` in a minipage. (Empirical.)
- **Headers/footers.** No `fancyhdr` or page-style header text is present. The name and contact info are the first lines of extracted text in every extractor. (Empirical.)
- **`pdfinfo` / PyMuPDF metadata, all four PDFs:** `title: '', author: '', subject: '', keywords: ''`; Creator "LaTeX with hyperref". `pdfinfo` on AltaCV reports `PDF subtype: PDF/A-1b:2005`. The indented "Title: ISO 19005 – Electronic document file format..." lines it prints are the PDF/A *standard's* description, not the document title. (Empirical.)
- **Greenhouse** lists "Graphics, photos, or word art" as a formatting cause of unsuccessful parses — [Greenhouse Support](https://support.greenhouse.io/hc/en-us/articles/200989175-Unsuccessful-resume-parse)
- **Lever** says it cannot parse text from image files and suggests a "highlight the text" check. This comes from a search summary of the Lever Help Center article "Understanding Resume Parsing"; the page itself did not render when fetched — [Lever Help Center](https://help.lever.co/hc/en-us/articles/20087345054749)

### Inferences
- The photo does not cover any text and does not affect extraction here. It is a convention question: expected or accepted in DACH, discouraged for US roles. Greenhouse's wording suggests a photo can hurt parsing; the more likely failure is a *text-as-image* layout, which these PDFs are not. An ATS variant should make the photo optional, with no photo for US/international applications.
- Empty metadata does not break parsing, but a filled-in `pdftitle` / `pdfauthor` costs nothing. The scratch test with `\hypersetup{pdftitle={\getcvname\ - CV},pdfauthor={\getcvname},pdfkeywords={...}}` in the DeveloperCV adapter produced `title: 'Zoltán Szőcs - CV', author: 'Zoltán Szőcs'`. For AltaCV/pdfx the equivalent is a `\jobname.xmpdata` file (`\Title{}`, `\Author{}`, `\Keywords{}`). The pdfx mechanism was not tested.

### Gaps
- I found no vendor evidence that any ATS uses PDF Title, Author or Keywords metadata in ranking or search.

## Q5. How major ATS parsers handle multi-column PDFs, LaTeX PDFs, icons, tables, headers/footers: evidence vs. myth

### Takeaway
The best primary evidence is Greenhouse's support article, which explicitly lists multi-column layouts, tables, headers and footers, text boxes, graphics and photos as parse-failure causes, and Textkernel's engineering blog: column layouts are hard, about 15% of CVs use them, and the older detection rendered only 62% well versus 90% for the newer model. Claims about Workday and Taleo being especially poor at columns come only from third-party blogs and vendor tests. The "75% of resumes are rejected by ATS" statistic is an unsupported myth. Nothing indicates that "LaTeX-generated" PDFs are a problem as such; the problems are specific constructs (icon fonts, ligature mappings, columns).

### Cited Findings
- **Greenhouse (primary).** Parsing fails for files larger than 2.5 MB. The formatting causes are: letters spaced apart; graphics, photos or word art; image uploads; "Complex layouts with tables, headers, and footers"; name or contact info in a header, footer or text box; "Multi-column layouts"; unclear sections; company names without Inc./LLC identifiers; abbreviated job titles — [Greenhouse Support](https://support.greenhouse.io/hc/en-us/articles/200989175-Unsuccessful-resume-parse). The CVs here are about 340–445 KB, well under 2.5 MB. (Empirical.)
- **Textkernel (primary vendor engineering blog).**
  - "at least 15%" of CVs use columns. Naive top-down rendering mixes columns.
  - The rule-based detector missed some separators. A gradient-boosting gap classifier raised correct gap decisions from 82% to 91% and well-rendered column CVs from 62% to 90% (about 700 CVs, human-judged), and lifted contact-info fill rates 4–10% absolute on 12k+ CVs.
  - The post is undated (© 2026 footer).
  
  — [Textkernel](https://textkernel.com/learn-support/blog/improving-extraction-from-column-resumes)
- **Textkernel's reach in DACH.** Personio uses Textkernel for CV parsing — [Personio Help Center](https://support.personio.de/hc/en-us/articles/360010193018). Textkernel is reported to be part of Bullhorn and integrates with SAP SuccessFactors; DaXtra is listed as a SuccessFactors resume-parsing integration on the SAP Store — [Daxtra & SAP SuccessFactors](https://info.daxtra.com/partner-sap-successfactors); [SAP partner profile](https://www.sap.com/partners/profile/daxtra-technologies-inc). (Aggregator-level evidence; no current formal partnership was confirmed.)
- **Enhancv 2026 extraction study (vendor, Aug/Sep 2026).**
  - Design: 357 runs (3 resumes × 17 templates × 7 extractor modes, including pdftotext default/-layout/-raw, pdfminer.six, PyMuPDF and pypdf).
  - Word recovery differed by ≤0.5 pp between one and two columns, and contact details were recovered in all runs.
  - Under the worst extraction method, sections stayed intact 35% of the time for two-column layouts versus 60% for one-column, a 24-point drop.
  - With LLM-based parsing (4 models, 10 resumes) the structural gap shrank to about 3 points, but employer-name recovery fell to 83%.
  - No real ATS was tested.
  
  — [Enhancv](https://enhancv.com/blog/two-column-resume-ats-test/)
- **ATS Verification (vendor).** In its six-layout test, the two-column version was the only one flagged for reading order (score 100 → 85). The vendor names Workday and Taleo as most affected — [ATS Verification](https://atsverification.com/blog/two-column-resume-ats-friendly/); [Research page](https://atsverification.com/research/). (Vendor with a commercial interest; methodology not independently verified.)
- **Workday.** Third-party guides claim Workday "struggles significantly with multi-column layouts", that right-column content can be lost, and that autofill puts experience in the wrong fields. No Workday documentation was found — [loopcv guide](https://www.loopcv.pro/de/guides/ats-resume-not-parsed/); [thebiggamehunter: Workday and PDFs](https://thebiggamehunter.us/workday-and-pdfs/)
- **Lever.** Parses name and contact fields and cannot parse image-only files — [Lever Help Center](https://help.lever.co/hc/en-us/articles/20087345054749) (from a search summary; the page did not render when fetched).
- **The "75% rejected by ATS" myth.** It traces to a 2012 sales claim by Preptel, a resume-services company that closed in 2013 and never published its method — [The Interview Guys](https://blog.theinterviewguys.com/?p=1967); it was repeated in [Fortune 2014](https://dc.fortune.com/2014/08/22/how-to-keep-your-resume-from-getting-lost-in-cyberspace). Rezi notes that an ATS mainly organizes candidates for recruiter search rather than auto-rejecting them — [Rezi](https://www.rezi.ai/posts/how-to-make-a-truly-ats-friendly-resume)

### Inferences
- Evidence-backed: multi-column layouts carry a real *reading-order and section-assignment* risk in some engines (Greenhouse's documentation, Textkernel's own 62% baseline, the open-source extractor tests above). Text *loss* from columns is rare.
- Myth or overstated: the "75%" statistic, and blanket claims that ATS "can't read" two-column CVs or LaTeX PDFs. Modern engines (Textkernel's newer model, LLM-assisted parsers) handle columns much better. Legacy engines in enterprise suites are the remaining risk, and the evidence that Workday and Taleo are worst comes from vendors, not from Workday or Oracle.
- For the DACH market, Personio → Textkernel is a concrete, documented pipeline. Textkernel's column handling is decent but not perfect, so a single-column ATS PDF is still the safer upload for Personio-based portals.

### Gaps
- I found no first-party documentation on parsing behaviour from Workday, iCIMS, Taleo (Oracle), SAP SuccessFactors' native parser, or Ashby. A search for Ashby parsing internals returned nothing authoritative.
- I found no independent (non-vendor) benchmark of commercial parsers on multi-column PDFs that is dated 2025–2026.

## Q6. Recommendations: safer layout, concrete LaTeX fixes, and a single-column "ATS" adapter

### Takeaway
Of the two existing layouts, **DeveloperCV is the safer one for ATS upload**, with caveats. It is essentially single-column, has clean ligatures and better visible URLs, and the sidebar does not interleave. Its date margin (pdfminer detachment), icon junk and unlabelled tech line need fixing. **AltaCV should be kept for human readers and email or direct sends.** The project should add a third `ats` layout through the existing adapter pattern. It needs about 100 lines of LaTeX and no content changes, because `common/cv-interface.sty` already has plain-text fallbacks for every semantic macro.

### Cited Findings
These are the empirical scratch-copy results from Q2–Q4, collected:
- `microtype` `\DisableLigatures[f]{encoding=*,family=*}` removes U+FB0x from AltaCV output; remapping with `\pdfglyphtounicode` does not, because pdfx overrides it.
- ActualText suppression (`accsupp`) removes icon junk in poppler and MuPDF but **not** in pdfminer.six.
- `\hypersetup{pdftitle,pdfauthor,pdfkeywords}` populates the DeveloperCV metadata.
- `\pdfinterwordspaceon` works: a `PdfTeX-Space` font appears in `pdffonts`. It did not change the anomalous `-raw` first line.

The `cv-interface.sty` fallbacks already render each element as plain text:
- `\cvexperience` → `\textbf{Role} -- \textit{Company} \hfill Dates`, location line, `\textbf{Tech:}` line, `itemize`.
- `\cvskillgroup` → `\textbf{Group}: comma list`.
- `\cvlanguage` → `\textbf{Lang}: Level`.
- `\cvsectiontitle` → `\section*`.

(Empirical: `common/cv-interface.sty`.)

Primary-source guidance that supports a single-column, text-only variant: Greenhouse's failure list (columns, tables, text boxes, graphics/photos, header/footer contact info) — [Greenhouse Support](https://support.greenhouse.io/hc/en-us/articles/200989175-Unsuccessful-resume-parse); Textkernel's column-detection limits — [Textkernel](https://textkernel.com/learn-support/blog/improving-extraction-from-column-resumes)

### Inferences

**A. Minimal fixes to existing layouts, ranked by impact**

1. **DeveloperCV date margin.** In `developercv-adapter.sty` `\cvexperience` / `\cveducation`, move the dates into the right-hand flow: `\textbf{Role} \hfill Dates \\ Company -- Location`. As an alternative, keep the visual margin but also emit dates inline. Of these fixes, this is the only one that removes a role↔date mis-assignment risk.
2. **Ligatures in AltaCV.** Add `\RequirePackage{microtype}` and `\DisableLigatures[f]{encoding=*,family=*}` to `altacv-adapter.sty` (or `main_*.tex`). Alternatively, in `altacv.cls` delete the four `\pdfglyphtounicode{...}{FB0x}` lines and re-assert component mappings `\AtBeginDocument`, after pdfx. Only the microtype route was tested.
3. **AltaCV contact line.** In `\printinfo` (altacv.cls l.139), set `ActualText={#2}` or a text label such as `ActualText={Email: #2}`, so the macro name `\faAt` is no longer emitted. Print the full `linkedin.com/in/zoltan-szocs` and `github.com/zacsek` as visible text: use the starred `\NewInfoField*` variant, or pass full URLs from `\renderheader`.
4. **AltaCV event icons.** Wrap `\faCalendar` and `\faMapMarker` in `\BeginAccSupp{ActualText={}}…\EndAccSupp{}`, and `\faTools` with `ActualText={Tech: }`. Tested.
5. **DeveloperCV icons.**
   - In the `\icon` macro (developercv.cls l.80), wrap the glyph in `\BeginAccSupp{method=plain,ActualText={}}`. Tested.
   - Prefix the tech line with `ActualText={Tech: }`, or simply print "Tech:" in text. Tested.
   - Print `linkedin.com/in/...` instead of `/in/...`.
   - Optionally link the phone with `tel:`.
6. **Headings.** Make the skills heading "Skills" / "Kenntnisse" (or "Fähigkeiten"). Today AltaCV only prints the group name "TECH STACK", which is also English in the DE CV. Consider "Summary" / "Profil" over "About Me" / "Über mich". "Experience" / "Berufserfahrung" and "Education" / "Ausbildung" are already standard; the AltaCV DE "Studium" is less common than "Ausbildung".
7. **Metadata.**
   - DeveloperCV: `\hypersetup{pdftitle={Zoltán Szőcs – CV (Senior Ruby on Rails Engineer)}, pdfauthor={Zoltán Szőcs}, pdfkeywords={Ruby, Rails, ...}}`.
   - AltaCV (pdfx): add `layouts/altacv/altacv_{en,de}.xmpdata`, or have the Makefile copy one per jobname into output.
8. **Spaces.** Optionally add `\pdfinterwordspaceon` (after `\input{glyphtounicode}` / `\pdfgentounicode=1`) to both classes, so real space characters exist for extractors that do not infer gaps.
9. **Build.** Fix the `zacsek/miktex` image: add `l3backend`, or update l3kernel (in 2026 the backend files ship inside l3kernel). Until then `make` cannot build any variant.

**B. Third layout: `layouts/ats/` (recommended)**

The adapter itself:
- `ats.cls` is not needed. Use `\documentclass[10pt,a4paper]{article}` with `geometry` (2 cm margins), `[T1]{fontenc}`, a text font with good ToUnicode (e.g. `lmodern`, or `lato` with `microtype` `\DisableLigatures`), `\input{glyphtounicode}\pdfgentounicode=1\pdfinterwordspaceon`, `enumitem` and `hyperref[hidelinks]` with `pdftitle` / `pdfauthor` / `pdfkeywords`. Do **not** load fontawesome, tikz, paracol, tcolorbox or pdfx.
- `layouts/ats/ats-adapter.sty` does `\RequirePackage{common/cv-interface}` and then overrides only where the fallbacks are not ideal:
  - `\renderheader`: name as `{\LARGE\bfseries \getcvname}\par`, then tagline, then **one line per contact field with text labels**: `Email: \href{mailto:..}{..} \textbar\ Phone: .. \textbar\ Location: ..` and `LinkedIn: \url{https://linkedin.com/in/\getcvlinkedin} \textbar\ GitHub: \url{https://github.com/\getcvgithub}`. Labels should be German in the DE driver, e.g. via a `\cvlabel{email}` macro or language-specific `\newcommand`s set in `main_de.tex`. Do not print the photo, or print it only when an `\ifatsphoto` switch is on, for the DACH variant.
  - `\cvexperience{#1..#6}`: `\textbf{#1}, #2 \hfill #3\par` followed by `#4\par` (location), then `itemize` (#6), then `Technologies: #5\par`. Title, company and dates sit on one line in a single text flow. Use a comma or " – " as the separator, never a separate box.
  - `\cveducation`: the same pattern.
  - `\cvskillgroup{#1}{#2}`: `\textbf{#1:} #2\par`, which keeps the comma-separated list as typed. This is already the fallback, but it currently sits under whatever heading the driver provides.
  - `\cvsection` / `\cvsect` → `\section*{#1}` with plain `\MakeUppercase` or title case. Add `\providecommand{\cvsection}[1]{\cvsectiontitle{#1}}`, because the content files and AltaCV drivers call `\cvsection` while the interface only defines `\cvsectiontitle`. Also `\providecommand{\cvtags}`/`\divider` no-ops if any content file uses them.
- `layouts/ats/main_{en,de}.tex` should be linear and single-column: header → Summary/Profil → Skills/Kenntnisse → Experience/Berufserfahrung (all 7 `\input`s) → Education/Ausbildung → Languages/Sprachen.

The build:
- Makefile targets `ats-en` / `ats-de`, with `ATS_LAYOUT := $(wildcard layouts/ats/*)`, output `Zoltan_Szocs_CV.ats.{en,de}.pdf`, and `ats` added to `all`, `en` and `de`.
- Optional CI-style check: a `make check` target running `pdftotext -raw` and grepping for `\\fa`, U+FB0x and the expected headings.

**C. Which file to upload where**
- **ATS portals:** Workday, Greenhouse, Lever, iCIMS, Taleo, SuccessFactors, Personio/Textkernel, Ashby. Upload the single-column ATS PDF, with no photo for US/international roles and an optional photo for DACH.
- **Email or direct sends to recruiters and hiring managers:** AltaCV is fine once fixes A2–A4 are applied.
- **Until the ATS layout exists:** use DeveloperCV with fixes A1, A5 and A7.

### Gaps
- The proposed ATS adapter was sketched, not built or tested.
- The fixes were validated only with open-source extractors, not with a commercial parser. A free trial of a Textkernel or Affinda-type parser demo would close this gap.
- I did not find out why `pdftotext -raw` glues words on the first DeveloperCV summary line. All other extractors are unaffected.
