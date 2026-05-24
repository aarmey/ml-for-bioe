# BIOENGR 175: Machine Learning & Data-Driven Modeling in Bioengineering

This repository contains the course materials, lecture slides, notes, and website for **BIOENGR 175 / 275** (*Machine learning & data-driven modeling in bioengineering*). The materials are authored in Quarto markdown and served via a Hugo-based website.

---

## Repository Structure

Below is an overview of the key directories and files in this repository:

*   **[`lectures/`](file:///Users/asm/Code/ml-for-bioe/lectures)**: Quarto Markdown files (`.qmd`) containing the course lecture content.
    *   **[`figs/`](file:///Users/asm/Code/ml-for-bioe/lectures/figs)**: Contains lecture-specific figures, organized by topic.
    *   **`clean.scss` & `notes.scss`**: SCSS stylesheets defining themes for the slides (RevealJS) and PDF notes (Typst).
    *   **[`filters/`](file:///Users/asm/Code/ml-for-bioe/lectures/filters)**: Lua filters for custom Quarto processing (e.g., [`notes.lua`](file:///Users/asm/Code/ml-for-bioe/lectures/filters/notes.lua) formatting).
*   **[`site/`](file:///Users/asm/Code/ml-for-bioe/site)**: The source code for the class website built using Hugo.
    *   **[`content/`](file:///Users/asm/Code/ml-for-bioe/site/content)**: Markdown files (`.md`) representing course web pages (such as outlines, guidelines, packages).
    *   **[`content/examples/`](file:///Users/asm/Code/ml-for-bioe/site/content/examples)**: Hands-on code examples in Quarto (`.qmd`) format.
    *   **`hugo.toml`**: Hugo configuration file.
*   **`notes/`**: Target directory where local PDF lecture notes (using the Typst engine) are compiled.
*   **[`makefile`](file:///Users/asm/Code/ml-for-bioe/makefile)**: Orchestrates the compilation of slides, notes, notebooks, and website assets.
*   **[`pyproject.toml`](file:///Users/asm/Code/ml-for-bioe/pyproject.toml)** & **`uv.lock`**: Python dependency and environment definition managed via [Astral uv](https://github.com/astral-sh/uv).
*   **[`.github/workflows/build.yml`](file:///Users/asm/Code/ml-for-bioe/.github/workflows/build.yml)**: CI/CD configuration for automatically building and deploying the site to GitHub Pages.

---

## Getting Started & Local Setup

### Prerequisites
Make sure you have the following installed on your system:
1. **[Quarto CLI](https://quarto.org/)** (v1.9+)
2. **[Hugo](https://gohugo.io/)** (Extended version recommended)
3. **[uv](https://github.com/astral-sh/uv)** (for fast Python package and virtual environment management)

### Setting Up Python Dependencies
The python dependencies (such as `scikit-learn`, `numpy`, `scipy`, `matplotlib`, and `ipykernel` for Quarto execution) are managed by `uv`. 

To set up the virtual environment:
```bash
make .venv
```
This runs `uv sync` behind the scenes and configures a `.venv` directory containing the correct Python environment.

---

## How to Make Changes & Build

All build tasks are managed via the [`makefile`](file:///Users/asm/Code/ml-for-bioe/makefile). When you modify source files, run the appropriate `make` target.

| Target | Description |
|---|---|
| `make` (or `make all`) | Runs `notes`, `pubnotes`, and `slides` targets to build all formats. |
| `make notes` | Renders lectures to Typst format (with instructor notes enabled) and outputs them to the `notes/` directory. |
| `make pubnotes` | Renders lectures to HTML format and outputs them to `site/public/notes/`. |
| `make slides` | Renders lectures to RevealJS slides and outputs them to `site/public/lectures/`. |
| `make <lecture_name>` | Builds all three formats (Typst PDF, HTML notes, and RevealJS slides) for a specific lecture (e.g. `make lecture1`). |
| `make convert` | Converts Quarto example scripts in `site/content/examples/` to Jupyter Notebooks (`.ipynb`). |
| `make render` | Renders Quarto example scripts to HTML under `site/content/examples/`. |
| `make clean` | Cleans up the workspace by removing compiled notes, the built Hugo public site, intermediate example files, and the local `.venv`. |

---

## Editing Guidelines

### 1. Updating Lecture Content
*   Edit/add `.qmd` files in the `lectures/` directory.
*   To include speaker/instructor notes that are only rendered in the printed notes PDF (and hidden/customized on slides), wrap them in a `.notes` block:
    ```markdown
    ::: {.notes}
    Keep in mind to emphasize the difference between L1 and L2 regularization here.
    :::
    ```
*   Run `make <lecture_name>` to compile your changes for the specific lecture.

### 2. Modifying Website Pages
*   Static pages (e.g., Course outlines, Project guidelines, Midterms) are located in [`site/content/`](file:///Users/asm/Code/ml-for-bioe/site/content).
*   Edit the markdown (`.md`) files in that directory.
*   Menu structures are defined in [`site/hugo.toml`](file:///Users/asm/Code/ml-for-bioe/site/hugo.toml) under `[Menus]`.

### 3. Adding Code Examples
*   Code examples are placed in [`site/content/examples/`](file:///Users/asm/Code/ml-for-bioe/site/content/examples) as Quarto markdown (`.qmd`) files.
*   Adding/modifying them will auto-convert them into Jupyter Notebooks (`.ipynb`) and render them to HTML when `make convert` and `make render` are run.

---

## Deployment (CI/CD)

The project uses GitHub Actions to automate deployment. Upon pushing any changes to the `main` (or `master`) branch:
1. The **[Build Workflow](file:///Users/asm/Code/ml-for-bioe/.github/workflows/build.yml)** initiates.
2. It installs `uv`, configures Quarto, compiles all slides/handouts/notebooks, builds the static Hugo site, and copies rendered example files to the site.
3. The final public directory (`site/public`) is deployed to GitHub Pages at: [https://aarmey.github.io/ml-for-bioe/](https://aarmey.github.io/ml-for-bioe/).
