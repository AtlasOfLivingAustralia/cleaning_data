# Documentation

## A summary

-   This book is intended to be reproducible where possible. It lives at <https://cleaning-data-r.ala.org.au/>, which displays the rendered version of the book on the `gh-pages` branch
-   To make this book reproducible, we've used data DOIs to preserve results of data queries. This allows users to download original data so they can reproduce examples in the book exactly. To update data in the book, you will have to use a specific script to re-download data, generate new DOIs, and save them so they can be used in the book.

## Updating the published version of the website

### Version number

Before updating the book, it's important to document changes in a new [Release](https://github.com/AtlasOfLivingAustralia/cleaning_data/releases). The latest release number is web-scraped and used to build the updated citation displayed on the Welcome page of the book.

So you should always *add a new release, then publish the new version of the book*. This will ensure the citation updates correctly.

### Publish

The rendered version of the book that appears on <https://cleaning-data-r.ala.org.au/> is on the `gh-pages` branch in the `_site` folder. This version is updated separately to what is on the main branch.

We use the Publish command to update the published version of the book. The original process to set this up is documented [here](https://quarto.org/docs/publishing/github-pages.html#publish-command).

To update the website, run in the Terminal:

```         
quarto publish gh-pages
```

This will render the book and publish the new version from the `gh-pages` branch to the live website.

At the moment, sometimes `publish` pushes changes to a GH url, rather than https://cleaning-data-r.ala.org.au/. After running `quarto publish` be sure to double check that the custom domain in [Settings](https://github.com/AtlasOfLivingAustralia/cleaning_data/settings/pages) is still set to cleaning-data-r.ala.org.au

Update 2025-09: Matt Andrews added a `CNAME` file to the `gh-pages` branch that should fix publishing to cleaning-data-r.ala.org.au url. Ensure that this file exists in the `gh-pages` top directory to avoid publishing issues.

## Updating data & DOIs

Run the code in `/scripts/1_generate-doi.R` to rerun all galah queries in the Prerequisite sections of each chapter and regenerate DOIs for these newly run queries. This will save each of the results under a specific DOI (using `galah::atlas_occurrences(mint_doi = TRUE)`). These DOIs can then be used by galah to retrieve these exact results again.

Updated data DOIs are stored in `/data/galah-dois/doi_table`. Each Prerequisite section will use this table to retrieve the desired DOIs necessary for the chapter.

Note that if you update `/data/pardalotes.csv` file, be nice to others and store the most recent version on the Science & Decision Support Teams folder in `/Data/data-cleaning-book/data/`

## Not updating data?

If you want to render the book but aren't updating data, you'll need to make sure you have a few data files on your system first. These files are either too large to include on the repository (and therefore on .gitignore) or generated in the data/DOI generating process.

The two main files are:

-   `/data/rasters/aggregated_bioclim.tif`

-   `/data/pardalotes.csv`

You can find the most recent version of these files here:

<https://csiroau.sharepoint.com/:f:/r/sites/AtlasofLivingAustraliaTeams/Shared%20Documents/Teams/Science%20and%20Decision%20Support/Data/data-cleaning-book/data?csf=1&web=1&e=xxybs4>
