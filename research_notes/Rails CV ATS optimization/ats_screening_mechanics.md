# How ATS and AI Screening Rank and Filter Software Engineering CVs (as of Oct 2026)

Research date: 2026-10-23. Most sources date from 2021 to Aug 2026. Third-party "ATS advice" blogs (Jobscan, Enhancv, ResumeGeni, jobwizard etc.) sell resume products and have a conflict of interest. They are marked as secondary wherever they are used.

## 1. How the major ATSs work: ranking/scoring vs. parsing + recruiter search, and their AI features

### Takeaway
Tech-focused ATSs (Greenhouse, Ashby, Lever) say publicly that their AI does not auto-reject or numerically rank candidates. Instead it flags, groups, or gives "meets / does not meet" verdicts per criterion, and a human makes the decision. Enterprise systems are different. Workday with HiredScore explicitly grades every applicant A–D against the job description, and since Aug 2026 that grading is LLM-based. Most automatic rejection still comes from knockout questions on the application form, not from CV text.

### Cited Findings
**Greenhouse**
- Greenhouse states it "never uses AI to rate candidates or auto-reject applications". Its AI suggests search terms that recruiters use to filter applications and helps write scorecard attributes. It also offers optional resume anonymization that removes name, gender, photo and social links. Dated Jan 8, 2025. — [Greenhouse blog: How does Greenhouse use AI](https://my.greenhouse.com/blogs/how-does-greenhouse-use-ai-heres-everything-candidates-need-to-know)
- Greenhouse launched "Real Talent" in its Fall 2025 release (Sept 16, 2025). It bundles AI talent matching, spam/fraud detection and identity verification. — [Greenhouse newsroom](https://www.greenhouse.com/newsroom/greenhouse-launches-new-tools-to-tame-chaotic-hiring-funnels); Australian rollout planned for early 2026 — [Greenhouse newsroom, Oct 2025](https://www.greenhouse.com/newsroom/greenhouse-reinforces-commitment-to-australian-customers-with-real-talent-launch-and-new-seek-integrations)
- Secondary sources say Greenhouse's matching sorts applicants against job criteria and surfaces strong matches without auto-advancing or rejecting anyone. They also say Auto-Reject exists but triggers only on answers to custom application questions, not resume content, and only on Plus/Pro tiers. — [Jobscan](https://www.jobscan.co/blog/greenhouse-ats-what-job-seekers-need-to-know/), [scale.jobs](https://scale.jobs/blog/greenhouse-ats-does-it-automatically-reject-your-resume) (secondary; not verified against Greenhouse help docs)

**Ashby**
- With AI-Assisted Application Review, recruiters define criteria per job. Each criterion is a title plus a prompt that an LLM evaluates against each applicant. Criteria can be auto-generated from the job description. The feature is available on Foundations, Plus and Enterprise plans. — [Ashby docs](https://docs.ashbyhq.com/ai-assisted-application-review), [Ashby product update](https://www.ashbyhq.com/product-updates/automatically-generate-ai-job-criteria)
- Ashby's VP of Talent says the output is "Meets" or "Does not Meet" per criterion, with no scoring or ranking. He describes reviewing 1,500 resumes in 6 hours with it. — [Ashby blog](https://www.ashbyhq.com/blog/recruiting/ai-assisted-application-review-in-practice)

**Workday / HiredScore**
- HiredScore Spotlight assigns grades A (most qualified) to D (least qualified) based on how well the resume matches the qualifications in the job description. Recruiters can sort and filter by grade. The docs say top-graded candidates are "most likely to reach the interview stage" but that C/D candidates may still fit. No grade is assigned if there is no resume, the format is unsupported, or the requisition has no job description. — [Workday doc: HiredScore grades](https://doc.workday.com/hiredscore/en-us/workday-hiredscore/recruiter-productivity-/concept--hiredscore-grades.html), [candidate grades reference](https://doc.workday.com/hiredscore/en-us/workday-hiredscore/recruiter-productivity-/reference--candidate-grades.html)
- **New Aug 2026:** Spotlight replaced its fixed framework with an LLM. The LLM evaluates each "screenable qualification" individually against the *parsed* resume. Meeting all basic qualifications puts a candidate in the A/B band, otherwise C/D. Preferred qualifications separate A from B and C from D. A new "Fit & Gap" view shows which requirements are met or unmet, with pointers to resume sections (experience, education, skills, languages, certifications, summary). The change is opt-in, with a pilot first and then a cutover. — [Workday HiredScore release note, 5 Aug 2026](https://doc.workday.com/hiredscore/en-us/workday-hiredscore/hiredscore-release-notes/2026/august/wednesday--5th-august.html)
- *Mobley v. Workday*: in May 2025, Judge Rita Lin preliminarily certified an ADEA (age 40+) collective of applicants allegedly ranked or screened by Workday AI since Sept 2020. Workday says its platform does not automatically rank or reject candidates. In Aug 2025 the court ordered Workday to list customers that use its AI features, and it addressed whether HiredScore is in scope. — [DWT, May 2025](https://www.dwt.com/blogs/employment-labor-and-benefits/2025/05/ai-hiring-age-discrimination-federal-court-workday), [Livermore Vine, Aug 2025](https://www.livermorevine.com/courts/2025/08/21/judge-orders-workday-to-provide-list-of-clients-using-ai-features-in-hiring-processes/), [CourtListener Dkt. 158](https://storage.courtlistener.com/recap/gov.uscourts.cand.408645/gov.uscourts.cand.408645.158.0.pdf)

**Lever, iCIMS, SmartRecruiters, Teamtailor** (secondary sources only)
- SmartRecruiters markets AI candidate matching under the name "Winston". — [skima.ai](https://skima.ai/blog/comparison/best-smartrecruiters-alternatives)
- iCIMS is described as offering AI candidate-to-job matching and automated candidate ranking. — [Integral Recruiting Design 2025](https://integralrecruiting.com/icims-vs-lever-ats-comparison-2025/) (the authors say it was AI-compiled and "directional")
- Lever: G2 user reviews mention a "talent fit" filtering feature. — [G2](https://www.g2.com/compare/lever-vs-icims)

**LinkedIn Recruiter**
- Hiring Assistant, LinkedIn's AI agent, went globally available in English by the end of Sept 2025. It evaluates applicants from LinkedIn profiles, resumes and screening answers against recruiter-defined qualifications. It can also pre-screen via InMail (location, relocation). LinkedIn claims recruiters review 62% fewer profiles; this is a vendor figure. — [LinkedIn News, 2025](https://news.linkedin.com/2025/hiring-assistant-globally-available)

**DACH (Personio, softgarden, d.vinci, SAP SuccessFactors, rexx)**
- softgarden is listed with "KI-Scoring" and CV parsing. d.vinci offers CV parsing of PDF applications and a simple ABC rating for the first shortlist. No source confirmed AI matching or ranking in Personio. — [trusted.de Personio vs softgarden](https://trusted.de/personio-vs-softgarden), [trusted.de Personio vs d.vinci](https://trusted.de/personio-vs-d-vinci) (comparison/affiliate sites)

**Other context**
- The HBS/Accenture "Hidden Workers" report (2021) found that 99% of Fortune 500 companies use an ATS. — [HBS Working Knowledge](https://hbswk.hbs.edu/item/how-to-tap-the-talent-automated-hr-platforms-miss)

### Inferences
- A typical tech startup or scale-up on Greenhouse, Ashby or Lever works like this: the CV is parsed, a recruiter searches or filters (often with AI-suggested terms), and an LLM may give per-criterion verdicts. The binding gate is the recruiter's few-second read and the knockout questions.
- An enterprise on Workday plus HiredScore grades every applicant. Matching each "basic qualification" in the posting explicitly in the CV (stack, years, degree or equivalent) directly affects whether a candidate lands in A/B or C/D.
- Because the LLM graders (Ashby, HiredScore 2026) judge per requirement, CVs should make each likely requirement easy to verify: a tech name inside a role bullet, with dates.

### Gaps
- I found no primary vendor documentation for the AI features of SAP SuccessFactors, rexx, Personio, Teamtailor, iCIMS or Lever. SAP SuccessFactors offers Joule/AI-assisted job matching per general knowledge, but this is unverified here.
- I could not verify the exact Greenhouse Real Talent match tier names.
- The outcome of the HiredScore scope dispute in *Mobley* is not confirmed.

## 2. What parsers extract and match on (titles, years per skill, synonyms, recency, location, education)

### Takeaway
Commercial parsers such as Textkernel (which acquired Sovren in Nov 2021, the most widely embedded parser) extract 50+ fields. They normalize skills against large synonym taxonomies, so common abbreviations like RoR → Ruby on Rails are likely to map. They also compute derived values such as total months of experience from job date ranges. The CV structure and date format determine whether those derived values come out right.

### Cited Findings
- Textkernel's taxonomy covers 13,000+ skills with 250,000+ synonyms across 20+ languages. Each skill is linked to one or more synonyms per language, and descriptions are kept to 1–3 words "likely to match skill descriptions in CVs and vacancies". — [Textkernel Skills API](https://developers.textkernel.com/SkillsIntelligence/master/skills/v3)
- Skills normalization is a paid add-on, so not every ATS integration uses it. — [Textkernel Skills API overview](https://developer.textkernel.com/tx-platform/v10/skills-intelligence/skills-api/overview/)
- The parser "computes implicit information based on the extracted data, such as total years of experience and highest level of education". — [Textkernel data model](https://developer.textkernel.com/Parser/master/data_model)
- A March 2024 release note fixed MonthsOfWorkExperience so that overlapping job date ranges no longer double-count. This confirms that experience is computed from date ranges. — [Textkernel release notes archive](https://developer.textkernel.com/tx-platform/v10/release-notes-archive/)
- Textkernel says it assigns time and recency values to data points. The parser outputs JSON/XML with 50+ extracted, normalized or inferred fields. — [Textkernel Parser](https://developers.textkernel.com/Parser/master)
- Textkernel acquired Sovren in Nov 2021. — [jobspipe.dev](https://jobspipe.dev/blog/resume-parser-api) (secondary)
- The Workday HiredScore LLM evaluates against the *parsed* resume sections: experience, education, skills, languages, certifications and summary. Parse quality therefore still matters even with LLM grading. — [Workday release note Aug 2026](https://doc.workday.com/hiredscore/en-us/workday-hiredscore/hiredscore-release-notes/2026/august/wednesday--5th-august.html)

### Inferences
- Per-skill experience in Sovren/Textkernel-style parsers is commonly derived from the date range of the job in which the skill appears. Skills listed only in a standalone "Skills" section therefore likely get no duration or recency. Mention key tech (Ruby, Rails, PostgreSQL) inside dated roles. This is inferred from the documented date-based computation and recency tagging; the exact per-skill field semantics were not verified.
- Use parseable date formats such as "MM/YYYY – MM/YYYY" or "Present". Year-only dates reduce accuracy.
- Do not rely on the synonym mapping for niche abbreviations. Write the full term once with the abbreviation, e.g. "Ruby on Rails (RoR)".

### Gaps
- I could not access documentation for the exact per-skill fields (e.g. Sovren "MonthsExperience"/"LastUsed"). The search returned no confirmation.
- I found no source on how Greenhouse, Lever or Ashby parsers (often third-party) weight location or title matching.

## 3. Knockout questions vs. CV content

### Takeaway
Hard automated rejection is mostly driven by structured application-form answers: work authorization, location or relocation, salary, and must-have yes/no questions. It is not driven by the CV text.

### Cited Findings
- Greenhouse Auto-Reject screens on custom application question answers. A work-authorization knockout can disqualify applicants before any human review, and resume content does not trigger these rules. — [Jobscan](https://www.jobscan.co/blog/greenhouse-ats-what-job-seekers-need-to-know/), [ResumeAdapter](https://www.resumeadapter.com/ats/greenhouse/how-it-parses) (secondary)
- The HBS "Hidden Workers" report found that ATS configurations rely on "negative" filters, such as excluding candidates without a degree or with a 6-month employment gap. 88% of employers said qualified high-skilled candidates were rejected because they did not exactly match the criteria (94% for middle-skilled). The survey covered 2,250+ executives and 8,000+ workers in the US, Germany and the UK, published 2021. — [HR Dive, Sept 2021](https://www.hrdive.com/news/report-applicant-tracking-systems-may-exclude-whole-segments-of-candidates/606614/), [HBS Working Knowledge](https://hbswk.hbs.edu/item/how-to-tap-the-talent-automated-hr-platforms-miss)
- LinkedIn Hiring Assistant collects location preference and relocation willingness via InMail pre-screening. — [LinkedIn News 2025](https://news.linkedin.com/2025/hiring-assistant-globally-available)

### Inferences
- Answer knockout questions accurately. A false "yes" on work authorization gets found out later. For remote roles, the location and timezone answer is often the real filter.
- Employment-gap filters exist, as the HBS report shows, though that finding is from 2021. A short line explaining any gap helps.

### Gaps
- The HBS data is from 2021 and partly pre-dates LLM screening. I found no newer equivalent survey.

## 4. LLM-based screening: how it evaluates, prompt injection, keyword stuffing

### Takeaway
LLM screeners assess each criterion semantically (Ashby, HiredScore 2026, LinkedIn). Hidden-text prompt injection is now common enough that vendors measure it, and recruiters report blacklisting candidates who use it. Keyword stuffing fools some LLMs but is caught or penalized by others. Neither tactic is worth the risk.

### Cited Findings
- Greenhouse estimated that about 1% of roughly 300M resumes it processed in H1 2025 contained white-text messages. ManpowerGroup finds hidden text in about 10% of the resumes it scans with AI. Some recruiters automatically reject applicants who try to trick AI. — [Boston Globe, Oct 7 2025](https://www.bostonglobe.com/2025/10/07/business/ai-resumes-jobs-recruiters-applications); [Built In](https://builtin.com/articles/hidden-ai-prompts-in-resume)
- A Duke/UNC study of about 200k hireEZ resumes found hidden instructions in at least 1%. Cases rose sevenfold between July 2024 and Nov 2025. The study did not test whether injections changed outcomes. — [Let's Data Science summary](https://letsdatascience.com/news/applicants-hide-prompts-in-resumes-becd8ae8)
- One CEO found about 1,500 characters of white-on-white text in a resume and blocked the applicant from reapplying. Greenhouse also markets fraud and spam detection, which is part of Real Talent. — [Built In](https://builtin.com/articles/hidden-ai-prompts-in-resume); [Greenhouse newsroom](https://www.greenhouse.com/newsroom/greenhouse-launches-new-tools-to-tame-chaotic-hiring-funnels)
- Keyword stuffing results vary by model. In an audit, Grok-fast scored a keyword-stuffed resume 92/100 against 15 without keywords. ChatGPT-fast flagged the stuffed resume as satirical or incoherent. The models most susceptible to keyword stuffing were the ones that failed role-mismatch tests. — [arXiv 2507.11548 (2025)](https://arxiv.org/pdf/2507.11548)
- A University of Illinois MSBA practicum (June 2026) found that the screening model significantly lowered scores for keyword stuffing and clearly penalized career gaps. Prestige markers had no significant effect. This is a small study. — [Gies College of Business, Jun 29 2026](https://giesbusiness.illinois.edu/news/2026/06/29/msba-research-examines-bias-in-ai-resume-screening)
- LLM self-preference: resumes written by the same LLM as the evaluator were 23–60% more likely to be shortlisted than equally qualified human-written ones (revised Feb 2026). — [arXiv 2509.00462](https://arxiv.org/html/2509.00462v3)
- Earlier embedding-retrieval screening audits found race and gender bias. — [Wilson & Caliskan, arXiv 2407.20371 (2024)](https://arxiv.org/html/2407.20371v1)

### Inferences
- Optimize for an LLM or human checking "is requirement X evidenced?". Name the tech in context with scope and outcome, e.g. "Upgraded Rails 6→7.1 across 40-service monolith; cut p95 latency 35%". Do not repeat keyword lists.
- Warn explicitly against white text and prompt injection. Detection exists at vendor scale, and the penalty is rejection or a reapply ban.

### Gaps
- I found no vendor documentation on how Greenhouse or others penalize detected hidden text (flag vs. auto-reject).
- I found no evidence on whether quantified-impact bullets score higher in production LLM screeners. That is plausible but unmeasured.

## 5. File format, naming, length, DACH vs. US norms

### Takeaway
I found no independent benchmark showing that PDF or DOCX parses better in 2025–26. Text-based PDFs are broadly accepted. Layout matters more than format: single column, no tables or text boxes, no contact data in headers or footers. In Germany a photo is optional under the AGG and tech employers increasingly skip it. In the US, photo and birthdate are omitted.

### Cited Findings
- HiredScore assigns no grade when the resume is in an unsupported format, so format failure means invisibility in grade-sorted views. — [Workday HiredScore grades doc](https://doc.workday.com/hiredscore/en-us/workday-hiredscore/recruiter-productivity-/reference--candidate-grades.html)
- Multi-column layouts are read as a single text stream, which can mix sidebar content into job descriptions. Header and footer content may be dropped. Image or scanned PDFs need OCR. — [jobwizard.ai](https://jobwizard.ai/blog/how-to-optimize-your-resume-for-ats-systems-in-2026-872842), [jobmentis](https://www.jobmentis.com/en-gb/guide/resume-parsing) (secondary); parser vendor tips: [RChilli](https://www.rchilli.com/tips-for-creating-electronics-resumes)
- Sources conflict on format. One ranks PDF first for consistency; another says DOCX parses more predictably. Both say to follow the posting's instruction. — [jobcannon](https://jobcannon.io/de/blog/what-is-an-ats-friendly-resume) vs. [jobshinobi](https://jobshinobi.com/blog/resume-scanner-pdf-vs-docx-which-is-better)
- Germany: since the AGG (in force 18.08.2006), employers may not require a photo, because it reveals protected traits such as age and sex (§1 AGG). Rejecting for a missing photo can count as evidence of discrimination under §22 AGG and lead to compensation under §15. Tech and international firms increasingly omit photos, while some SMEs still see an application without one as incomplete. — [nexvyra.de 2026](https://nexvyra.de/fakten/karriere-lebenslauf-bewerbungsfoto.html), [skill-sprinters 2026](https://skill-sprinters.de/blog/karriere/bewerbungsfoto-2026-pflicht/)
- Greenhouse offers anonymization that strips the photo during screening. — [Greenhouse blog Jan 2025](https://my.greenhouse.com/blogs/how-does-greenhouse-use-ai-heres-everything-candidates-need-to-know)

### Inferences
- For DACH plus international remote roles, a no-photo, single-column, text PDF with an optional DOCX copy is the safest default. File naming such as `Firstname-Lastname-CV-Rails.pdf` is convention, not evidence-based.
- A 2-page CV is standard for 15–20+ years of experience in both DACH and the US. LLM graders read the full parsed text, so length is less of a machine issue than a human-scanning one.

### Gaps
- I found no reliable source on page-count norms or the DACH tabular Lebenslauf for senior developers, and no data on file naming effects.
- There is no published PDF vs. DOCX parse benchmark for Workday, Greenhouse or Textkernel.

## 6. Myths vs. evidence

### Takeaway
The "75% rejected by ATS" figure has no study behind it. The real automated rejections come from knockout questions, rigid negative filters, and now LLM grading that sorts candidates into piles recruiters may never reach.

### Cited Findings
- The "75% of resumes are never seen" stat traces to a 2012 sales pitch by Preptel, a resume-optimization vendor that closed in 2013, with no published methodology. It spread via Forbes (2014), CIO.com (2018) and CNBC (2019). — [The Interview Guys](https://blog.theinterviewguys.com/?p=1967), [HiringThing](https://blog.hiringthing.com/applicant-tracking-systems-arent-excluding-job-applicants-people-are) (secondary, but consistent)
- Greenhouse says rejection is a manual action by a user and that AI does not decide which applications are seen. — [Greenhouse blog Jan 2025](https://my.greenhouse.com/blogs/how-does-greenhouse-use-ai-heres-everything-candidates-need-to-know)
- Recruiters often review in batches and stop once they have enough suitable candidates. Ranking position therefore functions as de-facto rejection. — [Built In](https://builtin.com/articles/hidden-ai-prompts-in-resume)
- Counter-evidence that ATS filtering is real: 88% of employers acknowledge qualified candidates are filtered out by exact-match criteria. — [HR Dive / HBS 2021](https://www.hrdive.com/news/report-applicant-tracking-systems-may-exclude-whole-segments-of-candidates/606614/)

### Inferences
- "ATS can't read PDFs" is outdated for text PDFs (no direct benchmark found). The real risks are image PDFs, columns and tables.
- The accurate framing is "ATS rarely auto-rejects on CV text, but it sorts". A poorly matched or badly parsed CV ends up at the bottom of a grade- or match-sorted list that may never get reviewed.

### Gaps
- There is no rigorous public data on what share of applications are auto-rejected.

## 7. Age concerns for 20+ years of experience; regulation

### Takeaway
Advice converges on showing the last 10–15 years in detail and dropping graduation dates, while keeping employment dates. Age bias in automated screening is an active legal issue (*Mobley v. Workday*, ADEA collective). In the EU, hiring AI is "high-risk" under the AI Act, but those obligations were delayed to Dec 2027.

### Cited Findings
- AARP advises limiting experience to the past 15 years and removing graduation and certification dates. Signals such as AOL/Yahoo email addresses can mark a candidate as older. — [AARP](https://www.aarp.org/work/job-search/info-2019/age-proof-resume-tips.html) (2019, still current advice)
- Ask a Manager says leaving out graduation years is standard past about 40. Removing employment dates is "terrible advice" because it draws attention. — [Ask a Manager](https://www.askamanager.org/2012/09/should-older-candidates-leave-dates-of-graduation-off-their-resume.html) (2012); Dice agrees: never omit job timeframes — [Dice, 2016](https://insights.dice.com/2016/02/12/with-resumes-dont-leave-off-dates/) (old but consistent)
- *Mobley v. Workday*: ADEA collective (40+) preliminarily certified in May 2025, alleging AI ranking and screening disadvantages older applicants. — [DWT May 2025](https://www.dwt.com/blogs/employment-labor-and-benefits/2025/05/ai-hiring-age-discrimination-federal-court-workday)
- A June 2026 Illinois study found its screening model clearly penalized career gaps. — [Gies, Jun 2026](https://giesbusiness.illinois.edu/news/2026/06/29/msba-research-examines-bias-in-ai-resume-screening)
- EU AI Act: Annex III lists recruitment and hiring AI as high-risk. The Digital Omnibus, approved by Parliament on June 16 and by the Council on June 29, 2026, moves stand-alone Annex III obligations from Aug 2, 2026 to Dec 2, 2027. Core requirements such as human oversight and bias monitoring are unchanged. — [Gibson Dunn](https://www.gibsondunn.com/eu-ai-act-omnibus-agreement-postponed-high-risk-deadlines-and-other-key-changes/), [CSA research note](https://labs.cloudsecurityalliance.org/research/csa-research-note-eu-ai-act-omnibus-vii-deadline-delay-20260/) (Official Journal publication not verified)
- NYC Local Law 144 requires an annual bias audit, a public summary and candidate notice for automated employment decision tools, with fines of $500–1,500 per day. A Dec 2, 2025 NY State Comptroller audit criticized DCWP enforcement. Secondary reports say DCWP found 1 issue in 32 audits where the Comptroller found 17+. — [NY OSC audit, Dec 2025](https://www.osc.ny.gov/state-agencies/audits/2025/12/02/enforcement-local-law-144-automated-employment-decision-tools)

### Inferences
- With 20+ years of experience: detail the last 10–15 years, compress older roles into a one-line "Earlier experience" entry (with or without dates), and drop graduation years. Keep month/year dates on the detailed roles, because parsers compute experience from them and gaps are penalized.
- A compressed early history may lower the computed "total years". That rarely matters, since requirements are usually "5+ years". Inferred, not measured.

### Gaps
- No study measures whether automated screeners penalize long total tenure or old graduation years directly. The *Mobley* allegations are not yet adjudicated.
