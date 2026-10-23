# Make your Rails experience findable, recent and parseable

As written, the CV gives a screener a Java/Kotlin engineer whose Ruby work ended in 2020. Neither language version contains the phrase "Ruby on Rails". "Rails" appears only in a parenthesis in the summary and in the skills list, and it is in no dated role. A parser that derives skill years from job date ranges will therefore compute **about zero years of Rails**. Most senior Rails postings ask for "5+ years". The fix has three parts, and none of them requires inflating anything. **First, make the 2015–2020 Ruby work explicit and dated.** If you confirm that Rails was used at Daimler/KPIT, that role alone supports the "5 years" figure. **Second, close the six-year recency gap with a dated Rails 8 project.** Hotwire, PostgreSQL, background jobs, an LLM feature, RSpec, CI and a Docker/Kamal deploy are what 2026 postings ask for. **Third, translate the Wolters Kluwer work (SaaS, REST integrations, e-invoicing, payment workflows, PostgreSQL migrations) into the vocabulary Rails postings use**, without attaching Rails to it. The layout matters less than the content, but it has real defects. AltaCV writes ligature code points ("eﬃcient") and leaks icon-macro names (`\faAt :`) into extracted text. DeveloperCV's date margin can come loose from its roles. Neither prints a full LinkedIn URL. The build is also currently broken. A third single-column "ATS" layout, which the existing adapter pattern already supports, fixes all of this without touching content. Most automated rejection happens on application-form knockout questions, not CV text, so stating work authorization, location and German level accurately matters as much as any keyword. Hidden text and keyword stuffing are detected and penalized. Do not use them.

## Screeners check each requirement and sort; they rarely auto-reject on CV text

