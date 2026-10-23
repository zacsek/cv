# CV Content Audit for Ruby on Rails ATS / Automated Screening (EN + DE)

Scope: text content of `content/en/*` and `content/de/*` in /home/zacsek/Projects/github/cv, as of commit fc8a49a (Oct 2026). Visual layout was out of scope; layout is mentioned only where it changes what text a parser sees. "Repo:" citations point to local files, and web citations support the general recommendations. Numbers in rewrites shown as `[X]` are placeholders the candidate must fill in or delete. No metrics were invented.

---

## 1. How prominent and credible is Ruby on Rails positioning (headline, summary, skills, bullets, years, title alignment)?

### Takeaway
Rails is badly under-positioned. The exact phrase "Ruby on Rails" appears **nowhere** in either language version. "Rails" appears only twice per language: once in a parenthetical in the summary and once in the skills list. "Rails" is in **no** experience entry, including the only Ruby-centric job (Daimler/KPIT 2015–2020). The headline reads "Sr. Software Engineer", and the current role (2021–present) is tagged Java/Kotlin. An ATS or recruiter therefore sees a Java/Kotlin engineer whose Ruby experience ended in 2020.

### Cited Findings
- Repo: `content/en/personal_info.tex` tagline = `Sr. Software Engineer`, and the DE tagline is `Senior Software-Ingenieur`. Neither mentions Ruby or Rails.
- Repo: `content/en/about_me.tex` says "While proficient in Kotlin, Java, and C++, my core expertise and passion lie in the Ruby ecosystem (Rails, Sidekiq)". Non-Ruby languages are named first, and Rails appears only in parentheses.
- Repo: `content/en/skills.tex` has a single group, `TECH STACK`, listing "Rails, Ruby, Kotlin, Java, Ansible, PostgreSQL, MySQL, Linux, Docker, Git, RabbitMQ, Sidekiq". It says "Rails", never "Ruby on Rails".
- Repo, per-role tech tags and Ruby mentions:
  - Intellio 2007–2011: "C++, Ruby, Linux"
  - LogMeIn 2011–2014: "Java, Android, Ruby"
  - Daimler/KPIT 2015–2020: "Ruby, PostgreSQL, Sidekiq". The only bullet naming Ruby tech is "JRuby / Sidekiq".
  - Wolters Kluwer 2021–current: "Java, Kotlin, PostgreSQL". No Ruby at all.
