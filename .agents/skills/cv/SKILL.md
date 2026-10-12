---
name: cv
description: Workflows for developing and generating CVs using the unified multi-class architecture (AltaCV and DeveloperCV) with Dockerized MiKTeX.
---

# Unified Multi-Class CV Framework

This project maintains a unified curriculum vitae compiled into two alternate LaTeX design classes (**AltaCV** and **DeveloperCV**) across two languages (**English** and **German**). The system completely decouples semantic content from visual presentation through a modular adapter layer.

---

## Architecture Overview

```
cv/
├── common/
│   └── cv-interface.sty               # Core semantic macros & fallback definitions
├── content/
│   ├── en/                            # English content (single source of truth)
│   │   ├── personal_info.tex          # Candidate metadata & contact links
│   │   ├── about_me.tex               # Professional summary
│   │   ├── skills.tex                 # Tech stack and learning tags
│   │   ├── languages.tex              # Language proficiencies
│   │   ├── education.tex              # Degrees and academic credentials
│   │   └── experience/                # Job roles (\cvexperience)
│   └── de/                            # German content (single source of truth)
│       └── ...
├── layouts/
│   ├── altacv/
│   │   ├── altacv-adapter.sty         # AltaCV visual adapter
│   │   ├── main_en.tex                # AltaCV English driver
│   │   └── main_de.tex                # AltaCV German driver
│   └── developercv/
│       ├── developercv-adapter.sty    # DeveloperCV visual adapter
│       ├── main_en.tex                # DeveloperCV English driver
│       └── main_de.tex                # DeveloperCV German driver
├── altacv.cls                         # AltaCV class file
├── developercv.cls                    # DeveloperCV class file
└── Makefile                           # Docker-driven compilation targets
```

---

## Build Commands

Compilation runs inside the `zacsek/miktex` Docker container with automatic dependency resolution (`-enable-installer`).

| Command | Description | Output Files |
| :--- | :--- | :--- |
| `make all` | Builds all 4 CV variants | `Zoltan_Szocs_CV.altacv.{en,de}.pdf`, `Zoltan_Szocs_CV.developercv.{en,de}.pdf` |
| `make altacv` | Builds AltaCV (EN + DE) | `Zoltan_Szocs_CV.altacv.en.pdf`, `Zoltan_Szocs_CV.altacv.de.pdf` |
| `make devcv` | Builds DeveloperCV (EN + DE) | `Zoltan_Szocs_CV.developercv.en.pdf`, `Zoltan_Szocs_CV.developercv.de.pdf` |
| `make en` | Builds English versions for both styles | `Zoltan_Szocs_CV.altacv.en.pdf`, `Zoltan_Szocs_CV.developercv.en.pdf` |
| `make de` | Builds German versions for both styles | `Zoltan_Szocs_CV.altacv.de.pdf`, `Zoltan_Szocs_CV.developercv.de.pdf` |
| `make clean` | Removes `output/` directory and generated PDFs | — |

*Note: For backward compatibility, `make altacv-en` also updates `Zoltan_Szocs_CV.en.pdf`, and `make altacv-de` updates `Zoltan_Szocs_CV.de.pdf`.*

---

## Content Authoring Guide

Edit or add files in `content/en/` and `content/de/`. Changes automatically reflect in both AltaCV and DeveloperCV.

### 1. Adding or Editing a Work Experience
Experiences use the `\cvexperience` semantic macro:

```latex
\cvexperience
  {Role / Job Title}
  {Company / Organization}
  {Date Range, e.g., 2021 -- current}
  {Location, e.g., Ludwigsburg, Germany}
  {Technologies, e.g., Java, Kotlin, PostgreSQL}
  {%
    \item First accomplishment or responsibility.
    \item Second accomplishment or responsibility.
  }
```

Include the file in the layout drivers (`layouts/altacv/main_<lang>.tex` and `layouts/developercv/main_<lang>.tex`):
```latex
\input{content/en/experience/<filename>}
```

### 2. Updating Skills
Skills are grouped semantically with `\cvskillgroup{Category}{Comma, Separated, Tags}`:

```latex
\cvskillgroup{TECH STACK}{Rails, Ruby, Kotlin, Java, Docker, Git}
\cvskillgroup{Learning}{Rust, ML/AI, AWS, Kubernetes}
```

### 3. Updating Languages
Languages use `\cvlanguage{Language}{Proficiency}`:

```latex
\cvlanguage{English}{Advanced / C1}
\cvlanguage{German}{Advanced / C1}
```

### 4. Updating Education
Degrees use `\cveducation{Degree}{University}{Dates}{Location}{Optional Details}`:

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

To adapt a new document class (e.g., `moderncv` or `awesome-cv`):

1. **Place the class file** (e.g., `moderncv.cls`) in the project root if not already provided by TeX Live / MiKTeX.
2. **Create a layout directory**: `layouts/<classname>/`.
3. **Implement the adapter**: `layouts/<classname>/<classname>-adapter.sty`:
   - Require `common/cv-interface`.
   - Implement `\cvexperience`, `\cveducation`, `\cvskillgroup`, `\cvlanguage`, `\cvprofile`, and `\renderheader` mapped to the new class's primitives.
4. **Create layout drivers**: `layouts/<classname>/main_en.tex` and `main_de.tex`.
5. **Add targets to `Makefile`**:
   ```makefile
   <classname>: <classname>-en <classname>-de
   ```

---

## Docker Image Maintenance (`miktex-docker`)

If compilation fails due to a missing LaTeX package:
1. Navigate to the related repository: `/home/zacsek/Projects/_github/miktex-docker`.
2. Add the required package name to `packages.txt` (e.g. `l3backend`).
3. Rebuild the image:
   ```bash
   make build
   ```
4. Return to the CV project and run `make all`.
