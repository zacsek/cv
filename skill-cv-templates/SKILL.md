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

### Handling Build Failures

If a CV compilation fails due to missing LaTeX packages:
1. Navigate into the `miktex-docker` submodule (`cd miktex-docker`).
2. Add the missing package name to `packages.txt`.
3. Run `make build` inside the submodule to rebuild the Docker image with the new package.
4. Return to this repository and rerun your compile command.

## Troubleshooting AltaCV

- **Fonts Not Found:** AltaCV requires `Roboto Slab` and `Lato`. Ensure these are available if modifying the font setup.
- **Icon Rendering:** Ensure `fontawesome5` is installed.
- **Column Breaks:** Use `\newpage` within a `paracol` column to force a break only for that column. Use `\switchcolumn` to move between columns.
- **Overfull Boxes:** If `cvtags` overlap, wrap them in a `sloppypar*` environment as defined in modern AltaCV forks.
