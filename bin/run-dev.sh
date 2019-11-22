#!/bin/bash

# Unofficial Strict mode
set -euo pipefail
#IFS=$'\n\t'

# Remove the previous server pid if it exists.
# This is recommended by most every tutorial for rails and docker.
rm -f tmp/pids/server.pid

ESCAPE_CHAR=$(printf '\033') # Special escape character that allows for color codes
# See: https://misc.flogisoft.com/bash/tip_colors_and_formatting
# Note that the '\e' escape sequence is a product of using echo -e, and therefore
# to retrieve that character in other contexts we use a variable substitution with
# ${ESCAPE_CHAR} instead
RED_ESCAPE="${ESCAPE_CHAR}[91m"
CYAN_ESCAPE="${ESCAPE_CHAR}[96m"
COLOR_RESET_ESCAPE="${ESCAPE_CHAR}[39m"

# The -b '0.0.0.0' binds to ip 0.0.0.0, which allows us to see the server from
# the outside world (i.e. a browser outside of docker)
RAILS_COMMAND="bundle exec rails server -p 3000 -b '0.0.0.0'"
WEBPACK_COMMAND='./bin/webpack-dev-server'

# This next command handles running the webpack dev server and rails
# server in parallel, and prepending every line of output for each with a
# colored prefix so it's easy for a human to tell where the output came from.
parallel --jobs 2 --lb ::: \
         "$RAILS_COMMAND 2>&1 | sed -u 's/^/${RED_ESCAPE}rails s |$COLOR_RESET_ESCAPE /'" \
         "$WEBPACK_COMMAND 2>&1 | sed -u 's/^/${CYAN_ESCAPE}webpack |$COLOR_RESET_ESCAPE /'"
# It is a bit of a monster, though, so let's break it down a bit.
#
# parallel, the command, is GNU parallel, which is installed in the Dockerfile
# with apt-get.
# parallel can do a /lot/ of things, but what we care about here is its ability to
# run jobs in parallel.
# The '--jobs' flag tells parallel how many 'threads' to run; normally parallel
# figures this out automatically, but here we want to explicitly run exactly two
# jobs at the same time - the webpack dev server 'job' and the rails server 'job'
# The '--lb' flag does not take any arguments, and tells parallel to break output
# printing on a line by line basis. This is different from the '--ungroup' and
# and '--group' (default) flags. Without this flag, parallel would wait for every
# job to complete before printing it's output, and then do so all at once. This is
# undesireable as we do not expect either of our jobs to finish until we kill
# them, and would mean that we would only see their output after we do so.
#
# Normally, parallel would have a command next, and the things after the ':::' would
# be used as arguments (read `man parallel` for more info). However, without this
# "command" segment, parallel evaluates its arguments and then dumps the result to
# stdout.
#
# We therefore have two "arguments" here - one for the rails server and one for the
# webpack dev server. At the high level, these commands pipe their output into a
# secondary command (sed) which pretends every line with a colored prefix so the
# end user can tell which command generated which output.
#
# Let's break this down for the rails command
# The first thing in this command is '$RAILS_COMMAND', which is what should be a
# familiar rails server command as seen above.
# The next thing, '2>&1', routes all things written to stderr to stdout. Normally
# stderr "escapes" directly to the terminal, bypassing any further pipeline steps.
# In this case, however, we want to prefix everything that would show up on the
# user's terminal, so we shove stderr in with stdout so it can get processed in the
# same manner. The '2>' part is essentially "put stderr into something", and
# the '&1' part refers to stdout. See the link on in two lines for more info.
# The next thing is a '|', which is a pipe. See:
# https://ryanstutorials.net/linuxtutorial/piping.php
# for an explanation of what this is.
# The command being piped into here is 'sed', which is most commonly used for regex
# replacement. Here we're doing a regex replace on the start of every line (^) with
# '${RED_ESCAPE}rails s |$COLOR_RESET_ESCAPE '.
# The '-u' flag tells sed to run unbuffered, which prevents the program from
# accumulating multiple lines before passing output along.
# Next, we get the pattern that is passed to sed:
#   's/^/${RED_ESCAPE}rails s |$COLOR_RESET_ESCAPE /'
# The first character in this string, 's', tells sed that it's running a
# substitution command. The second character, '/', does two things: tell sed that
# '/' will be used as the delimiter character, and also acts as the first
# delimiter. Everything after the first delimiter and up to the second one is the
# pattern that will be searched for to replace, which in our case is just '^'.
# '^' matches with the beginning of every line, so we're just effectively saying
# "insert the replacement string at the front of every line".
# Everything between the second and third delimiter is the replacement string,
# which is:
#   '${RED_ESCAPE}rails s |$COLOR_RESET_ESCAPE '.
# Now normally, bash strings in single quotes don't do escape sequences or
# variable expansion, and our argument to sed is in single quotes. However, this
# single quoted string is itself in a double quoted string, so the variables here
# are expanded before the entire command string is passed to parallel.
# This means that '${RED_ESCAPE}' gets substituted with the value of the variable
# RED_ESCAPE, as does $COLOR_RESET_ESCAPE with the variable COLOR_RESET_ESCAPE.
# This means that the string between '${RED_ESCAPE}' and '$COLOR_RESET_ESCAPE'
# will be printed in red, i.e. we print a red 'rails s |' at the start of every
# line.
#
# The webpack dev server is handled in essentially the same way on the next line,
# but with cyan instead of red.
#
# Now, there is one important alternative to using parallel here that is worth
# mentioning, backgrounding one of the processes. This would look something
# like this:
#    eval "$WEBPACK_COMMAND 2>&1 | sed -u 's/^/${CYAN_ESCAPE}webpack |$COLOR_RESET_ESCAPE /'" &
#    eval "$RAILS_COMMAND 2>&1 | sed -u 's/^/${RED_ESCAPE}rails s |$COLOR_RESET_ESCAPE /'"
# This has two problems though:
#  1: It assumes that the parent tty actually allows processes to run in the
#     background (i.e. `stty -tostop` is set), which is technically non-default
#     behavior.
#  2: It does not ensure that individual lines are not interleaved due to race
#     conditions. E.g. if process 1 outputs abc and process 2 outputs 123 at the
#     same time, the user could potentially see a12bc3, which is not great
