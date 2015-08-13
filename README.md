twitch tv/livestreamer for prezto
=========

A simple prezto module for viewing twitch.tv streams with livestreamer

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

* ttv_setup *user* - downloads a list of channels the given user follows, and parse the list for use with zsh completion

        ttv-setup your_twitch_username

* ttv *stream* - used to open/watch the given stream using livestreamer

        ttv gamesdonequick

Notes/Tips:
-----------

This requires livestreamer to be installed and in your system PATH. If you have issues with permissions due to the default OSX python setup, I suggest installing a new copy of python via homebrew, reload your shell, then install livestreamer with pip.

        brew install python
        pip install livestreamer

By default this plugin executes livestreamer as a background job, to not block use of your shell. You can change this by manually editing the ttv.zsh file, delete the trailing '&' from the following line:

        exec livestreamer http://www.twitch.tv/$1 best &

You can change the location of the cached streams list (default is $HOME/.ttvstreams) by adding the environment variable 'TTVSTREAMS' to your shell profile.

        export TTVSTREAMS="foo/bar"
