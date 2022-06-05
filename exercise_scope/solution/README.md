1. R will complain that it cannot find the `%>%` function because {magrittr} is only loaded in the UI file, but it's also used in global and in server. We need to move `library(magrittr)` into the global file.

2. `4, 1, 3, 2`. 4 is in global, which runs before the ui/server, then 1 is at the beginning of the UI file, then 3 is still inside the UI, then 2 because it's in the server which runs after the UI.

3. Only 2 will be different because it runs on every new user session. The others will remain constant after the app first loads.

4. Same answer as above. It doesn't matter if the other session is on your browser or on a different computer.
