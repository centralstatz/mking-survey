# mking-survey

Testing functionality of importing live Google Forms responses into a Shiny app

# Change Log

## 1/27/2025

* Made a Google Form to test with [here](https://docs.google.com/forms/d/e/1FAIpQLScP3766W9xhidr5f8I_WfGB64aZ5uXeIErItu-tzH11rMiCZQ/viewform)
* Linked responses to get automatically sent [here](https://docs.google.com/spreadsheets/d/1rQR8V3xblApe03yE5yqGdqnqSR9_rj1ySf685KOow4Y/edit?gid=194633045#gid=194633045)
* Used [this page](https://forum.posit.co/t/trying-to-display-a-table-from-live-poll-results-using-r-shiny/84330/3) to guide development
* When I first ran the app, had to authenticate with OAuth and approve tidyverse API to access Google
  + Access issues persisted, with access denied received
  + Tried making the Sheet public with link, access issues persist
  + Used `gs4_auth()` to try to re-authorize; had to check a box to approve access, then it worked from RStudio (locally)
* When loaded, the app currently just imports the data in the Sheet and displays it in the app
  + Tried submitting a new response to the survey and re-running the app; all records displayed
* Used `rsconnect::writeManifest()` to capture app dependencies
* Tried deploying to Posit Connect Cloud from GitHub [here](https://connect.posit.cloud/zajichek/content/0194aaac-8a80-73ac-40c1-e3c77b2dd524)
  + As expected, errors persisted due to authentication issues
* Used the `gs4_deauth()` function in `global.R` to specify no authentication needed for sheet access
  + Works after setting the Google Sheet to public access with the link
  + App is now live on Posit Connect Cloud: https://0194aaac-8a80-73ac-40c1-e3c77b2dd524.share.connect.posit.cloud/
* Now the (live) app imports the updated Google Sheets dataset, allows filtering by question, and displays the results in a bar plot + a table
  + Need to work on updating results (e.g., with a "refresh" button)
  
## 1/29/2025

* Added a dependency for `bslib` to facilitate dashboard appearance
* Added an `actionButton` that can be clicked to refresh the most recent data on demand
  
## 1/30/2025

* Added a dependency on `tidyr` and `dplyr` to facilitate data manipulation
* Added dependency on `forcats` for nicer plot display
* Added the following components:
  + Card to tabulate to responses
  + Plot to view response times
  + Interactive bar plot to show distribution of responses for the selected question
  + Collapsible table to view tabular data
    
## 2/19/2025

* Changed Google Sheet [source link](https://docs.google.com/spreadsheets/d/182-fJACcL7ryFC6SMvdci8R2WCG68dawPF4LpNVXfdg) to [Marvin's example survey](https://docs.google.com/forms/d/e/1FAIpQLSep8TusWkAGpDUnc3QiyBxAp8UY8PiZov3tpo6IV3mifcigsA/viewform?usp=header)
* Used `validate` to ensure there are responses before trying to graph results

## 2/20/2025

* Changed app title
* Add `selectInput` to choose a course to view survey from
* Made function in `global.R` to retrieve sheet based on course selected
* Updated `server.R` to dynamically change the questions displayed with course selection
* Add a `dateRangeInput` to select responses based on the timestamp

## 2/22/2025

* Added additional surveys for 313, 315, and 318
* Changed `server.R` behavior to dynamically update everything when you change the course