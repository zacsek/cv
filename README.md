# Unified Multi-Class CV Framework

A modular, multi-class LaTeX CV build system compiling a single semantic source of truth into three distinct visual design styles: **AltaCV**, **DeveloperCV**, and **Awesome-CV**, in both **English** and **German**.

---

## Highlights

- **Single Source of Truth:** Update experience, tech stack, education, or contact details in one place (`content/en/` or `content/de/`); changes propagate across all layouts automatically.
- **Triple Visual Styles:**
  - **AltaCV:** Classic two-column infographic layout with fontawesome icons, skill tag clouds, and dashed dividers.
  - **DeveloperCV:** Modern developer-focused layout with a left-margin date track, bold headings, and TikZ skill pills.
  - **Awesome-CV:** Silicon Valley tech resume style with a sleek header, clean horizontal rules, and metadata-aligned experience blocks (compiled via XeLaTeX).
- **Clean Content / Layout Separation:** All content files use pure semantic LaTeX macros with zero presentation markup. Visual rendering is managed by class-specific adapter packages.
- **Dockerized Build System:** Fully automated compilation using a local MiKTeX Docker container (`zacsek/miktex`) with automatic package installation enabled (`-enable-installer`).

---

## Architecture

```
cv/
├── common/
│   └── cv-interface.sty               # Semantic macros (\cvexperience, \cveducation, \renderheader, etc.)
├── content/
│   ├── en/                            # English content (single source of truth)
│   │   ├── personal_info.tex          # Contact info, links, and candidate metadata
│   │   ├── about_me.tex               # Summary narrative
│   │   ├── skills.tex                 # Tech stack and learning tags
│   │   ├── languages.tex              # Language proficiencies
│   │   ├── education.tex              # Degree details
│   │   └── experience/                # Chronological job roles
│   │       ├── 2021_wolters_kluwer.tex
│   │       ├── 2015_daimler_kpit.tex
│   │       ├── 2014_citi.tex
│   │       ├── 2011_logmein.tex
│   │       ├── 2007_intellio.tex
│   │       ├── 2006_nokia.tex
│   │       └── 2004_neogen.tex
│   └── de/                            # German content (single source of truth)
│       └── ...
├── layouts/
│   ├── altacv/
│   │   ├── altacv-adapter.sty         # AltaCV visual adapter
│   │   ├── main_en.tex                # AltaCV English driver
│   │   └── main_de.tex                # AltaCV German driver
│   ├── developercv/
│   │   ├── developercv-adapter.sty    # DeveloperCV visual adapter
│   │   ├── main_en.tex                # DeveloperCV English driver
│   │   └── main_de.tex                # DeveloperCV German driver
│   └── awesomecv/
│       ├── awesomecv-adapter.sty      # Awesome-CV visual adapter
│       ├── main_en.tex                # Awesome-CV English driver
│       └── main_de.tex                # Awesome-CV German driver
├── altacv.cls                         # AltaCV LaTeX class
├── developercv.cls                    # DeveloperCV LaTeX class
├── awesome-cv.cls                     # Awesome-CV LaTeX class
├── Makefile                           # Build orchestration
└── output/                            # Transient compiler logs and auxiliary files
```

---

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed and running.
- Local `zacsek/miktex` Docker image. (Build script available in the sibling repository `../miktex-docker`).
- `make` utility.

---

## Build Commands

Compile CVs by running `make` targets from the project root:

| Command | Description | Output Files |
| :--- | :--- | :--- |
| `make all` | Builds all 6 CV variants | All 6 PDFs listed below |
| `make altacv` | Builds both AltaCV variants (EN + DE) | `Zoltan_Szocs_CV.altacv.en.pdf`<br>`Zoltan_Szocs_CV.altacv.de.pdf` |
| `make devcv` | Builds both DeveloperCV variants (EN + DE) | `Zoltan_Szocs_CV.developercv.en.pdf`<br>`Zoltan_Szocs_CV.developercv.de.pdf` |
| `make awesomecv` | Builds both Awesome-CV variants (EN + DE) | `Zoltan_Szocs_CV.awesomecv.en.pdf`<br>`Zoltan_Szocs_CV.awesomecv.de.pdf` |
| `make en` | Builds English versions for all 3 styles | `Zoltan_Szocs_CV.altacv.en.pdf`<br>`Zoltan_Szocs_CV.developercv.en.pdf`<br>`Zoltan_Szocs_CV.awesomecv.en.pdf` |
| `make de` | Builds German versions for all 3 styles | `Zoltan_Szocs_CV.altacv.de.pdf`<br>`Zoltan_Szocs_CV.developercv.de.pdf`<br>`Zoltan_Szocs_CV.awesomecv.de.pdf` |
| `make altacv-en` | Builds English AltaCV | `Zoltan_Szocs_CV.altacv.en.pdf` *(copies `Zoltan_Szocs_CV.en.pdf`)* |
| `make altacv-de` | Builds German AltaCV | `Zoltan_Szocs_CV.altacv.de.pdf` *(copies `Zoltan_Szocs_CV.de.pdf`)* |
| `make devcv-en` | Builds English DeveloperCV | `Zoltan_Szocs_CV.developercv.en.pdf` *(copies `Zoltan_Szocs_CV.devCv.pdf`)* |
| `make devcv-de` | Builds German DeveloperCV | `Zoltan_Szocs_CV.developercv.de.pdf` |
| `make awesomecv-en` | Builds English Awesome-CV | `Zoltan_Szocs_CV.awesomecv.en.pdf` |
| `make awesomecv-de` | Builds German Awesome-CV | `Zoltan_Szocs_CV.awesomecv.de.pdf` |
| `make clean` | Deletes build artifacts in `output/` and root PDFs | — |

