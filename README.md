# mking-survey

Testing functionality of importing live Google Forms responses into a Shiny app

# Change Log

## 1/27/2025

* Made a Goole Form to test with [here](https://docs.google.com/forms/d/e/1FAIpQLScP3766W9xhidr5f8I_WfGB64aZ5uXeIErItu-tzH11rMiCZQ/viewform)
* Linked responses to get automatically sent [here](https://docs.google.com/spreadsheets/d/1rQR8V3xblApe03yE5yqGdqnqSR9_rj1ySf685KOow4Y/edit?gid=194633045#gid=194633045)
* Used [this page](https://forum.posit.co/t/trying-to-display-a-table-from-live-poll-results-using-r-shiny/84330/3) to guide development
* When I first ran the app, had to authenticate with OAuth and approve tidyverse API to access Google
  + Access issues persisted, with access denied received
  + Tried making the Sheet public with link, access issues persist
  + Used `gs4_auth()` to try to re-authorize; had to check a box to approve access, then it worked from RStudio (locally)
* When loaded, the app currently just imports the data in the Sheet and displays it in the app
  + Tried submitting a new response to the survey and re-running the app; all records displayed
* Used `rsconnect::writeManifest()` to capture app dependencies