# ------------------------------------------------------------------------------
#          FILE:  ttv.zsh
#   DESCRIPTION:  twitch.tv/livestreamer plugin file.
#        AUTHOR:  Jocelyn Mallon
#       VERSION:  0.0.2
# ------------------------------------------------------------------------------

# Set TTVSTREAMS if it doesn't exist to the default.
# Allows for a user-configured BOOKMARKS_FILE.
if [[ -z $TTVSTREAMS ]] ; then
	export TTVSTREAMS="$HOME/.ttvstreams"
fi

# Create ttvstreams it if it doesn't exist
if [[ ! -f $TTVSTREAMS ]]; then
	touch $TTVSTREAMS
fi

function ttv () {
  if [[ ! $(command -v livestreamer) ]] || [[ $# -ne 1 ]]; then
    echo "livestreamer not found, or no argument/name entered"
    return 1
  else
    exec livestreamer http://www.twitch.tv/$1 best &
  fi
}

function __ttv_check_symlink () {
  if [[ -L $TTVSTREAMS ]]; then
    TTVSTREAMS=$(readlink $TTVSTREAMS)
 fi
}

function __ttv_check_user () {
  local ttv_user_response=$(curl -H 'Accept: application/vnd.twitchtv.v3+json' \
    -X GET https://api.twitch.tv/kraken/users/$1/)
  if [[ $ttv_user_response = *"404"* ]]; then
    return 1
  fi
}

function __ttv_get_user_streams () {
  __ttv_check_symlink
  curl -H 'Accept: application/vnd.twitchtv.v3+json' \
  -X GET https://api.twitch.tv/kraken/users/$1/follows/channels | \
  grep -ioR '"name":"[^,]*[^",]' | sed 's/"name":"//' | sed 's/(standard input)://' >! $TTVSTREAMS
}

function ttv_setup () {
  if [[ -z $1 ]]; then
    echo "No user specified, please try again with a valid user name"
    return 1
  else
    __ttv_check_user $1 && __ttv_get_user_streams $1
  fi
}