---

## Content Authoring Guide

Content files live exclusively in `content/en/` and `content/de/`. To update your CV, edit these files directly without touching layout or styling code.

### 1. Work Experience (`content/<lang>/experience/<role>.tex`)

Job entries use the semantic macro `\cvexperience`:

```latex
\cvexperience
  {Job Title / Role}
  {Company Name}
  {Date Range, e.g., 2021 -- current}
  {Location, e.g., Ludwigsburg, Germany}
  {Tech Stack, e.g., Java, Kotlin, PostgreSQL}
  {%
    \item First accomplishment or responsibility.
    \item Second accomplishment or responsibility.
  }
```

To add a new position:
1. Create a new `.tex` file in `content/en/experience/` and `content/de/experience/`.
2. Add `\input{content/<lang>/experience/<file>}` to the appropriate page/column in:
   - `layouts/altacv/main_<lang>.tex`
   - `layouts/developercv/main_<lang>.tex`

### 2. Personal Info & Header (`content/<lang>/personal_info.tex`)

Candidate metadata is declared via setters:

```latex
\cvname{Zoltán Szőcs}
\cvtagline{Sr. Software Engineer}
\cvphoto{zoltan_portrait_sq}
\cvemail{zacsek@gmail.com}
\cvphone{+49-157-58094107}
\cvlocation{Esslingen am Neckar, Germany}
\cvlinkedin{zoltan-szocs}
\cvgithub{zacsek}
```

The header is rendered automatically by the layout adapter using `\renderheader`.

### 3. Skills & Tech Stack (`content/<lang>/skills.tex`)

Skills are grouped by category using `\cvskillgroup{Category}{Tags}`:

```latex
\cvskillgroup{TECH STACK}{Rails, Ruby, Kotlin, Java, Ansible, PostgreSQL, MySQL, Linux, Docker, Git, RabbitMQ, Sidekiq}

% Optional / commented sections:
%\cvskillgroup{Learning}{Rust, ML/AI, AWS, Kubernetes, Terraform}
```

### 4. Languages (`content/<lang>/languages.tex`)

Languages use `\cvlanguage{Language}{Proficiency}`:

```latex
\cvlanguage{English}{Advanced / C1}
\cvlanguage{German}{Advanced / C1}
```

### 5. Education (`content/<lang>/education.tex`)

Academic qualifications use `\cveducation`:

```latex
\cveducation
  {Master of Science (MSc) in Automation Engineering}
  {Petru Maior University}
  {2000 -- 2005}
  {Targu Mures, Romania}
  {}
```

---

## Adding a New LaTeX CV Class

The architecture makes it straightforward to add a third CV design (e.g., `moderncv`, `awesome-cv`):

1. **Class File:** Place `<newclass>.cls` in the project root if it is not already provided by TeX distribution packages.
2. **Layout Directory:** Create `layouts/<newclass>/`.
3. **Adapter Package:** Create `layouts/<newclass>/<newclass>-adapter.sty`:
   - Include `\RequirePackage{common/cv-interface}`.
   - Implement or override `\cvexperience`, `\cveducation`, `\cvskillgroup`, `\cvlanguage`, `\cvprofile`, and `\renderheader` to map to the new class's primitives.
4. **Drivers:** Create `layouts/<newclass>/main_en.tex` and `main_de.tex` to input the content files in your preferred column or section ordering.
5. **Makefile Target:** Add the new build target to `Makefile`:
   ```makefile
   <newclass>-en: $(COMMON_FILES) $(CONTENT_EN) $(NEW_LAYOUT)
   	mkdir -p $(OUTPUT_DIR)
   	$(DOCKER_RUN) -output-directory=$(OUTPUT_DIR) -jobname=<newclass>_en layouts/<newclass>/main_en.tex
   	cp $(OUTPUT_DIR)/<newclass>_en.pdf Zoltan_Szocs_CV.<newclass>.en.pdf
   ```

---

## Docker Environment & Package Troubleshooting

Builds run inside a containerized MiKTeX installation. The build runner passes `-enable-installer` so MiKTeX can automatically download missing `.sty` or `.def` files on demand during compilation.

If a package should be pre-installed permanently into the Docker image:
1. Open the sibling repository: `/home/zacsek/Projects/_github/miktex-docker`.
2. Add the package name to `packages.txt` (e.g., `l3backend`).
3. Rebuild the Docker image:
   ```bash
   cd ../miktex-docker && make build
   ```
4. Re-run `make all` in this repository.
