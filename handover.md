# Handover notes

## General

- Issue: Loading packages
  - Existing behaviour: All/many packages loaded at once, at the start of a doc, sometimes hidden (include = FALSE)
    - User: Obscures package purposes
    - User: Difficult to identify function sources (i.e. user wants to use a
    particular code chunk but has to guess or search which packages to library)
  - Solution: Load packages as they are needed, and all package libraries should be visible
  - Progress: Unfinished, changes in progress

- Todo:
  - github pages deploys when changes are pushed to `restructuring` branch
    - joe lipson set this for me because it requires owner level privileges
    - could change it to look for changes on main
    - note its just for internal use
    - it builds from the `docs` folder hence `output-dir: docs` in the quarto yaml

- Next steps
  - Start here * [link](./cleaning_taxonomy.qmd) reading the comment at the top of page

## Comments

I used a script to gather all html comments in .qmd files, new and existing
comments. For keeping track of loose ends etc

- [access_download](./access_download.qmd)
  - I feel like there should be at least a some code demonstrating basic download
  with a couple of the other mentioned packages, like spocc, and then moving on to
  galah specific. Thoughts?
  - Changes: This section had a confusing structure to me, so I've changed it to
  reflect how I think it should flow but its still a work in progress. Before, the
  first chunk of code that demonstrated downloading data was closely tied to
  taxonomy and naming discrepancies, which I think it's a bit much going on for a
  first demonstration of downloading. I think an inverted pyramid appraoch should
  be followed here (and in general across the book) - start with simple downloads,
  and then building up to more complex queries from there. Following the
  fundamentals, thats when I think you can show the examples that relate to or
  showcase more specific issues (e.g. taxonomic name variation etc, like the
  orchid example), can go. This makes the more basic instructions and code
  demonstrations clearer and also easier to find and use, as a quick reference,
  and for cross references, rather than having only complex examples or examples
  that showcase more than one concept or functionality, which can be harder to
  index and cross reference.
  - Andrew: what does this mean, needs some context
  - Andrew: I got the message "new names", telling me to use scientificName...4
  and ...9? From the download query? No idea what that is about, but had to change
  the code below from scientificName and raw scientific name to those names, or it
  wouldn't run for me
  - Fonti notes:
  - Work in progess
  - Narrowing your results to a specific spatial area- using `galah_geolocate`
  or by regions etc, discussions around whether this is best to be placed in this
  chapter to assist with expaning scope has been raised.  
  - Read in shpfile, transform to polygon
  - Explain:  
  - Assertions are logical flags, TRUE is presence of issue denoted in column name
  - User to choose which ones are relevant to their project and filter in query
  - For exclusions using multiple assertions (Currently throws errors, need to think carefully about != means for logical assertions...)

- [access_inspect](./access_inspect.qmd)
  - Notes/Andrew: The previous content of this page largely included fixing string
inconsistencies. It's my opinion that this was out of scope for an
initial inspection step, and best moved to a dedicated string section. Otherwise
it would be difficult for somebody looking for string inconsistencies to know
they need to check the initial inspection page.
  - Notes/Andrew: The scope of this page is now: determine if the downloaded
data is acceptable, with respect to the download query and source. If not, the
next actions could be to adjust the download query, or use a different source.

- [access_taxonomy](./access_taxonomy.qmd)
  - Note from Dax here! I think putting too much detail here will be very offputting, but knowing about naming authorities and being aware that it's something you need to check is important to speak about at this point in the book. I think it might be best to vaguely explain what a naming authority is, and that there are many of them because taxonomy is hard. Then extra information can be placed in an appendix at the end of the chapter? Or at the end of the book? At the moment, I've pasted what I think is excess information at the bottom of the chapter.
  - Main point: It's worth being aware of what naming authority your taxonomic backbone uses. In some taxonomic groups, these can vary widely. Double checking your data after your download to make sure the classifications you expect are what you have will help prevent errors later on. Otherwise, you can re-code data with incorrect classification manually.
  - Notes/Andrew: Strong agree with above, I think any advice specific to
taxonomy, choosing an authority etc should be avoided and I've added this
content to reflect that.
  - Dax comments:
  - Might be worth showing how in an appendix
  - Andrew: Migrated this from downloads. Haven't reflowed it for this section
  - Dec/2020 - RE: Image / table for ALA naming authorities
  - Dax note: I think that this information should be put in a simpler table and maybe just link out to all of the authority websites. It's just so much information in one graphic, so I think adding links would be a easy compromise?
  - Notes/Andrew: Agree, I don't like the image and its not even really relevant. Removing it.

- [cleaning_duplicates](./cleaning_duplicates.qmd)
  - Read below but on second thoughts this could go with the standardisation
page. Idea being just to have a straightforward reference pages of these key
steps
  - Notes/Andrew: This stuff is covered in various parts of the book of course its pretty
common but i thought it would be good to have a kind of straight forward
reference on these concepts. Like checking for missingness in different ways to
more complex cases perhaps like i have a these X amount of records and these
ones have missing something and these ones have missing something else so how
can i decide what to drop, in these specific contexts. I think it would be good
for cases  where you have limited records and you can't afford to just drop
evertying maybe. I don't know.

- [cleaning_geospatial](./cleaning_geospatial.qmd)
  - Notes/Andrew: This has nothing to do with precision, this looks like
