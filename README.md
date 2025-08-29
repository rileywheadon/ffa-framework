# FFA Framework Wiki

The **FFA Framework** is an open-source tool for flood frequency analysis (FFA) designed to support systematic and repeatable workflows for stationary and nonstationary analysis.
Development is ongoing at the University of Calgary and the University of Saskatchewan in Canada.

The most recent version of the framework is freely available as an [R package](https://CRAN.R-project.org/package=ffaframework).
The [original version](https://zenodo.org/records/8012096) was released as a standalone GUI with MATLAB source code and published in [Vidrio-Sahagún et al. (2024)](https://doi.org/10.1016/j.envsoft.2024.105940).
For a list of changes from the MATLAB version, see [here](https://rileywheadon.github.io/ffa-framework/articles/matlab-version.html).

## Installation Instructions

### From CRAN  (Recommended)

1. Ensure that [R](https://www.r-project.org/) (v4.4.0 or later) is installed on your machine.  

2. Open an R session by executing the `R` command in a terminal.

3. Run `install.packages("ffaframework")` from the R session.

4. Exit the R session with `q()`. The 'ffaframework' package is now installed and ready to use.

### Development Version

<span style="color: red;"><b>Warning</b>: The development version is updated frequently and may contain issues.</span>

1. Ensure that [Git](https://git-scm.com/) and [R](https://www.r-project.org/) (v4.4.0 or later) are installed on your machine.

2. Open a terminal and navigate to the directory where you want to install the package.

3. Clone the Github repository by executing the following command:

        git clone https://github.com/rileywheadon/ffa-framework.git

4. Open an `R` session. Then install and load the `devtools` package (if not already installed):

        install.packages("devtools")
        library(devtools)

5. Install the 'ffaframework' package:

        devtools::install("~/path/to/ffa-package")

    Replace `~/path/to/ffa-package` with the path to the cloned directory from step 2.

6. Exit the `R` session with `q()`. The 'ffaframework' package is now installed and ready to use.

### Troubleshooting FAQ

**How do I know if R is installed?**

You can check your R version by executing the `R --version` command in a terminal.

**I just installed R on Windows but the `R` command doesn't work.**

Windows users may need to add R to their `PATH` environment variable.
The default location for R is `C:\Program Files\R\R-4.5.0\bin` (replace "4.5.0" with the version of R you have installed).
To update the `PATH`, edit the system environment variables from the settings menu.


