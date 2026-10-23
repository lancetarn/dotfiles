# lbot helpers.
#
# wslack: render a day's worklog as Slack mrkdwn, open it in $EDITOR to trim
# before anyone else reads it, and leave the result on the clipboard. Takes the
# same flags as pkm-log, so `wslack --date 2026-07-30` works.
#
# Timestamps are off: they're useful in the log, noise in a channel. Add
# --show-time back by calling pkm-log directly if you want them.
wslack() {
  pkm-log --slack --no-time --edit --copy "$@"
}