The current tools explain why "keyword-optimize everything" is the wrong mental model. Greenhouse says it "never uses AI to rate candidates or auto-reject applications". Its auto-reject rules act on answers to application questions, not on the resume ([Greenhouse](https://my.greenhouse.com/blogs/how-does-greenhouse-use-ai-heres-everything-candidates-need-to-know); [Jobscan](https://www.jobscan.co/blog/greenhouse-ats-what-job-seekers-need-to-know/)). Ashby has an LLM return **"Meets / Does not meet" for each recruiter-defined criterion** ([Ashby docs](https://docs.ashbyhq.com/ai-assisted-application-review)). Workday's HiredScore does grade every applicant A–D. Since **August 2026** that grading is done by an LLM that checks each "screenable qualification" against the *parsed* resume sections (experience, education, skills, languages, summary). Meeting all basic qualifications puts a candidate in the A/B band ([Workday release note](https://doc.workday.com/hiredscore/en-us/workday-hiredscore/hiredscore-release-notes/2026/august/wednesday--5th-august.html)). In the DACH market, Personio sends CVs through Textkernel for parsing ([Personio](https://support.personio.de/hc/en-us/articles/360010193018)). Textkernel normalizes skills against **13,000+ skills and 250,000+ synonyms** ([Textkernel](https://developers.textkernel.com/SkillsIntelligence/master/skills/v3)) and computes total experience from job date ranges ([Textkernel data model](https://developer.textkernel.com/Parser/master/data_model)).

Two practical rules follow. Each likely requirement ("Ruby on Rails", "PostgreSQL", "5+ years", "background jobs", "REST APIs") should appear **inside a dated role or project**, not only in a skills list, so that both a parser and an LLM grader can verify it. And parse quality still matters even with LLM grading, because the LLM reads the parser's output. The real danger is not rejection but sorting. Recruiters review in batches and stop once they have enough candidates ([Built In](https://builtin.com/articles/hidden-ai-prompts-in-resume)), so a badly matched or badly parsed CV ends up in a pile nobody opens.

Three popular claims are myths or exaggerations. The "75% of resumes are never seen by a human" figure comes from a 2012 sales pitch by Preptel, a resume-optimization vendor that closed in 2013 and never published a methodology ([The Interview Guys](https://blog.theinterviewguys.com/?p=1967)). "ATS can't read PDFs or LaTeX" is outdated for text PDFs. In a 2026 extraction study, word recovery differed by **at most 0.5 percentage points** between one- and two-column layouts. Section integrity did suffer: under the worst extractor it fell from 60% to 35% ([Enhancv](https://enhancv.com/blog/two-column-resume-ats-test/)). So columns scramble structure but rarely lose words. The third myth is that more keyword repetition helps. A 2026 Illinois study found that its screening model **significantly lowered scores for keyword stuffing** ([Gies](https://giesbusiness.illinois.edu/news/2026/06/29/msba-research-examines-bias-in-ai-resume-screening)). An audit found that ChatGPT flagged a stuffed resume as incoherent, and that the models fooled by stuffing were the same ones that failed role-mismatch tests ([arXiv 2507.11548](https://arxiv.org/pdf/2507.11548)).

**Do not use white text or prompt injection under any circumstances.** Greenhouse found white-text messages in about **1% of ~300M resumes** in H1 2025, and ManpowerGroup finds hidden text in about **10%** of what it scans ([Boston Globe](https://www.bostonglobe.com/2025/10/07/business/ai-resumes-jobs-recruiters-applications)). One CEO found 1,500 hidden characters and **banned the applicant from reapplying**, and Greenhouse now markets fraud and spam detection ([Built In](https://builtin.com/articles/hidden-ai-prompts-in-resume); [Greenhouse](https://www.greenhouse.com/newsroom/greenhouse-launches-new-tools-to-tame-chaotic-hiring-funnels)). The same applies to a `pdfkeywords` field or an invisible LaTeX `\phantom` block stuffed with terms you cannot defend in an interview. Aim for about 4–6 natural occurrences of "Ruby on Rails" across the headline, summary, skills, the Daimler role and the projects section, each with context.

## Ranked changes: quick wins first

The table orders the work by payoff per hour. "Quick" means under an hour of editing in `content/` or a layout adapter.

| # | Change | Effort | Files | Why it matters |
|---|---|---|---|---|
| 1 | Make Ruby/Rails explicit in the Daimler/KPIT role (title, tech line, bullets), **once you confirm Rails was used** | Quick | `content/{en,de}/experience/2015_daimler_kpit.tex` | Turns ~0 computed Rails years into ~5, matching the most common "5+ years" requirement |
| 2 | Rewrite the headline and summary to position an honest return to Rails | Quick | `personal_info.tex`, `about_me.tex` | Title is the primary search keyword; summary is where the LLM grader looks for fit |
| 3 | Month/year dates everywhere; explain the 2020–2021 gap | Quick | all `experience/*.tex`, `education.tex` | Year-only dates break tenure calculation and look like hidden gaps in DACH |
| 4 | Regroup the skills into labelled groups with dual forms ("Ruby on Rails (Rails)") | Quick | `skills.tex` | Section detection, synonym coverage, testing/API/CI keywords that are missing today |
| 5 | Reframe Wolters Kluwer bullets in Rails-posting vocabulary, with metrics | Quick once you have the numbers | `2021_wolters_kluwer.tex` | The current role is read first; today all four bullets are duty statements |
| 6 | Clean company fields, write "Senior" in full, standardize headings, show full LinkedIn/GitHub URLs | Quick | `personal_info.tex`, experience files, layout drivers | Removes employer-name and profile-field parse errors |
| 7 | Fix AltaCV ligatures and icon leakage; fix DeveloperCV date margin and icons | Quick to medium | `altacv-adapter.sty`/`altacv.cls`, `developercv-adapter.sty`/`developercv.cls` | Makes "efficient"/"workflows" searchable; dates stay attached to roles |
| 8 | Fix the MiKTeX Docker build | Medium | `miktex-docker/` image | Nothing else can ship until `make` works |
| 9 | Build and ship a Rails 8 project, then add a Projects section | Large (weeks) | new `content/{en,de}/projects.tex` | The only truthful way to show *current* Rails skill |
| 10 | Add a single-column `layouts/ats/` variant and condense 2004–2015 roles | Medium | new layout, Makefile, `main_*.tex` | Safest upload for Workday/Personio/Greenhouse; frees space for recent work |

The copy-paste error, in which a Wolters Kluwer SMART Connect e-invoice bullet sat inside the 2004–2006 EN Neogen entry, **is already fixed** in the working tree (`content/en/experience/2004_neogen.tex`). Commit it before the next build.

## The CV computes to zero years of Rails today

The content audit shows how the CV reads to a machine. The tagline is `Sr. Software Engineer`. The summary names Kotlin, Java and C++ before mentioning "Rails" in a parenthesis. `skills.tex` is one flat group labelled `TECH STACK` that says "Rails" but never "Ruby on Rails". The only Ruby-centric job, Daimler/KPIT 2015–2020, has the tech line "Ruby, PostgreSQL, Sidekiq" and one bullet that mentions "JRuby / Sidekiq". Postings mix "Ruby on Rails", "Rails", "RoR" and "Ruby/Rails" ([devjobsscanner](https://www.devjobsscanner.com/ruby-jobs-in-berlin/); [Himalayas](https://himalayas.app/jobs/ruby-on-rails)). Exact-match tools such as Jobscan rank hard skills first and job title third ([Jobscan](https://www.jobscan.co/blog/ats-resume/)), so the missing exact phrase costs you matches.

### Headline and summary: name the target and the timeline

Product companies title these roles **"Senior Software Engineer – Ruby on Rails"** or "Senior Backend / Full-Stack Engineer (Ruby on Rails)". A plain "Ruby on Rails Developer" title is more typical of agencies and offshore shops ([devjobsscanner Germany](https://www.devjobsscanner.com/ruby-jobs-in-germany/); [Arc.dev](https://arc.dev/remote-jobs/ruby-on-rails)). A headline is a statement of the role you are targeting, and the summary below it gives the dates, so this stays honest:

```latex
% content/en/personal_info.tex
% before
\cvtagline{Sr. Software Engineer}
% after (Rails at Daimler confirmed)
\cvtagline{Senior Backend Engineer -- Ruby on Rails, Kotlin/Java}
% after (Rails NOT confirmed: lean on Ruby + projects)
\cvtagline{Senior Backend Engineer -- Ruby, Kotlin/Java}
```

The summary should say the return out loud rather than hope nobody notices. Before:

> Senior Software Engineer with over 20 years of experience building efficient and scalable solutions. While proficient in Kotlin, Java, and C++, my core expertise and passion lie in the Ruby ecosystem (Rails, Sidekiq). I excel at architecting complex systems and am looking to bring this depth of Ruby knowledge to a focused engineering team.

After (EN, about 70 words; bracketed parts depend on your confirmations):

> Senior backend engineer with 20+ years in software, including five years as Tech Lead on Ruby [on Rails] systems for Daimler Trucks (2015–2020): JRuby/Sidekiq/PostgreSQL pipelines processing 500+ GB/day and a verification platform used on ~5M vehicles, with a 12-engineer team. Since 2021, building Kotlin/Java accounting SaaS at Wolters Kluwer (e-invoicing, payment workflows, REST integrations). Returning to Ruby on Rails, with recent Rails 8/Hotwire work at github.com/zacsek. Remote (CET) or Stuttgart region.

After (DE):

> Senior Backend Engineer mit über 20 Jahren Berufserfahrung, davon fünf Jahre als Tech Lead für Ruby[-on-Rails]-Systeme bei Daimler Trucks (2015–2020): JRuby/Sidekiq/PostgreSQL-Pipelines mit 500+ GB/Tag, Verifikationsplattform für ca. 5 Mio. Fahrzeuge, Führung eines 12-köpfigen Teams. Seit 2021 Kotlin/Java im Buchhaltungs-SaaS bei Wolters Kluwer (E-Rechnung, Zahlungsworkflows, REST-Integrationen). Rückkehr zu Ruby on Rails; aktuelle Rails-8/Hotwire-Projekte auf github.com/zacsek. Remote (MEZ) oder Raum Stuttgart.

The phrase "recent Rails 8/Hotwire work" may appear only once that project exists (see the next section). Until then, end the summary with "Seeking a senior Ruby on Rails / backend role".

### The Daimler/KPIT entry is the Rails showcase, so expand it to 4–5 bullets

The current company field "Daimler extern / KPIT" mixes German jargon into the EN CV and breaks employer extraction. Greenhouse lists abbreviated titles and unclear company names among its parse-failure causes ([Greenhouse Support](https://support.greenhouse.io/hc/en-us/articles/200989175-Unsuccessful-resume-parse)). Proposed rewrite, with placeholders in `[ ]`:

```latex
% content/en/experience/2015_daimler_kpit.tex
\cvexperience
  {Tech Lead / Senior Ruby on Rails Engineer}   % "Ruby on Rails" only if confirmed
  {KPIT Technologies (client: Daimler Trucks)}
  {[Mon] 2015 -- [Mon] 2020}
  {Stuttgart, Germany}
  {Ruby, Ruby on Rails, JRuby, Sidekiq, PostgreSQL, [RSpec], [Docker], [CI]}
  {%
    \item Led development of a Ruby [on Rails] vehicle-verification platform for Daimler Trucks, used worldwide on $\sim$5 million Mercedes-Benz trucks.
    \item Architected a JRuby + Sidekiq background-processing pipeline on PostgreSQL ingesting 500+ GB of structured data per day; [improved throughput by X$\times$ / cut job latency from A to B].
    \item Tech-led a 12-engineer offshore team (India) delivering cloud-based fleet-management software for a German OEM client; owned architecture, code reviews and release planning.
    \item [If true] Introduced an RSpec test suite and CI pipeline ([X]\% coverage); upgraded Rails [X]$\to$[Y].
  }
```

Remove the filler phrase "ensuring effective international collaboration and project alignment" from the original. Make the same changes in the DE file, and replace "Technischer Leiter" with "Tech Lead": in German, "Technischer Leiter" means a technical director, which is a different job.

### Skills: labelled groups, dual forms, nothing you cannot defend

Replace the single `TECH STACK` group with groups that a section classifier and a reader both understand. Postings commonly ask for RSpec, Sidekiq, ActiveRecord, PostgreSQL, REST APIs, Git, CI/CD and monitoring, with Hotwire as a frequent extra ([Workable posting](https://jobs.workable.com/jobs/9216716b-8c2b-43ff-ad06-527bff9af6c6.md); [Dice posting](https://www.dice.com/job-detail/041bce0e-c4a0-4c35-be54-d8ef139b867b)). Keep items marked `?` only if you have used them:

```latex
% content/en/skills.tex
\cvskillgroup{Ruby \& Rails}{Ruby, Ruby on Rails (Rails), JRuby, Sidekiq, ActiveRecord, RSpec?, Hotwire (Turbo, Stimulus)?}
\cvskillgroup{Languages}{Kotlin, Java, C++, [Python?]}
\cvskillgroup{Data \& Messaging}{PostgreSQL (Postgres), MySQL, Redis?, RabbitMQ}
\cvskillgroup{APIs \& Architecture}{REST APIs, background jobs, system integrations, e-invoicing}
\cvskillgroup{DevOps}{Docker, Ansible, Linux, Git, CI/CD (GitHub Actions?/GitLab CI?), AWS?}
```

Rename the section heading to "Skills" (DE "Kenntnisse"). AltaCV currently prints only the group name "TECH STACK", in English even in the German CV. Keep skills as text with no rating bars; graphical levels are unreadable to an ATS ([Jobscan](https://www.jobscan.co/blog/the-resume-template-trend-you-should-avoid/)). Leave the commented-out "Learning" group out unless you have hands-on use to back it up.

### Dates, titles and company fields

All dates are year-only ("2021 -- current"). Jobscan notes that year-only dates can leave the ATS unable to compute tenure, and that some systems default the start date to January 1 ([Jobscan](https://www.jobscan.co/blog/resume-dates)). German HR guidance treats year-only dates as hiding gaps ([karrierebibel](https://karrierebibel.de/tabellarischer-lebenslauf/)). Use `Mar 2021 -- Present` in EN and `03/2021 -- heute` in DE. Explain the 2020→2021 gap in one line if it ran longer than about three months, because a 2026 study found that a screening model clearly penalized career gaps ([Gies](https://giesbusiness.illinois.edu/news/2026/06/29/msba-research-examines-bias-in-ai-resume-screening)). Write "Senior Software Engineer" in full, never "Sr.". Strip the descriptive parentheticals from company fields: `Intellio (Creator of Intelligent IP Security Cameras)` becomes `Intellio`, and the descriptor moves into the first bullet.

## Close the 2020 recency gap with shipped Rails 8 work, not with claims

Do not add Rails or Ruby to the Wolters Kluwer entry. The stack there is Java/Kotlin, and an LLM grader or an interviewer will find the mismatch. Two other honest levers address recency: a Projects section with dated recent Rails work, and WK bullets written in the vocabulary Rails postings share.

### A project designed against the 2026 keyword tally

Across about 30 detailed 2025–26 postings, the core was **Ruby on Rails, PostgreSQL (~12), React (~12), AI/LLM integration (~10, the fastest-growing item), Hotwire (~7, stronger in the EU), CI/CD (~7), testing (~7), Docker and AWS (~6 each), and Redis/Sidekiq** ([Arc.dev](https://arc.dev/remote-jobs/ruby-on-rails); [Remotive/Mitre Media](https://remotive.com/api/remote-jobs?search=rails); [Join/Ecoturn](https://join.com/companies/elektrovorteil/16541757-senior-ruby-on-rails-engineer-m-w-d)). Two postings named Rails 8 explicitly. Rails 8 ships Kamal 2, Solid Queue, Solid Cache and Solid Cable as defaults ([makandra](https://makandra.de/en/articles/rails-8-release-340)). Kamal and Solid Queue did not appear in fetched posting text, so treat them as credibility signals rather than filter terms.

The project that hits the most of these terms *and* builds on your own domain is an **e-invoice / receipt inbox in Rails 8**. Users upload PDFs or XML. A background job extracts fields with an LLM API and validates structured e-invoice formats. A Hotwire UI shows live processing status through Turbo Streams. The app runs on PostgreSQL, is tested with RSpec, runs CI on GitHub Actions and deploys with Docker/Kamal. It links your Wolters Kluwer e-invoicing experience to Rails, it gives a natural reason for background jobs (Sidekiq or Solid Queue, with idempotency and retries, which Ecoturn names explicitly), and it adds the LLM keyword that about a third of postings now carry. Payments and invoicing flows are themselves a domain keyword at SimplePractice, Beacon and VREY ([Arc.dev](https://arc.dev/remote-jobs/ruby-on-rails); [Seedtable/VREY](https://seedtable.com/jobs/9508)). A smaller but still useful alternative is a substantive contribution to an established Rails gem, which carries social proof that a solo app lacks.

Because `cv-interface.sty` has no project macro, reuse `\cvexperience`. Its plain-text fallback already prints title, dates and a "Tech:" line:

```latex
% content/en/projects.tex  (\input it in each main_*.tex between Skills and Experience, or right after WK)
\cvexperience
  {[Project name] -- open-source e-invoice inbox}
  {Personal project}
  {[Mon] 2026 -- Present}
  {github.com/zacsek/[repo]}
  {Ruby on Rails 8, Hotwire (Turbo, Stimulus), PostgreSQL, Solid Queue/Sidekiq, [LLM API], RSpec, GitHub Actions, Docker, Kamal}
  {%
    \item Built a Rails 8 app that ingests PDF/XML invoices, extracts fields via an LLM API in background jobs, and validates [XRechnung/ZUGFeRD] structure.
    \item Real-time processing status with Turbo Streams; idempotent jobs with retry strategy; [X]\% RSpec coverage, CI on GitHub Actions, deployed with Kamal.
  }
```

List it only once the code is public and the dates are real. Hiring managers click GitHub links, and an empty repository does more harm than having no Projects section.

### Wolters Kluwer bullets: same facts, Rails-posting vocabulary

The WK work already overlaps with what Rails postings ask for: SaaS, REST APIs, third-party integrations, PostgreSQL schema migrations ("zero-downtime migrations on large tables" at Ecoturn), payment and invoicing flows, and regulated domains ([Join/Ecoturn](https://join.com/companies/elektrovorteil/16541757-senior-ruby-on-rails-engineer-m-w-d)). Keep the tech line honest (`Java, Kotlin, PostgreSQL`, plus Spring Boot if used) and rewrite the duty statements as outcomes:

| Before | After (fill or drop placeholders) |
|---|---|
| Designed and implemented a novel mechanism for generating payment advice documents, creating detailed PDF summaries of outstanding payments. | Designed and built payment-advice PDF generation for the SMART Connect accounting SaaS, producing [X] documents/month for [Y] business customers and replacing a [manual] process. |
| Reengineered and enhanced workflows for receipt handling and payment generation… | Re-engineered receipt-handling and payment-generation workflows in SMART Connect, cutting [processing time / support tickets / failed payments] by [X%]. |
| Developed features for recognizing, validating, and importing e-invoices… | Built e-invoice ingestion ([XRechnung/ZUGFeRD] recognition, validation, import) for German B2B e-invoicing, handling [X] invoices/day. |
| Implemented key features… account schema changes, bank transaction imports, and third-party accounting data integration. | Integrated bank-transaction imports and third-party accounting data via REST APIs; led PostgreSQL schema migrations [with zero downtime / across X customers]. |

Fold the DE-only bullet about invoice-data APIs into the fourth EN bullet so the two languages stay parallel. Also add one line on ownership, mentoring or code review if it is true. Those are the soft-skill phrases postings repeat: "own features end-to-end", "reviews as knowledge transfer" ([Join/Ecoturn](https://join.com/companies/elektrovorteil/16541757-senior-ruby-on-rails-engineer-m-w-d)).

### Condense 2004–2015 so the recent work gets the space

Six of seven roles are pre-Rails, and together they take about 60% of the bullet space. Keep LogMeIn (the Samsung/HTC/LG OEM work and the Rescue app) and Intellio as short entries of 1–2 bullets each. Drop "(possibly)" from the LogMeIn claim: either defend "one of the first" with a year, or remove it. Fold Citi, Nokia and Neogen into a one-line-each "Earlier experience (2004–2014)" block. Present the C++/Java/embedded background as the breadth that senior postings list: Linux and systems, performance, architecture, and polyglot integration work ([hnhiring](https://hnhiring.com/technologies/rails); [Arc.dev](https://arc.dev/remote-jobs/ruby-on-rails)). Do not present it as the bulk of the CV. If Ruby was only marginal at Intellio or LogMeIn, remove it from their tech lines. An inflated "12 years of Ruby" is as misleading as zero.

## Two layout constructs scramble what parsers read

The layout notes come from building all four PDFs and running them through poppler, pdfminer.six, pypdf and PyMuPDF. This was not a commercial parser, so the results are a stand-in for what an ATS would see. Accented characters (Ő, Á, umlauts, ß) extract cleanly everywhere, so there is nothing to change there. The defects are specific:

| Defect | Layout | Evidence | Fix (tested on a scratch copy where noted) |
|---|---|---|---|
| Ligature code points ﬁ/ﬂ/ﬃ (U+FB0x) inside "efficient", "workflows", "Verifizierungstools" | AltaCV | `altacv.cls` maps ligatures to FB0x and `pdfx` re-inputs `glyphtounicode` | `\usepackage{microtype}` + `\DisableLigatures[f]{encoding=*,family=*}` in `layouts/altacv/main_{en,de}.tex` or the adapter (**tested**: all FB0x removed) |
| Contact line extracts as `\faAt : zacsek@…`, `\faLinkedin : zoltan-szocs` | AltaCV | `\printinfo` puts the unexpanded icon macro in `ActualText` (altacv.cls l.139) | `ActualText={#2}` or `{Email: #2}` (**tested**); print full `linkedin.com/in/zoltan-szocs` and `github.com/zacsek` |
| Event icons extract as `z`, `{`, `*` | AltaCV | `\faCalendar`, `\faTools`, `\faMapMarker` (l.294–296) | Wrap with `\BeginAccSupp{ActualText={}}…\EndAccSupp{}`; tools icon `ActualText={Tech: }` (**tested**) |
| All page-1 dates detached from roles in pdfminer | DeveloperCV | 17% date `minipage` beside each entry | Put dates in the main flow: `\textbf{Role} \hfill Dates \\ Company -- Location` in `developercv-adapter.sty` |
| Icon junk Ó ½ ° U+0087; unlabelled tech line after bullets | DeveloperCV | FontAwesome 4 glyphs in `\icon` (developercv.cls l.80) | `\BeginAccSupp{method=plain,ActualText={}}` (**tested**); print "Tech:" as text |
| Sidebar skills interleave with "About Me" in reading-order extractors | AltaCV | 25/75 `paracol` | Unavoidable in AltaCV; use the ATS layout for portal uploads |
| Empty PDF Title/Author | Both | `pdfinfo` | `\hypersetup{pdftitle=…,pdfauthor=…}` (**tested** in DeveloperCV); `.xmpdata` file for AltaCV/pdfx |

The ligature issue matters because a recruiter's Boolean search for "efficient" or "workflows" will not match "eﬃcient" unless the ATS applies Unicode normalization, and no vendor documents whether it does. ActualText fixes help only parsers that honor it: pdfminer still printed `(cid:239)`. The robust answer is therefore not to draw icon glyphs in the version you upload. Greenhouse's own list of parse-failure causes includes multi-column layouts, graphics and photos, and contact info in text boxes ([Greenhouse Support](https://support.greenhouse.io/hc/en-us/articles/200989175-Unsuccessful-resume-parse)). Textkernel, the parser behind Personio, reports that its older column detection rendered only **62%** of column CVs well, against 90% for its newer model ([Textkernel](https://textkernel.com/learn-support/blog/improving-extraction-from-column-resumes)).

### Add a third, single-column `ats` layout

`common/cv-interface.sty` already provides plain-text fallbacks for `\cvexperience`, `\cveducation`, `\cvskillgroup`, `\cvlanguage` and `\cvprofile`. An ATS layout is therefore mostly a driver file, plus an adapter of about 100 lines:

```latex
% layouts/ats/main_en.tex (sketch)
\documentclass[10pt,a4paper]{article}
\usepackage[margin=2cm]{geometry}
\usepackage[T1]{fontenc}\usepackage{lmodern}
\input{glyphtounicode}\pdfgentounicode=1\pdfinterwordspaceon
\usepackage{enumitem}
\usepackage[hidelinks,pdftitle={Zoltán Szőcs -- CV},pdfauthor={Zoltán Szőcs}]{hyperref}
\usepackage{layouts/ats/ats-adapter}   % \RequirePackage{common/cv-interface}; no fontawesome/tikz/paracol/pdfx
\providecommand{\cvsection}[1]{\cvsectiontitle{#1}}
\input{content/en/personal_info}
\begin{document}
\renderheader   % Name / tagline / "Email: … | Phone: … | Location: …" / "LinkedIn: https://linkedin.com/in/… | GitHub: https://github.com/…"
\cvsection{Summary}\input{content/en/about_me}
\cvsection{Skills}\input{content/en/skills}
\cvsection{Experience}  % WK, projects, Daimler, LogMeIn, Intellio, earlier
\cvsection{Education}\input{content/en/education}
\cvsection{Languages}\input{content/en/languages}
\end{document}
```

In the adapter, put title, company and dates on one line (`\textbf{#1}, #2 \hfill #3`), then the location, then the bullets, then `Technologies: #5`. Make the photo switchable (`\ifatsphoto`) so the DACH build can include it. Add Makefile targets `ats-en`/`ats-de` that produce `Zoltan_Szocs_CV.ats.{en,de}.pdf`, and optionally a `make check` that runs `pdftotext -raw` and greps for `\fa`, U+FB0x and the expected headings. This adapter was sketched in the notes, not built or tested. Upload the ATS PDF to portals (Workday, Greenhouse, Lever, Personio, SuccessFactors). Use the fixed AltaCV for email and direct sends to people. Until the ATS layout exists, DeveloperCV with the date and icon fixes is the safer of the two current layouts.

### Fix the build first

`make en` and `make de` currently fail. The `zacsek/miktex` image aborts with ``File `l3backend-pdftex.def' not found``, and `miktex packages install l3backend` fails with "Unknown archive file size". As of 2026 the backend files ship inside `l3kernel`. Rebuild the image in the `miktex-docker` submodule so it carries an updated `l3kernel`, either through a package-database update at image build time or by baking in the CTAN `l3kernel.tds.zip`. The research workaround did exactly that from outside the image: it ran the same container with `--entrypoint sh` and `pdflatex -include-directory=<dir with l3kernel files>`. Until the image is fixed, no variant can be regenerated from the repo.

## DACH and international remote need different variants

The Rails pool for a Germany-based candidate is DACH product companies, EU-wide remote roles, and US companies that hire EU contractors. devjobsscanner showed **170 Ruby positions in Germany** in October 2026 ([devjobsscanner](https://www.devjobsscanner.com/ruby-jobs-in-germany/)). International listings are frequently geo-restricted: most of Arc's were "Remote, United States" and most of Himalayas' were tied to a single country ([Arc.dev](https://arc.dev/remote-jobs/ruby-on-rails); [Himalayas](https://himalayas.app/jobs/ruby-on-rails)). On those listings, the location and authorization answers filter harder than any keyword. Build both variants from the same `content/` tree. Only the header, summary ending and history depth change.

| Element | DACH variant | International / US remote variant |
|---|---|---|
| Photo | Optional; legally not requirable under the AGG, and tech firms increasingly skip it ([nexvyra](https://nexvyra.de/fakten/karriere-lebenslauf-bewerbungsfoto.html)) | Omit; it reveals protected characteristics ([TopResume](https://resume2hire.topresume.com/career-advice/including-resume-photos)) |
| Work status line | "EU-Bürger, unbefristete Arbeitserlaubnis" (if true) | "EU citizen · based in Germany (CET) · remote with US-East overlap · B2B contractor or EOR" ([Remote.com](https://remote.com/blog/remote-work/authorization-for-remote-work)) |
| Languages | CEFR levels in both languages: "Deutsch C1 (verhandlungssicher)", not "Fortgeschritten"; German B2+ is a hard filter in some postings ([Finanzfluss](https://www.finanzfluss.de/jobs/senior-full-stack-engineer-ruby/); [StepStone](https://www.stepstone.de/jobs/ruby-on-rails-developer)) | English C1 first; German as a bonus |
| History depth | Complete, gap-free chronology (all employers, older ones condensed) | Detail the last 10–15 years; earlier roles in one line or dropped; omit graduation years ([AARP](https://www.aarp.org/work/job-search/info-2019/age-proof-resume-tips.html)) |
| Stack emphasis in summary | Hotwire, pragmatic monoliths, PostgreSQL, Linux; regulated/fintech domain | AI/LLM integration, AWS, TypeScript/React exposure if any, scale numbers |
| Titles | English titles are normal in DE tech; "(m/w/d)" belongs to postings, not your CV | "Senior Backend Engineer – Ruby on Rails" |
| Salary context | Senior Rails roughly €55k–€105k ([Indeed DE](https://de.indeed.com/q-ruby-on-rails-developer-l-berlin-jobs.html); [Himalayas](https://himalayas.app/jobs/ruby-on-rails)) | US remote roughly $110k–$240k; some pay non-US candidates the same or more ([hnhiring](https://hnhiring.com/technologies/rails)) |

There is a legal reason to keep the US variant lean. Age discrimination in AI screening is being litigated in *Mobley v. Workday*, where an ADEA collective for applicants aged 40+ was preliminarily certified in May 2025 ([DWT](https://www.dwt.com/blogs/employment-labor-and-benefits/2025/05/ai-hiring-age-discrimination-federal-court-workday)). Keep month/year dates on every detailed role, though. Removing employment dates draws more attention than it avoids ([Ask a Manager](https://www.askamanager.org/2012/09/should-older-candidates-leave-dates-of-graduation-off-their-resume.html)).

Several fixes apply to both variants. In the DE files: "einen Bildschirmaufnahmemechanismus", "LogMeIns", no comma before "und", "REST-Schnittstellen" instead of the tautology "API-Schnittstellen", and "Quantitative Developer" kept in English. Use one verb style throughout (the WK entry mixes noun style with past tense). Keep the EN and DE bullet lists parallel so both keyword sets match. In EN, change "Written automated tests" to "Wrote automated tests" and "Sony-Ericsson" to "Sony Ericsson". Write the phone as `+49 157 58094107`.

## Facts only you can supply

Several of these recommendations cannot be implemented truthfully without information that is not in the repository. The first row determines how strong the rest of the CV can be.

| Fact needed | Why | Where it goes |
|---|---|---|
| **Was Ruby on Rails (not only Ruby/JRuby + Sidekiq) used at Daimler/KPIT?** Which versions? Was the fleet-management product also Rails? | Decides whether "Ruby on Rails" can appear in that title, tech line and summary, and whether ~5 Rails years can be claimed | `2015_daimler_kpit.tex`, `about_me.tex`, tagline |
| Start/end months for every role and the degree | Tenure computation; DACH gap expectations | all experience files, `education.tex` |
| What happened between 2020 and 2021 | A one-line explanation avoids gap penalties | Daimler or WK entry |
| WK metrics: documents/month, customers, invoices/day, time or error reductions; e-invoice formats (XRechnung/ZUGFeRD?); Spring Boot? | Turns duty statements into evidence | `2021_wolters_kluwer.tex` |
| Daimler/KPIT outcome metrics (throughput, latency), testing/CI/cloud tooling used | Completes the showcase role | `2015_daimler_kpit.tex` |
| LogMeIn scale (installs, customers) and year of the Android screen-sharing work; what Ruby was used for at Intellio/LogMeIn | Supports or removes the "first" claim and the Ruby tags | `2011_logmein.tex`, `2007_intellio.tex` |
| Citizenship and work authorization (EU citizen? permanent right to work in DE?); contractor/EOR willingness | Knockout questions and the status line | `personal_info.tex` variants |
| Remote/relocation preferences and timezone overlap | Remote postings filter on location | summary, status line |
| Formal German recognition of the Romanian degree (anabin/ZAB) | "Dipl.-Ing." is a protected title in Germany. The DE CV uses it, while the EN CV says "MSc". Use the original title + "(equivalent to MSc)" unless recognition exists | `content/{en,de}/education.tex` |
| Actual German and English CEFR levels | DE currently says "Fortgeschritten", EN says "C1"; make them match | `languages.tex` |
| Recent Rails work (repo URL, dates, versions) | The Projects section may exist only when this is real | new `projects.tex` |
| Hands-on use of RSpec, Redis, Hotwire, AWS, GitHub Actions, Python, Kubernetes | Each skill listed must survive an interview probe | `skills.tex` |

## Conclusion

The highest-leverage change is not technical. It is one confirmation (was it Rails at Daimler?) followed by one sentence of honest positioning ("returning to Ruby on Rails"). Per-requirement LLM grading changes the game. An LLM checking "5+ years Ruby on Rails" against a dated role will credit a clearly described 2015–2020 Rails tenure and will not credit a skills-list mention. The same grader penalizes stuffing and mismatches that a 2015 keyword counter would have rewarded. Honest specificity is now also the effective strategy.

The recency gap cannot be written away. It can be shrunk with a few weeks of building. A Rails 8 e-invoicing app with Hotwire, background jobs and an LLM feature does double duty: it covers most of the 2026 keyword list, and it turns the five years at Wolters Kluwer from "not Rails" into domain expertise that DACH fintech and invoicing Rails shops are hiring for. Fix the build, add the ATS layout, and the same `content/` tree will produce a portal-safe PDF, a designed PDF for people, and DACH and international variants, all from one source of truth.
