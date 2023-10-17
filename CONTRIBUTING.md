# Contributing

This outlines how to propose a change to dplyr. For more detailed info about contributing to this, and other tidyverse packages, please see the development contributing guide.

Fixing typos
Small typos or grammatical errors in documentation may be edited directly using the GitHub web interface, so long as the changes are made in the source file.

YES: you edit a roxygen comment in a .R file below R/.
NO: you edit an .Rd file below man/.
Prerequisites
Before you make a substantial pull request, you should always file an issue and make sure someone from the team agrees that it’s a problem. If you’ve found a bug, create an associated issue and illustrate the bug with a minimal reprex.

Pull request process
We recommend that you create a Git branch for each pull request (PR).
Look at the Travis and AppVeyor build status before and after making changes. The README should contain badges for any continuous integration services used by the package.
New code should follow the tidyverse style guide. You can use the styler package to apply these styles, but please don’t restyle code that has nothing to do with your PR.
We use roxygen2, with Markdown syntax, for documentation.
We use testthat. Contributions with test cases included are easier to accept.
For user-facing changes, add a bullet to the top of NEWS.md below the current development version header describing the changes made followed by your GitHub username, and links to relevant issue(s)/PR(s).
Code of Conduct
Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms.

See tidyverse development contributing guide for further details
