---
title: Adapting To Change
date: 2014-07-09 04:15 UTC
tags:
---

<p><em>This post was originally posted to the <a target="_blank" href="http://blog.8thlight.com/">8th Light blog</a> on September 18, 2012.</em></p><h2><br></h2><h2 >“The only constant is Change.”&nbsp;<br>— Heraclitus</h2><p>While it was doubtful that Heraclitus was addressing developers, the sentiment certainly still applies. As developers, we live in a world of constantly changing requirements, code bases, tools, and languages. Once we've found our work flow, it is easy to become resistant to change and to new concepts or tools. Facing a new language can seem daunting at first, but have no fear; adapting to a changing environment is not as bad as it seems, and expanding your toolbox with new languages and idioms will make you a better developer. As software professionals we simply need to keep a few things in mind when approaching these new situations.</p><h3>Be Curious And Attentive</h3><p id="yui_3_17_2_1_1404879185423_18422">Genuine curiosity can and should be utilized when trying to learn something new. If you are faced with going from a language like ruby to a functional language like Clojure. It may be a good idea to read up on&nbsp;<a data-cke-saved-href="http://blog.8thlight.com/uncle-bob/2012/08/24/functional-programming-for-the-object-oriented-programmer.html" href="http://blog.8thlight.com/uncle-bob/2012/08/24/functional-programming-for-the-object-oriented-programmer.html" id="yui_3_17_2_1_1404879185423_18421">functional paradigms</a>, the&nbsp;<a data-cke-saved-href="http://paulgraham.com/lisphistory.html" href="http://paulgraham.com/lisphistory.html">history of Lisp</a>, or on&nbsp;<a data-cke-saved-href="http://en.wikipedia.org/wiki/Polish_notation#Computer_programming" href="http://en.wikipedia.org/wiki/Polish_notation#Computer_programming">Polish Syntax</a>. Find what interests you and explore.</p><p>Sometimes the new language may even come with an existing codebase. Being attentive is imperative when approaching an existing code base. While it's easy to open an existing project and just scan through the files until you think it make sense, it requires digging deep into the code to really understand what is going on. Taking the time to read through the tests, looking at the code associated with what you want to write, and seeing that it's what you expected can save you from suprises later. The time it takes to feel acclimated to a new project depends on the size of the code base and on the developer.</p><h3>Writing For The Language or Packing Wisely</h3><p>When moving to a new language, its important to bring our patterns, principles, and the skills we have learned over the years with us, but we need to be mindful not to bring with us idioms and conventions that do not apply. Take for example a simple function that prints a report written in ruby.</p>

~~~ruby
def PrintReport ( reportObjects )
 i = 0;
 while ( i &lt; reportObjects.size ) do
 Kernel.printf ( "Object #" + i.to_s + " ");
 Kernel.printf ( reportObjects[i].data + "\n");
 i += 1;
 end
end
~~~

<p>Even though the above code is perfectly valid Ruby syntax, I think any Ruby developer would be sent through the roof if they came across this code while working. While bringing over what we know to a new language or environment is important, it's also important to adapt that to the style or common idioms of that language. For instance, in Ruby, it's normally frowned upon to use loops when you can leverage the Enumerable library to do that work for you. We could write that previous code in a more Ruby style like this:</p>

~~~ruby
def print_report(report_objs)
  report_objs.each_with_index do |object, index|
    puts "Object ##{index} #{object.data}"
  end
end
~~~

<p>We can leave the debate on whether this is perfectly formatted and styled code for another day, but what we do have here is an example of code written in a style that is familiar to other Ruby designers in this code base. (While both examples are functional, most would agree that one version is more [refined/elegant/simple?)) We don't want to bring our baggage with us from our previous languages or environments. At the same time, that doesn't mean we need to abandon all that we know when we move on to something new.</p><h3>On Getting Stuck</h3><p>There will be plenty of times when you'll find yourself stuck; this is simply part of the daily life of a developer. But getting stuck can be especially frustrating when the syntax or libraries you're working in seem foreign to you. In these times, don't fret, and make sure not to stare into the abyss (lest the abyss stare back into you). Write another test — you may be stuck because your test was taking too big of a step and you needed a smaller one to drive you to your next step. Go back and read through more of the codebase and see how others approached similar situations.</p><p>With every new project, language, or codebase we bring with us our SOLID principles, TDD, and the patterns and principles that we have crafted over our career. Making the jump to becoming a polyglot developer may seem difficult at first, but each additional language is easier than the last, and you'll look back at all you've learned and be ready for more.</p>
