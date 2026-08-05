# Introduction

This is my CV project. It will maintain two versions of my CV.
# Roadmap

[x] Insert .tex files
[x] Install dependencies to build pdf from tex
[x] Automate pdf generation
[x] Make it an action.yml that builds on push

# Building local
## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (running and accessible from your shell)
- Bash (macOS/Linux, or Git Bash/WSL on Windows)

No local LaTeX installation is required — `build.sh` runs the build inside the
`texlive/texlive:latest` Docker image, which Docker will pull automatically on
first use.

## Building the CV (Linux only)

Run the build script from the repository root:

```bash
./build.sh
```

This builds the German CV (`src/simple/simpleCV.tex`) by default and writes
the resulting PDF to `target_simple/simpleCV_de.pdf`.

To build the English CV instead, set `CV_LANG=en`:

```bash
CV_LANG=en ./build.sh
```

This writes `target_simple/simpleCV_en.pdf`.


# Continuous Integration

Every push and pull request to `main` runs
[`.github/workflows/build.yml`](.github/workflows/build.yml), which builds
both the German and English PDFs on a Linux runner and uploads them as a
`cv-pdfs` workflow artifact (see the run's **Summary** page to download it).
You can also trigger it manually from the **Actions** tab
(`workflow_dispatch`).


