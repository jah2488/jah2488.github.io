---
title: Up and Running with Rails 5 Beta
date: 2016-01-05 17:47 UTC
tags: rails
---

I decided to try out rails 5 on a new side project last night and could not find any useful guides. After some googling I was able to get everything up and running and documented my process below. Hope someone finds this helpful.

To install the rails beta, you need to supply the **--pre** flag to the gem install command.

~~~sh
gem install rails --pre
~~~

Oh no, that didn't work.

~~~sh
Fetching: eventmachine-1.0.8.gem (100%)
ERROR:  Error installing rails:
	ERROR: Failed to build gem native extension.
~~~


Rails 5 includes [ActionCable](https://github.com/rails/rails/tree/master/actioncable), which depends on [EventMachine](https://github.com/eventmachine/eventmachine) (and a [few](https://github.com/celluloid/celluloid) [other](https://github.com/faye/faye-websocket-ruby) [libraries](http://redis.io/)). So you need to be able to install EventMachine, and the error I was having was because my version of **OpenSSL** was out of date. Updating it with [homebrew](http://brew.sh/) was needed since I'm on El Capitan and Apple changed some things.

~~~sh
brew upgrade openssl
~~~

or

~~~sh
brew install openssl
~~~


If you want to use the new rails command to generate apps using the **--api** flag at this point you'll need to update your rails binary, which is done via **Railties**. This is generally why you'd want to use something like a [gemset](https://rvm.io/gemsets/basics) or whatever the equivalent is for your ruby version manager of choice.

For my current needs, I can just blow away my existing rails installation completely and install Rails over it.

~~~sh
gem uninstall rails railties
~~~
[More Info](http://stackoverflow.com/questions/16164697/uninstall-rails-completely)


Now lets try installing the gem again. To speed things up, I'll skip over a few of the other errors I ran into that led me to this solution. Great, we installed openssl, but if the gems being installed can't find those headers, it doesn't help us much.


~~~sh
gem install --pre -- --with-cppflags=-I/usr/local/opt/openssl/include
~~~
More info on how this works can be [found here](http://stackoverflow.com/questions/6761670/is-there-any-way-to-change-gcc-compilation-options-for-a-gem)


So now we have Rails 5 beta installed, this can be verified by checking the rails gems you have installed.

~~~bash
gem list --local | grep rails
~~~

Congrats! You have Rails 5 up and running. I highly suggest you read up on some of the changes and try out the new features. I am really excited to finally have an official solution for writing APIs in rails, that cuts down out all the pieces I don't need.


More reading:

- [Rails Feature Overview](http://nithinbekal.com/posts/rails-5-features/)
- [RailsApps Update Guide](http://railsapps.github.io/updating-rails.html)