spatial uncertainty. And resolution is not interchangle with precision decimal
places like that; the article doesn't mention anything about precision that I
can see. It should be removed. Or at least the 25000m part could move to
uncertainty, but it needs to be exaplined that this is really study specific
  - Some studies have used a cut-off of spatial resolution \>25,000m or precision
with less than three decimal places [@godfree2021]. Rasterised collections often
have a significant proportion of records that might have low coordinate
precision.  
  - This is a good first step but needs to be guided into the following ones.
Not sure what the map looks like, but it might be good to make another map that
puts boxes around some obvious ones you can see and why
  - I'm not sure I understand what the above means. But I think in general for less obvious errors, it's best to suggest that before data analysis (and honestly, before seeing the data at all), people should determine whether there is an upper bound to remove coordinates (like a 95% confidence interval, or within xx km of an accepted expert distribution). Then run whatever model or test with the complete data and with the reduced data. If it makes a difference, probably make an informed decision based on literature of which results to use as the "main" findings.
  - Having written this out, a brief discussion about this rather than any suggestions is probably all that's in scope for this book
  - The final decisions depend on the species, research question, model parameters etc

- [cleaning_manipulating_strings](./cleaning_manipulating_strings.qmd)
  - Andrew: This does the same as the original chunk but like 1/4 the size

- [cleaning_standardisation](./cleaning_standardisation.qmd)
  - Notes/Andrew: Just some mostly incomplete stuff I think is basic or else
doesnt have a home elsewhere yet. Some concepts are like what was in the old
precleaning page, but precleaning isn't a real thing its just cleaning

- [cleaning_taxonomic_validation](./cleaning_taxonomic_validation.qmd)
  - !! see comments at top of cleaning_taxonomy page.
  - (Example WORK IN PROGRESS, need better fake data, Inverts?)
  - Seperate chunk where message = TRUE for hits
  - Notes/Andrew: There's no explanation for anything about this list here,
what is it, where is it from etc
  - Notes/Andrew: Wouldn't it be better to show, or also show, how to do this query with your dataset?

- [cleaning_taxonomy](./cleaning_taxonomy.qmd)
  - Andrew: The distinction between taxonomy page here, and the taxonomy validation page, is that this page (taxonomy or whatever better name), is about treating the values as if they were any other data type, its just that they happen to be taxonomic and we are cleaning *our dataset* based on that attribute. It's not about cleaning taxnomic issues, its just cleaning data that falls within the category of taxonomy. The content here on this page so far hopefully will make that clearer - for example, filtering based on X, its like you would filter any other data type, or spatial records filtering based on distance and so on. Checking against extinct species, filtering based on life stage etc.
Taxonomic validation on the other hand (not sure on the name), should be about cleaning the actual specific values, and the cleaning *relates to the taxonomy itself*. Is the species name formatted correctly, do you have a naming issues, synynoms, checking upstream and validating etc.  
  - Where I was up to is that the taxnomy_validation page is mostly unchanged (previously taxonomy.qmd). But after looking through, there is probably some content that can be better placed in the new chapters, such as in strings (there is a bunch of string stuff there that is already covered in other sections, or if not can be moved to the strings section and hyperlinked, i dont think it needs to be with taxonomy), or here (if it meets the domain of this page), and then it can stand alone based on the scope i described above
  - Notes/Andrew: This chunk below will need some explaining, I didn't look
into it but there is a few things happening but the comments dont give enough
context or logic
  - Andrew/Notes: Leaving eval = false because I tried to query for a token and got a 403 error.
  - Andrew/Notes: This is worth double checking, I only quickly checked this
and fixed the second half because it wasn't actually filtering anything even
though all but 1 of the species were marine. But this is just as far as I could
understand; I don't know the dataset or anything so its not clear to me if
what's happening is ok or not.
  - Also - It was written up and coded with
the goal stated as removing marine species, if interested in terrestrial. But
this doesn't make sense, the inverts data is all marine but one species? Either
I'm completely misunderstanding or this was a misunderstanding at some point. As
I'm writing this I realised that if this was a mix up, the fix is really easy -
just change the wording to removing non-marine species, and changing the filter.
Makes a lot more sense
  - Side note - the only species that doesn't get filtered has NA or invalid
number as the value. not an actual value for confidence in not marine

- [index](./index.qmd)
  - This website contains resources for working with occurrence data from
living atlases. It is suitable for those who wish to learn to download, tidy,
and transform species occurrence records. This process, often broadly referred
to as *data cleaning*, may vary based on the source of the data, or according to
the aims of the project. Therefore, there is no one-size-fits-all approach,
which is reflected in the way this site is structured.  
Add a diagram and some more text here.
  - Just a placeholder licence
  - actual repository should also contain a licence doc; preferably matching I think

- [outliers](./outliers.qmd)
  - Notes
  - support article around inconsistent sampling and open source data
  - I think this study / method also has some limitations - it relies on the
assumption that you are able to sensibly model the habitat suitability of your
species, with available environmental data and occurrence records. It would be
unsuitable for somebody with limited experience in SDMs. What environmental data
to use for predictors, what time scale - does it match your points, what spatial
scale and importance of scale, this isn't discussed. Their models have
suspiciously high AUC values, seems overfit. The claim that the method should be
more efficient in larger datasets is unsubstantiated. How do you verify the
results? All you know is that the habitat suitability is lower than expected
relative to your other samples. It could be due to sampling bias, and
underrepresented environmental areas. How exactly would you determine the
cut-off for identifying outliers? Not discussed.  
