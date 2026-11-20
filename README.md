# FFA Framework Wiki

The **FFA Framework** is an open-source tool for flood frequency analysis (FFA) designed to support systematic and repeatable workflows for stationary and nonstationary analysis.
Development is ongoing at the University of Calgary and the University of Saskatchewan in Canada.

The most recent version of the framework is freely available as an [R package](https://CRAN.R-project.org/package=ffaframework).
The [original version](https://zenodo.org/records/8012096) was released as a standalone GUI with MATLAB source code and published in [Vidrio-Sahagún et al. (2024)](https://doi.org/10.1016/j.envsoft.2024.105940).
For a list of changes from the MATLAB version, see [here](https://rileywheadon.github.io/ffa-framework/articles/matlab-version.html).

## Installation Instructions

### From CRAN (Recommended)

1. Ensure that [R](https://www.r-project.org/) (v4.4.0 or later) is installed on your machine.

2. Open an R session by executing the `R` command in a terminal.

3. Run `install.packages("ffaframework")` from the R session.

4. Exit the R session with `q()`. The 'ffaframework' package is now installed and ready to use.

### Development Version

<span style="color: red;"><b>Warning</b>: The development version is updated frequently and may contain issues.</span>

1.  Ensure that [Git](https://git-scm.com/) and [R](https://www.r-project.org/) (v4.4.0 or later) are installed on your machine.

2.  Open a terminal and navigate to the directory where you want to install the package.

3.  Clone the Github repository by executing the following command:

        git clone https://github.com/rileywheadon/ffa-framework.git

4.  Open an `R` session. Then install and load the `devtools` package (if not already installed):

        install.packages("devtools")
        library(devtools)

5.  Install the 'ffaframework' package:

        devtools::install("~/path/to/ffa-package")

    Replace `~/path/to/ffa-package` with the path to the cloned directory from step 2.

6.  Exit the `R` session with `q()`. The 'ffaframework' package is now installed and ready to use.

### Troubleshooting FAQ

**How do I know if R is installed?**

You can check your R version by executing the `R --version` command in a terminal.

**I just installed R on Windows but the `R` command doesn't work.**

Windows users may need to add R to their `PATH` environment variable.
The default location for R is `C:\Program Files\R\R-4.5.0\bin` (replace "4.5.0" with the version of R you have installed).
To update the `PATH`, edit the system environment variables from the settings menu.

## Contributor Documentation

### Development Environment

1.  Clone the GitHub repository by running the following command:

        git clone https://github.com/rileywheadon/ffa-framework.git

2.  Ensure that `renv` is installed on your machine

3.  Ensure that the version of R listed in `renv.lock` is installed on your machine

4.  Open a new `R` session and run `renv::restore()`

### Commonly Used Commands

```R
# Test
devtools::test()

# Check
devtools::check()

# Document
devtools::document()

# Update dependencies
renv::snapshot()
```

## Release Documentation

This section describes the steps required to release a new version of the ffaframework package.

### 1. Documentation

Run the following command to regenerate documentation then commit any changes.

```R
devtools::document()
```

### 2. Version Bump

The `ffaframework` package makes a best effort to adhere to [semantic versioning](https://semver.org/).

This means that:

- MAJOR version changes (e.g. 1.0.0 to 2.0.0) indicate breaking changes
- MINOR version changes (e.g. 1.0.0 to 1.1.0) indicate backwards compatible new functionality
- PATCH version changes (e.g. 1.0.0 to 1.0.1) indicate backwards compatible bug fixes

After deciding on an appropriate version bump, create a new commit titled "version X.Y.Z".

This commit should do the following:

1. Update `NEWS.md` to contain release notes for the new version
2. Bump the version number in the `DESCRIPTION` file

### 3. Pre-Release Checks

Ensure that all jobs in the GitHub Actions R-CMD-check workflow pass successfully for the release commit.
Resolve all errors and warnings, and investigate any notes before proceeding. If changes are required, commit them and rerun the workflow.

### 4. Submit to CRAN

Run the following R command to create a `cran-comments.md` file:

```R
usethis::use_cran_comments()
```

Then, fill `cran-comments.md` with the following template:

```markdown
## Test environments

- Platform: (...)
- R version: (...)

## R CMD check results

(...) errors | (...) warnings | (...) notes

## Reverse dependencies

(...)
```

Use the following command to check for reverse dependencies:

```R
tools::package_dependencies(
    "ffaframework",
    db = available.packages(),
    reverse = TRUE,
    recursive = FALSE
)
```

Finally, run `devtools::submit_cran()` to submit the new package version.

The maintainer must confirm the submission by clicking the link in the email from CRAN.

### 5. Create GitHub Tag and Release

Do not complete this step until after the new package version has been accepted by CRAN.

Run the following set of commands to create a Git tag for the version:

```bash
git tag -a "$VERSION" "$COMMIT_HASH" -m "Release $VERSION"
git push origin "$VERSION"
```

In the GitHub UI, create a new release for the tag. Copy the release notes from `NEWS.md`.
