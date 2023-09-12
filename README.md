## Running the machine

The edicolante will manage a number of tasks:
- Interest vertical:
    - Read the `keywords` to follow, and resolve their `idkeyword`
    - Hourly query Oskar for the interest signal
    - Send the signal to the anomaly detection API and resolve whether there's an anomaly
    - If there's an anomaly, prepare a plot and brief text, and send it to a telegram channel through a Telegram bot
- News vertical:
    - daily run the collector and put the data in the PSQL server
    - daily run the anomaly detection, and put the data in the PSQL server
    - daily produce the json and push them to strillone-pre-fe

All of this is run by
- Setting the right environment variables as described in `secrets.txt`
- ssh to the server with a _screen_ session
- Run the runner:
    `julia --project
    julia>include(scripts/main.jl)`
- disconnect by leaving the screen session living (so you can go back and see what's happening!)

TODO

- Financial data vertical
- Integrate TOL anomaly detection