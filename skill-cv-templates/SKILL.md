---
name: cv-templates
description: Workflows for generating CVs using AltaCV and DeveloperCV LaTeX templates. Use for compiling LaTeX CVs, fixing layout issues, or modifying the English, German, or Developer variants.
---

# CV Templates Manager

This skill provides specialized workflows for developing and compiling CVs based on AltaCV and DeveloperCV, using the reproducible MiKTeX Docker container.

## Workflows

### Compiling Your CVs

To compile the CV versions, use the provided `Makefile`:

- Compile all CVs:
  ```bash
  make all
  ```
- Compile English CV (AltaCV):
  ```bash
  make en
  ```
- Compile German CV (AltaCV):
  ```bash
  make de
  ```
- Compile Developer CV (DeveloperCV):
  ```bash
  make dev
  ```

## Troubleshooting AltaCV

- **Fonts Not Found:** AltaCV requires `Roboto Slab` and `Lato`. Ensure these are available if modifying the font setup.
- **Icon Rendering:** Ensure `fontawesome5` is installed.
- **Column Breaks:** Use `\newpage` within a `paracol` column to force a break only for that column. Use `\switchcolumn` to move between columns.
- **Overfull Boxes:** If `cvtags` overlap, wrap them in a `sloppypar*` environment as defined in modern AltaCV forks.
