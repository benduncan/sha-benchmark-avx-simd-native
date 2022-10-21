#!/bin/sh

echo '"instance","size","method","time"' > analytics/benchmark.csv


# Ok, this is overkill, however process the output into a nicely formatted CSV for Python
find logs -name "*.txt" | cut -d'/' -f2 | cut -c 7- | rev | cut -c 5- | rev | xargs -P1 -I{} bash -c "perl 'analytics/bench-to-csv.pl' 'logs/bench-{}.txt' '{}'" | grep -v 256M >> analytics/benchmark.csv