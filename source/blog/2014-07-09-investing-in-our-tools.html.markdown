---
title: Investing In Our Tools
date: 2014-07-09 04:19 UTC
tags:
---

<p><em>This post was originally posted to the&nbsp;<a target="_blank" href="http://blog.8thlight.com/">8th Light blog</a>&nbsp;on February 11, 2013.</em></p><p>&nbsp;</p><p>As developers our workspaces are important to us. As software craftspeople, our tools are part of who we are. How many times do we settle for tools that do not fit our needs or our own style or continue to work in an environment which is counterproductive? We should invest the time in continually improving our tools and how we use them.</p><p>Taking time away from writing code to work on&nbsp;<span>how</span>&nbsp;we write our code might seem unproductive at first, but the small increases in productivity will compound immensely over time. Considering the way we write our code can help us see needless repetition in our daily schedules. Removing this repetition can simplify both our routine and our code. Along with the opportunity to remove repetitive tasks, we can lessen the burden of stressful manual tasks. The more automation the better.</p><h2>The Command Line</h2><p>Few developers take full advantage of the power and flexibility of the command line. Leveraging the simple ability to alias methods can save minutes or hours of time every day. These methods include the very common, and useful, git shorthands:</p>

~~~shell
[~] gco release # git checkout release
[~] gst # git status
~~~


<p>They also include a much more complex ‘find string in current directory’ command.</p>

~~~shell
[~] findInDir 'socks' # find . -name "*" | grep 'socks' -n
 30:./app/controllers/drawers_controller.rb
 45:./spec/controllers/drawers_controller_spec.rb
~~~

<p>That is about as complex as we want to get with aliases. In most cases, for anything more complex, we would rely on custom shell scripts or functions. Such a function could return all routes that include a given string:</p>

~~~shell
[~] routesWith publication # routesWith() { be rake routes | grep "$\*"; }
  new_publication GET/publications/new(.:format) publications#new
  edit_publication GET/publications/:id/edit(.:format) publications#edit
  publication GET/publications/:id(.:format)publications#show
  PUT/publications/:id(.:format)publications#update
  DELETE /publications/:id(.:format)publications#destroy
~~~

<h2>The Editor</h2><p>It is hard to think of anything more essential to a developer's work than a text editor. Although we may never decide on what the perfect editor is, there is little disagreement on its importance. The editor we use should suit how we work. It is in our own best interest to invest in learning how to use it. Nearly every editor allows users to modify its settings to best fit individual styles and needs. This can be done through plugins, custom macros, or other means.</p><p>My editor of choice currently is vim, so all editor related examples in this post will be in vim parlance.</p><p>Consider running rspec tests. We can run these tests in another window or tab, or quit the editor and run them from the command line.</p><p>What if we wanted to run the tests without leaving the editor? In vim we have several options. The first and most obvious would be to shell out and run the rspec command directly.</p>

~~~ruby
  :!rspec spec/models/drawers_spec.rb
~~~

<p>While this runs the command in only a few simple steps, we can do better. Adding this line into our .vimrc along with a keyboard shortcut will drastically speed up this process.</p>

~~~vimscript
".vimrc
function! RunRspec()
exec '!rspec spec/models/drawers_spec.rb'
endfunction
map <leader>rt :call RunRspec()<CR>
~~~

<p>Now when we reload our editor we can run our tests almost instantly. On the other hand, we have just hard coded a command that only runs a single file. If we generalize this code, we can not only make it run the current file, but also the current test only.</p>

~~~vimscript
".vimrc
function! RunSingleSpec()
exec '!rspec % -l ' . line('.')
endfunction
map <leader>rt :call R
~~~

<p>Now we have drastically sped up the time it takes to go from writing a test to running that test and seeing the resulting output. Besides user defined macros, every popular editor comes with a plethora of plugins to alter or extend its functionality. My personal favorites are vim keybindings for all editors that are not vim itself. For vim itself, I enjoy plugins that lend some form of code completion and project navigation. When approaching the idea of plugins, it is best to know what you like and want, and not to go for everything that is out there. Spending time to find high quality, well-maintained plugins is well worth it in the long run. Using and living with a plugin that is unmaintained, or worse buggy, is a drain on productivity and the opposite of what we're looking for.</p><p>When looking for editor plugins, don't forget that there is always the option to contribute to existing plugins, improving the ones already out there or creating your own. While this may be a time investment not everyone wants to make, it can be personally rewarding for those who do.</p><p>Last, but certainly not least is the look and feel of your editor. Your color scheme will not only affect the way you see your code, but in some ways will affect how people perceive you. Many themes are simply named after the person who created them.</p><p>Once you've settled on a few color schemes you enjoy, look at your font. Is it really the best font for your eyes and preferences? The growing options of excellent free mono space fonts means there is little reason to settle for standard ones such as monaco.</p><p>You may want to also consider paddings, margins, and line-height. However, it is best not to become obsessive about every pixel. We can use macros and plugins to make our workspace efficient, and colors and fonts to make it our own.</p><p>These ideas are not meant to consume us with minute details and optimizations, or to have us spend all of our time working on our tools. It is to recognize the importance of the tools we use every day. It is important to look critically at the tools we have chosen and make the effort to improve and invest in them. We currently give our tools and workspace our time whether we want to or not. By spending time improving our tools themselves and how we use them, we can not only save time by being more productive, but we can be proud of those tools.</p>
