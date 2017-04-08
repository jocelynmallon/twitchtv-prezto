# Provides twitch.tv/livestreamer functions
#
# Authors:
#   Jocelyn Mallon
#

# Return if requirements are not found.
if (( ! $+commands[streamlink] )); then
  return 1
fi

# Load dependencies.
pmodload 'helper'

# Set TTVSTREAMS to the default if unset.
if [[ -z $TTVSTREAMS ]]; then
  export TTVSTREAMS="$HOME/.ttvstreams"
fi

# Check if $TTVSTREAMS is a symlink.
if [[ -L $TTVSTREAMS ]]; then
  TTVSTREAMS=$(readlink $TTVSTREAMS)
fi

# Create ttvstreams if it doesn't exist.
if [[ ! -f $TTVSTREAMS ]]; then
  touch $TTVSTREAMS
fi