- Jobscan's match-rate scoring weights hard skills first and job title third, and it looks for exact keyword matches ("project management" ≠ "managed projects"). — [Jobscan tutorial / ATS resume guide](https://www.jobscan.co/blog/ats-resume/)
- Jobscan says the job title is the primary keyword and should be in the headline. It claims resumes containing the target title got 10.6× more interviews, a vendor statistic with unverified methodology. If the candidate held a similar role, the past title can be adjusted to match where duties were essentially the same. Otherwise, the target title can go in the summary. — [Jobscan ATS resume guide](https://www.jobscan.co/blog/ats-resume/)
- Tech Interview Handbook advises a headline of fewer than 10 words, phrased like a LinkedIn headline (e.g. "Senior Front End Engineer"), and repeating key skills from the Skills section inside Work Experience. Some ATS infer years of a skill from the jobs where it appears. — [Tech Interview Handbook – Resume](https://www.techinterviewhandbook.org/resume/)
- Typical Rails postings ask for a few years of professional Rails (often 3+), plus RSpec, Sidekiq, ActiveRecord/MVC, PostgreSQL/MySQL, REST APIs, Git and CI/CD. Hotwire/Turbo/Stimulus is usually listed as a nice-to-have. — [Workable RoR posting](https://jobs.workable.com/jobs/9216716b-8c2b-43ff-ad06-527bff9af6c6.md); [Dice RoR posting](https://www.dice.com/job-detail/041bce0e-c4a0-4c35-be54-d8ef139b867b)
- Advice for ATS keywords is to include both the spelled-out form and the abbreviation, and to mirror the posting's wording exactly. — [The Muse](https://www.themuse.com/advice/a-job-hunters-guide-to-getting-your-resume-past-the-ats-and-into-human-hands); [Mount Royal Univ. ATS guide](https://www.mtroyal.ca/EmploymentCareers/CareerServices/_pdfs/TS_Resumes_Applicant-Tracking-Systems.pdf)

### Inferences
- **Inferable Rails years today:** Rails is mentioned in no role, so a parser that infers skill duration from the roles a skill appears in will compute about **0 years of Rails**. For "Ruby" it would find about 12 years (Intellio + LogMeIn + Daimler tag lines). That figure is misleading in the other direction, because Ruby was a minor tag at Intellio and LogMeIn.
- **Recency problem:** The latest Ruby work ends in 2020. A screener reading "current = Java/Kotlin" may decide Ruby is a past skill. Mitigation depends on facts only the candidate knows:
  - If Ruby/Rails was used at Wolters Kluwer (scripts, internal tools, a Rails service), name it in a WK bullet.
  - If there is recent Rails open-source or side work (github.com/zacsek), add a short "Selected Projects / Open Source" entry with 2024–2026 dates and Rails version numbers (e.g. "Rails 7.2/8, Hotwire, Solid Queue"). This is the strongest truthful way to show current Rails skill.
  - Otherwise, state it in the summary: "Ruby on Rails specialist (2015–2020 production lead), currently Java/Kotlin, returning to Rails".
- **Recommended headline (EN), under 10 words, matching common titles:**
  - "Senior Ruby on Rails Developer | Backend Engineer (Ruby, PostgreSQL)"
  - or "Senior Backend Engineer – Ruby on Rails". Variant for lead roles: "Senior Ruby on Rails Engineer / Tech Lead".
  - Avoid "Sr." Write "Senior", because postings and recruiter Boolean searches use "Senior".
- **Recommended headline (DE):** DACH postings mostly use English titles or "Entwickler (m/w/d)". Use "Senior Ruby on Rails Entwickler | Backend Engineer" or simply "Senior Ruby on Rails Developer". "Senior Software-Ingenieur" is rarely used as a search term in DE job ads; this is an inference from posting conventions and has no source.
- **Job-title alignment per role.** Titles should stay truthful but carry the stack, and the Jobscan guidance supports this kind of adjustment:
  - Daimler/KPIT "Tech Lead" → "Tech Lead / Senior Ruby on Rails Developer". Use the "Ruby on Rails" part only if Rails was actually used. The bullet mentions JRuby/Sidekiq, and Rails is not confirmed by the files.
  - WK "Sr. Software Engineer" → "Senior Software Engineer (Backend, Java/Kotlin)". Do not put "Rails" here unless it was used.
- **Exact-phrase density target:** "Ruby on Rails" should appear in the headline, the summary, the skills list (as "Ruby on Rails (Rails)"), and at least the Daimler role (title or tech line and one bullet). That is about 4–6 natural occurrences, with no stuffing.

### Gaps
- Whether Rails (vs. plain Ruby/JRuby + Sidekiq without Rails) was used at Daimler/KPIT cannot be determined from the files. The candidate must confirm this before "Ruby on Rails" goes into that role.
- No source found that tests how specific ATSs (Workday, Greenhouse, Personio, SAP SuccessFactors) compute per-skill years. The "skill years from role mentions" behaviour is reported by TIH but not vendor-documented.

---

## 2. Which bullets are duty-based vs. achievement-based? Rewrites for the weakest

### Takeaway
About 60% of bullets are duty statements ("Developed features for…", "Implemented key features…") with no metric, scale, users or outcome. The Wolters Kluwer bullets (the current role, the one read most) are the weakest. Daimler and Citi have the only real numbers (5M trucks, 500 GB/day, 12 people, 6 locations / 100+ servers). There is also a **factual copy-paste error**: the EN Neogen (2004–2006) entry contains a Wolters Kluwer SMART Connect bullet.

### Cited Findings
- TIH bullet formula: "[Accomplishment summary]: [Action] that resulted in [quantifiable outcome]". It recommends a few strong achievements over many weak ones and a 1-page resume, though senior candidates commonly use 2. — [Tech Interview Handbook – Resume](https://www.techinterviewhandbook.org/resume/); senior up to 2 pages — [Resumeble](https://www.resumeble.com/career-advice/how-far-back-should-your-resume-go)
- Repo: `content/en/experience/2004_neogen.tex` line 10: "Developed features for recognizing, validating, and importing e-invoices in SMART Connect." This is near-identical to `2021_wolters_kluwer.tex` line 10. SMART Connect is the WK product named in the WK bullets. The DE Neogen file does not contain this bullet, which confirms it is an EN-only paste error.
- Repo bullet classification (EN). The **[A]** marker means the bullet is achievement- or metric-based; **[D]** means it is a duty statement.
  - WK 2021–: 4 bullets.
    - "Designed and implemented a novel mechanism for generating payment advice documents…" [D, no impact/volume]
    - "Reengineered and enhanced workflows…" [D, vague verbs, no outcome]
    - "Developed features for recognizing, validating, and importing e-invoices…" [D]
    - "Implemented key features… including account schema changes, bank transaction imports, and third-party accounting data integration." [D, list of tasks]
  - Daimler/KPIT:
    - "5 million Mercedes trucks" [A, scale]
    - "500 GB of structured data daily" [A, scale; outcome of "optimized" missing]
    - "team of 12 … ensuring effective international collaboration" [half A; the phrase "ensuring effective…" is filler]
  - Citi:
    - bond rate spider [half A, no latency/user numbers]
    - "6 locations with over 100 servers" [A, scale]
    - quant algorithms [D]
  - LogMeIn:
    - "Pioneered… (possibly) the world's first…" [A but self-undermining hedge]
    - "Transformed the Rescue app from PoC to globally deployed" [A, no users/customers number]
    - OEM collaboration [D but strong brand names]
  - Intellio: 3 × [D, technical scope only]
  - Nokia: 2 × [D]
  - Neogen: 2 × [D] + the erroneous bullet
- DE WK bullets use the noun style ("Implementierung…", "Entwurf…"), while all other DE roles use past-tense verbs. — Repo: `content/de/experience/2021_wolters_kluwer.tex`

### Inferences — rewrite examples (truthful, placeholders marked)
**Wolters Kluwer (current, most important to fix):**
- Before: "Designed and implemented a novel mechanism for generating payment advice documents, creating detailed PDF summaries of outstanding payments."
  After: "Designed and built a payment-advice PDF generation service (Kotlin, PostgreSQL) for the SMART Connect accounting SaaS, producing `[X]` documents/month for `[Y]` business customers and replacing a `[manual/legacy]` process."
- Before: "Reengineered and enhanced workflows for receipt handling and payment generation within the SMART Connect cloud-based application."
  After: "Re-engineered receipt-handling and payment-generation workflows in SMART Connect, cutting `[processing time / support tickets / failed payments]` by `[X%]`."
- Before: "Developed features for recognizing, validating, and importing e-invoices within SMART Connect."
  After: "Built e-invoice ingestion (`[XRechnung/ZUGFeRD]` recognition, validation, import) ahead of Germany's B2B e-invoicing mandate, handling `[X]` invoices/day."
  - Only name formats and the mandate if they are true.
  - Keyword note: "e-invoicing", "XRechnung" and "ZUGFeRD" are strong DACH fintech/ERP keywords. This is an inference; I did not source the mandate in this task.
- Before: "Implemented key features within SMART Connect, including account schema changes, bank transaction imports, and third-party accounting data integration."
  After: "Integrated bank-transaction imports and third-party accounting data via REST APIs and led database schema migrations on PostgreSQL with `[zero downtime / X tables / Y customers]`."
  - DE has an extra bullet ("API-Schnittstellen zum Empfang und Versenden von Rechnungsdaten") that EN lacks. Merge it here as "REST APIs for sending/receiving invoice data".
- If any Ruby was used at WK, add one bullet naming it.

**Daimler/KPIT (the Rails showcase role, so expand to 4–5 bullets):**
- Before: "Spearheaded the development of an internal verification tool within Daimler's Truck department, implemented globally across approximately 5 million Mercedes trucks."
  After: "Led development of a Ruby `[on Rails]` vehicle-verification platform for Daimler Trucks, used worldwide to verify `[software/configuration]` on ~5 million Mercedes-Benz trucks."
- Before: "Created and optimized a production environment using JRuby / Sidekiq, tailored to client specifications, handling over 500 GB of structured data daily."
  After: "Architected a JRuby + Sidekiq background-processing pipeline on PostgreSQL ingesting 500+ GB of structured data per day; improved throughput by `[X×]` / reduced job latency from `[A]` to `[B]`."
- Before: "Guided a team of 12 based in India in developing cloud-based fleet management software for a German client, ensuring effective international collaboration and project alignment."
  After: "Tech-led a 12-engineer offshore team (India) delivering a cloud-based fleet-management product (`[Rails, AWS/Azure…]`) for a German OEM client; owned architecture, code reviews and release planning."
  - Remove the phrase "ensuring effective international collaboration and project alignment", which is filler.
- Add if true: testing ("Introduced RSpec test suite, coverage `[X%]`"), CI/CD, mentoring, and the Rails/Ruby version upgrades performed.

**LogMeIn:** Drop "(possibly)". Use "one of the first commercial Android screen-sharing implementations (`[year]`)" or "first in-market…" if it can be defended. For the Rescue app, add scale: "…to a globally deployed enterprise app used by `[X]` support organizations / `[Y]` installs".

**Citi:** Add latency/user numbers if known: "…serving real-time bond-rate queries to `[X]` traders in Excel".

**Neogen (EN):** Delete the SMART Connect bullet; it is factually wrong for 2004–2006.

### Gaps
- No real metrics (users, latency, cost, error rates) exist anywhere in the repo for WK, LogMeIn or Intellio. Only the candidate can supply them.
- Whether the WK work involved e-invoicing standards (XRechnung/ZUGFeRD) is not stated in the files.

---

## 3. Dates, job titles, company names, locations: are they consistent and parser-friendly?

### Takeaway
All dates are **year-only** ("2015 -- 2020", "2021 -- current"). Both Jobscan and German HR guidance advise against this: tenure can't be computed and gaps look hidden. A **2020→2021 gap** is visible but cannot be sized. Company fields contain descriptive parentheticals and a slash ("Daimler extern / KPIT") that confuse employer-name extraction. The abbreviation "Sr." is used inconsistently.

### Cited Findings
- Jobscan says the primary date format should be month + year (MM/YYYY or "Jan 2022"). A year alone can leave the system unable to calculate tenure, and some ATSs default year-only start dates to January 1. Jobscan advises "Present" for ongoing roles and one consistent format throughout. — [Jobscan – resume dates](https://www.jobscan.co/blog/resume-dates); [Santa Clara Univ. / Jobscan formatting mistakes](https://www.scu.edu/careercenter/toolkit/job-scan-common-ats-resume-formatting-mistakes/)
- Spelled-out months are safer internationally because "03/04/2022" is read differently in the US and in Europe. — [Enhancv](https://enhancv.com/blog/ats-resume-formatting-mistakes/)
- TIH uses MM/YYYY ("08/2018 – Present"). — [Tech Interview Handbook](https://www.techinterviewhandbook.org/resume/)
- DE practice puts MM/JJJJ on each entry. Year-only dates read as hiding gaps, and gaps over about 2–3 months are routinely questioned in interviews. — [karrierebibel – tabellarischer Lebenslauf](https://karrierebibel.de/tabellarischer-lebenslauf/); [karrierebibel – Lücken](https://karrierebibel.de/luecken-im-lebenslauf/); [yumda analysis](https://www.yumda.com/de/news/1174475/analyse-bewerber-zu-faul.html)
- Repo facts:
  - Dates: "2021 -- current" (EN) and "2021 -- aktuell" (DE).
  - Titles: "Sr. Software Engineer" vs "Sr. Software Engineer, Android" vs "Tech Lead" vs "Quantitative Developer".
  - Companies: "Intellio (Creator of Intelligent IP Security Cameras)", "LogMeIn (Developer of Remote Access and Support Solutions)", "Daimler extern / KPIT".
  - Education "2000 -- 2005" overlaps Neogen "2004 -- 2006", which is plausible (working student) but unexplained.

### Inferences
- Use "Mon YYYY – Mon YYYY" in EN (e.g. "Mar 2021 – Present") and "MM/JJJJ – heute" in DE. Fill in actual months.
- Explain the 2020–2021 gap if it is longer than about 3 months, e.g. "Career break / relocation / freelance", especially for DE.
- Company field should hold the **company name only**:
  - Use "Intellio" and "LogMeIn" (optionally "LogMeIn (now GoTo)").
  - Move descriptors to a first line, e.g. "Intelligent IP security cameras; embedded Linux + Ruby tooling."
  - "Daimler extern / KPIT" → "KPIT Technologies — client: Daimler AG (Trucks)". "extern" is German jargon inside the EN version.
  - If the fleet-management project was for a different client or period, split it into a separate sub-entry with its own dates.
- Titles: write "Senior Software Engineer" in full. For LogMeIn use "Senior Software Engineer (Android)". In the DE Daimler entry, "Technischer Leiter" means a technical director or plant technical manager in German. Use "Tech Lead" in DE too, since it is a standard Anglicism in DE IT postings (inference).
- Keep location format "City, Country" (already consistent). Add "(remote)" or "(hybrid)" where applicable, because remote employers look for proof of remote work.

### Gaps
- Exact start/end months are not in the repo. The user must supply them.
- Nature of the 2020–2021 gap is unknown.

---

## 4. How to condense or reframe the 2004–2015 non-Rails roles

### Takeaway
Six of the seven roles (2004–2015) are non-Rails and take up about 60% of the bullet space. Condense Neogen, Nokia and Citi into a single "Earlier Experience" block with one line each. Keep Intellio and LogMeIn as short entries (1–2 bullets) that keep their Ruby angle and strongest achievement. Reallocate the space to Daimler/KPIT, Wolters Kluwer and a Projects section.

### Cited Findings
- The common guideline is 10–15 years of detail. Senior candidates may go further when early roles show milestones, but they should condense older roles into a summary rather than full entries, or add a "Career Highlights" section. — [Resumeble](https://www.resumeble.com/career-advice/how-far-back-should-your-resume-go); [Careerflow](https://www.careerflow.ai/blog/how-far-back-to-go-on-resume); [Rezi](https://www.rezi.ai/posts/how-far-back-should-a-resume-go)
- One guide frames the 10–15-year cut as partly an age-discrimination defence. — [Careerflow](https://www.careerflow.ai/blog/how-far-back-to-go-on-resume)
- TIH: "Highlighting a few of your best achievements is better than including many". — [Tech Interview Handbook](https://www.techinterviewhandbook.org/resume/)

### Inferences
- Suggested EN block:
  `Earlier Experience (2004 – 2015)`
  - `Quantitative Developer, Citi, Budapest (2014–2015): C++/Perl bond-rate aggregation; ran 100+ servers across 6 sites.`
  - `Software Developer, Nokia Siemens Networks, Budapest (2006–2007): C++ authentication for 3G IMS; automated testing.`
  - `Software Developer, Neogen, Târgu Mureș (2004–2006): PHP/MySQL ad-serving search engine.`
- Intellio: keep one bullet that mentions Ruby: what was Ruby used for? Test tooling, a management server? The candidate should state it. Then add one embedded-Linux bullet.
- LogMeIn: keep the screen-capture and OEM bullets, which carry strong brand names (Samsung, HTC, LG). Say what Ruby was used for, or drop "Ruby" from its tags if it was marginal, to avoid inflated keyword claims.
- **DACH vs. international:**
  - DE recruiters expect a complete, gap-free chronology ("lückenlos"; see the karrierebibel sources above). Keep all employers listed in DE, but condensed.
  - For US/international remote, it is acceptable to stop detailed entries around 2011 and fold the rest into one line or drop them. This also reduces signals that reveal age (see Q7).

### Gaps
- What Ruby was used for at Intellio/LogMeIn is not stated anywhere.

---

## 5. Skills section: grouping, spelling variants, missing Rails-ecosystem skills, noise, ratings

### Takeaway
The skills section is one flat, unlabeled-by-category list of 12 items. It is missing the exact phrase "Ruby on Rails", testing (RSpec/Minitest), APIs, Redis, CI/CD, cloud and observability. It also omits JRuby and C++, which appear elsewhere in the CV. There are no rating bars (good). The heading "TECH STACK" is non-standard.

### Cited Findings
- Repo: `skills.tex` content is listed in Q1. A "Learning" group (Rust, ML/AI, AWS, Kubernetes, Terraform) is commented out. The DE file is identical apart from the commented heading.
- Rails postings commonly request: RSpec (or Minitest), Capybara, FactoryBot, Sidekiq/Resque/DelayedJob, ActiveRecord/MVC, PostgreSQL/MySQL, RESTful APIs, Git, CI/CD, monitoring (New Relic, Datadog, Rollbar, Honeybadger). Hotwire/Turbo/Stimulus or React is listed as a bonus. — [Workable RoR posting](https://jobs.workable.com/jobs/9216716b-8c2b-43ff-ad06-527bff9af6c6.md); [Dice RoR posting](https://www.dice.com/job-detail/041bce0e-c4a0-4c35-be54-d8ef139b867b)
- Include both full form and abbreviation for terms, e.g. "Amazon Web Services (AWS)". — [Tech Interview Handbook](https://www.techinterviewhandbook.org/resume/); [Mount Royal Univ.](https://www.mtroyal.ca/EmploymentCareers/CareerServices/_pdfs/TS_Resumes_Applicant-Tracking-Systems.pdf)
- TIH suggests a "[Skill summary]: skill | skill | skill" grouping (languages, frameworks, databases). — [Tech Interview Handbook](https://www.techinterviewhandbook.org/resume/)
- Skill bars and graphical ratings are not ATS-friendly because "the ATS can't read the levels". If levels are wanted, use plain-text parentheses. — [Jobscan – template trend](https://www.jobscan.co/blog/the-resume-template-trend-you-should-avoid/); [Hiration](https://www.hiration.com/blog/skill-bars-resume/)

### Inferences
- Proposed grouping. Include only what is true; items marked `?` need confirmation.
  - **Ruby & Rails:** Ruby, Ruby on Rails (Rails), JRuby, Sidekiq, ActiveRecord, RSpec?, Minitest?, Hotwire/Turbo/Stimulus?, RuboCop?
  - **Other languages:** Kotlin, Java, C++ (Spring Boot? if used at WK)
  - **Data & messaging:** PostgreSQL, MySQL, Redis?, RabbitMQ
  - **APIs & architecture:** REST APIs, background jobs, microservices?, GraphQL?
  - **DevOps & cloud:** Docker, Ansible, Linux, Git, CI/CD (GitHub Actions / GitLab CI / Jenkins?), AWS?, Kubernetes?
  - **Practices:** TDD?, code review, technical leadership, agile/Scrum?
- Use "PostgreSQL" (the canonical name); optionally add "(Postgres)" once. Use "Ruby on Rails" plus "Rails"; use "RoR" only if a posting uses it.
- Move "Tech Lead / team leadership (12 engineers)" into the summary rather than skills.
- Rename the heading to "Skills" / "Technical Skills" (DE: "Kenntnisse" or "IT-Kenntnisse"). Standard headings are safest for section detection; this is an inference consistent with the TIH advice against unusual headers.
- The commented "Learning" group: un-comment only items with real hands-on use (e.g. AWS). Otherwise leave it out, because unproven keywords invite interview probing.

### Gaps
- Actual test frameworks, CI, cloud and frontend tooling used at Daimler/KPIT and WK are not documented in the repo.

---

## 6. Summary / about-me: length, keyword density, target-role clarity

### Takeaway
The summary is 56 words (EN). It opens with a generic title, names Kotlin/Java/C++ before Ruby, says "Rails" only once in parentheses, and closes vaguely ("a focused engineering team"). It has no numbers and no statement of target role or remote availability.

### Cited Findings
- Repo: `content/en/about_me.tex` (quoted in Q1). DE is a faithful translation, with stiff phrasing such as "Ich zeichne mich durch die Architektur komplexer Systeme aus".
- TIH: summary under 50 words, start with the role noun, active voice, explain fit. — [Tech Interview Handbook](https://www.techinterviewhandbook.org/resume/)
- Jobscan: include the target job title in the summary when the past titles don't match. — [Jobscan ATS guide](https://www.jobscan.co/blog/ats-resume/)

### Inferences
- EN rewrite (about 50 words):
  "Senior Ruby on Rails developer and former Tech Lead with 20+ years in software engineering. Built and scaled Ruby/Sidekiq/PostgreSQL systems processing 500+ GB/day for Daimler Trucks (~5M vehicles) and led a 12-engineer team. Now also experienced in Kotlin/Java fintech SaaS. Seeking a senior backend/Rails role, remote (EU/US overlap) or Stuttgart area."
- DE rewrite:
  "Senior Ruby-on-Rails-Entwickler und ehemaliger Tech Lead mit über 20 Jahren Berufserfahrung. Entwicklung skalierbarer Ruby/Sidekiq/PostgreSQL-Systeme (500+ GB/Tag) für Daimler Trucks (~5 Mio. Fahrzeuge), Führung eines 12-köpfigen Teams; aktuell Kotlin/Java im FinTech-SaaS-Umfeld. Gesucht: Senior-Backend-/Rails-Rolle, remote oder Raum Stuttgart."
- Only use "Rails" in these summaries if Rails was used at Daimler (see Q1). Otherwise write "Ruby (JRuby, Sidekiq)" and point to Rails side projects.

### Gaps
- Candidate's actual location and remote preferences are not stated in the files.

---

## 7. Contact / personal info: missing or risky items for DACH + international

### Takeaway
Name, email, phone, city, LinkedIn and GitHub are present, and there is no birthdate (good). The **photo** is included in both versions. That is acceptable or expected in DACH but a liability for US/UK applications. Missing: work-authorization status and remote/relocation availability. The LinkedIn link renders as "/in/zoltan-szocs" in the developercv layout instead of a full URL.

### Cited Findings
- Repo: `personal_info.tex` has `\cvphoto{zoltan_portrait_sq}`, email, phone "+49-157-58094107", "Esslingen am Neckar, Germany", `\cvlinkedin{zoltan-szocs}`, `\cvgithub{zacsek}`. The developercv adapter prints the LinkedIn text as `/in/zoltan-szocs` (`layouts/developercv/developercv-adapter.sty` line 122).
- TIH must-haves: name, phone, city, email, LinkedIn. — [Tech Interview Handbook](https://www.techinterviewhandbook.org/resume/)
- Germany:
  - Photo, date of birth and marital status are voluntary under AGG and cannot be required.
  - A photo is still common in German applications.
  - Tech and international companies increasingly omit it.
  - Date of birth is still usual in DE but unusual internationally.
  - These points come from commercial blogs with conflicting figures. — [nexvyra.de](https://nexvyra.de/fakten/karriere-lebenslauf-aufbau); [airesume.guru DE](https://airesume.guru/de/blog/lebenslauf-aufbau-tipps); [TU Darmstadt guide](https://www.owl.tu-darmstadt.de/media/owl/schreibtechniken_und__uebungen/Bewerbungen_Lebenslauf.pdf)
- US: photos are discouraged because they reveal protected characteristics (EEOC: race, sex, age 40+). Some employers reject resumes with photos to avoid bias claims, and one unverified source says some ATSs flag or strip images. — [TopResume](https://resume2hire.topresume.com/career-advice/including-resume-photos); [ResumeGenius](https://resumegenius.com/faq/should-you-have-a-photo-on-your-resume); [f1jobs.io (unverified ATS claim)](https://www.f1jobs.io/resources/blog/photo-on-resume-us-application-international-candidates)
- Work authorization depends on where the work is physically performed. Non-US persons need authorization to work in the US, and US companies often hire foreign remote workers as contractors or through an employer of record. — [Remote.com](https://remote.com/blog/remote-work/authorization-for-remote-work); [Justworks](https://www.justworks.com/blog/remote-work-how-to-work-for-a-us-company-abroad)

### Inferences
- Build two variants from the same content:
  - **DE/DACH:** photo optional (keep it if the user is comfortable with it). Add "EU-Bürger, unbefristete Arbeitserlaubnis" (only if true; Hungarian/Romanian citizenship is likely but not confirmed in the files).
  - **International/US:** no photo. Add a line like "EU citizen · based in Germany (CET) · open to remote, EU/US-East overlap · contractor (B2B) or EOR for non-EU employers".
- Render the LinkedIn as visible text "linkedin.com/in/zoltan-szocs" and GitHub as "github.com/zacsek". Parsers and humans recognise full URLs; a bare "/in/…" may not be recognised (inference).
- Phone: use "+49 157 58094107" (spaces, E.164-like). Hyphens are fine for most parsers but less standard (minor inference).
- Age signals: education "2000–2005" plus "20+ years" reveals age. For the US variant, optionally omit graduation years and condense pre-2011 roles (see Q4). This addresses an age-bias concern raised in the sources above.

### Gaps
- Citizenship and work-permit status are not stated anywhere in the repo.
- I found no rigorous (non-vendor) data on the share of DACH tech employers that expect photos in 2026.

---

## 8. Spelling, grammar, and EN–DE consistency

### Takeaway
There are several small EN grammar issues, several DE grammar and terminology errors, and content drift between languages. The drift covers bullets present in only one language, a language-level downgrade in DE, and a degree title that differs between EN and DE.

### Cited Findings (all Repo)
- **EN:**
  - Nokia: "Written automated tests…" should be "Wrote automated tests…".
  - WK: "Reengineered" should be "Re-engineered" (both spellings exist; hyphenated is more common in CVs, a minor point).
  - LogMeIn: "(possibly)" hedging; "Sony-Ericsson" should be "Sony Ericsson".
  - "2021 -- current" should be "Present".
  - "Sr." is inconsistent with "Senior Software Engineer" in the summary.
  - Neogen: anachronistic SMART Connect bullet.
- **DE:**
  - LogMeIn: "Entwickelte ein Bildschirmaufnahmemechanismus" should be "einen Bildschirmaufnahmemechanismus".
  - "LogMeIn's" should be "LogMeIns". The genitive apostrophe is an Anglicism; Duden tolerates it only in specific cases.
  - Daimler: "…Flottenmanagementsoftware, und sicherte…" has a superfluous comma before "und".
  - Daimler title: "Technischer Leiter" is a mistranslation of "Tech Lead".
  - WK: "API-Schnittstellen" is a tautology. Use "REST-Schnittstellen" or "APIs".
  - "Quantitativer Entwickler" is unusual; use "Quantitative Developer" in DE as well.
  - "Anleihenbewertungs-Spider" mistranslates "bond rate", which is closer to "Anleihenkurse/-renditen". Use "Crawler" instead of "Spider".
- **Drift:**
  - DE WK has the "API-Schnittstellen" bullet but lacks the EN "account schema changes / bank transaction imports / third-party accounting data" bullet.
  - EN Neogen has 3 bullets, DE has 2.
  - DE languages read "Fortgeschritten" for English/German/Romanian, while EN says "Advanced / C1". The DE version drops the CEFR level. For German itself, "Fortgeschritten" undersells C1. Use "C1 (verhandlungssicher)" or CEFR codes in both languages.
  - Degree: EN "Master of Science (MSc) in Automation Engineering" vs DE "Dipl.-Ing. (MSc) in Automatisierungstechnik". These are different titles. "Dipl.-Ing." is a protected German academic title, so check the formal recognition (anabin/ZAB) before using it. Otherwise use the original Romanian title plus "(equivalent to MSc)" (inference; no legal source fetched).
  - "Targu Mures" vs proper "Târgu Mureș": ASCII is fine for ATS, but be consistent.

### Inferences
- Keep the EN and DE `experience/*.tex` files bullet-for-bullet parallel so ATS keyword sets match across languages.
- In DE bullets keep tool names in English (Ruby on Rails, Sidekiq, PostgreSQL, Code Review, Tech Lead), since DACH postings use them verbatim.
- Use a single verb style per language (DE: past tense "Entwickelte…", or consistently noun style, but not mixed).

### Gaps
- Not verified whether the Romanian degree has a formal German equivalence (anabin "H+" status) that would justify "Dipl.-Ing.".
