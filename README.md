twitch tv/livestreamer for prezto
=========

A simple [prezto](https://github.com/sorin-ionescu/prezto) module for viewing [twitch.tv](http://www.twitch.tv) streams with [livestreamer.](http://livestreamer.readthedocs.org/en/latest/index.html#)

How to install
--------------

* Download or clone this repo anywhere you choose, and symlink the root folder into your .zprezto/modules folder

        ln -s ./twitchtv ~/.zprezto/modules/twitchtv

* Activate the plugin in `~/.zpreztorc`:

        zstyle ':prezto:load' pmodule \
        twitchtv \
        ...

* Open/re-load your shell to use the plugin.

Commands/Usage:
------

* ttv *stream* - used to open/watch the given twitch.tv stream using livestreamer.

        ttv gamesdonequick 

    Quality options can be supplied manually after the stream name:

    (a)udio, (h)igh, (l)ow, (m)edium, (s)ource/best, (w)orst/mobile

        ttv gamesdonequick h

    If quality is omitted/left blank, the script will open the "Source" quality stream by default.

* ttv-setup *user* - downloads a list of channels the given user follows, and parse the list for use with zsh completion. This only saves new/unique entries, so you can combine lists from multiple users (by running this command multiple times) without duplicate entries being saved.

        ttv-setup your_twitch_username

* ttv-save *stream* - manually add/save an entry to your cached/saved streams list.

        ttv-save foo

* ttv-delete *stream* - manually delete an entry from your cached/saved streams list. Can accept multiple names/arguments to delete several streams at the same time.

        ttv-delete foo
        ttv-delete foo bar foobar

Notes/Tips:
-----------

This requires livestreamer to be installed and in your system PATH. If you have issues with permissions due to the default OSX python setup, I suggest installing a new copy of python via homebrew, reload your shell, then install livestreamer with pip.

        brew install python
        pip install livestreamer

By default this plugin executes livestreamer as a background job, to not block use of your shell. You can change this by manually editing the ttv function file, delete the trailing '&' from the following line:

        exec livestreamer http://www.twitch.tv/$stream_name $stream_qual &

You can change the location of the cached streams list (default is $HOME/.ttvstreams) by adding the environment variable 'TTVSTREAMS' to your shell profile.

        export TTVSTREAMS="foo/bar"
