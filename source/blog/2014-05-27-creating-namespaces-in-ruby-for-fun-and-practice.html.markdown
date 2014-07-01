---
title: Creating namespaces in ruby for fun and practice
date: 2014-05-27 14:40 UTC
tags:
---
A recurring practice of mine these days is to take a feature of a language and see if I can replicate its functionality or likeness in Ruby. Sometimes this is because the feature is one I wish Ruby supported, but in most cases its simply a fun exercise to see if Ruby is capable of doing such a thing and seeing what the design implications would have on my Ruby code.

Lately I’ve been switching frequently between Clojure and Ruby. This has me curious about how close I can get Ruby to look like Clojure in size and style. Recently, what has bothered me most has been how you define a namespace in Ruby by nested modules. Compared to other languages like Clojure, Java, or Haxe, Ruby can seem rather verubyose. For example, here’s Clojure:


~~~clojure
(ns :github.users.repositories.utilities.greeter)

(defn greet [] "hello")
~~~


This is much more terse than Ruby’s deeply nested namespaces: 


~~~ruby
module Github
  module Users
    module Repositories
      module Utilities
        module Greeter
          def self.greet
            'hello'
          end
        end
      end
    end
  end
end
~~~


Even Ruby’s inline syntax, [which you may not want to use](http://blog.elpassion.com/Ruby-gotchas/), seems comparatively clunky:


~~~ruby
module Github::Users::Repositories::Utilities::Greeter
  def self.greet
    'hello'
  end
end
~~~

Lets fix that. What I want is a syntax that lets me state clearly the namespacing in which my code should be found, without needing all that nesting. After a little bit of trial and error, I came up with this syntax. [The original gist of this can be found here.](https://gist.github.com/jah2488/8938747)


~~~ruby
ns 'github.users.repositories.utilities.greeter' do
  def greet
    'hello'
  end
end
~~~


Simple, short, and clean. Now lets walk through the code that does the magic.


~~~ruby
def ns(namespace, delim = '.', &block)
  nest_mod(namespace.split(delim), block)
end
~~~


The ns method ends up being a wrapper of the method that does all the work and a bridge to the DSL we are providing.

I have an optional parameter specifying what the delimiter is for the namespace. This both provides flexibility in the input we accept and abstracts away having a magic string in the method body. 

I am taking Ruby’s implicit block and converting to a proc argument for our method. The reasoning behind this is syntax. If the proc were a normal argument, it would make the method call awkward.


~~~ruby
ns('greeter', Proc.new {
  def greet
    'hi'
  end
}) #ew

~~~


Now for the method that does all the work.


~~~ruby
def nest_mod(mod = Kernel, mod_names, block)
  return mod.module_exec(&block) if mod_names.empty?
  find_or_create_const(mod, to_const(mod_names.first)).tap do |this|
    make_module_methods_accessible(this)
    this.module_exec do
      nest_mod(this, mod_names.drop(1), block)
    end
  end
end
~~~

It's dense, but readable. If it is not immediately obvious, this is a recursive method that will call itself for every namespace in the list.


The method begins with the end, the leaf node, the base case, what have you. If there are no more ~module_names~ left, it evaluates the block of code provided in the context of the current module. If there are more ~module_names~, it continues creating nested modules.



~~~ruby
def find_or_create_const(mod, str)
  return mod.const_get(str) if mod.const_defined?(str)
  return mod.const_set(str, Module.new)
end

~~~

The helper method `find_or_create_const` that takes the current module and a ‘constantized’ string version of the first `module_name`. It returns that constant if it has been already defined within the current module scope. Otherwise, it creates a new empty module with the given name.

A [tap](http://www.seejohncode.com/2012/01/02/Ruby-tap-that/) block allows us to work with the constant returned from `find_or_create_constant_in_module` without the need for an intermediate variable. This is one of the few times when I feel the call to tap provides more intent and adds more clarity to the ‘[story the method is telling](https://practicingRuby.com/articles/confident-Ruby)’.

Moving into the block:

~~~ruby
def make_module_methods_accessible(mod)
  mod.module_exec { extend self }
end
~~~

This name of this method is longer than all the code within it. I’m sure there is a better name out there, but I'm also certain it'll be the same length. The current name explains what it is doing, but not how it's doing it or what doing that means. The module ~extend self~ call is a way to turn every instance method in a module into a singleton method. This eliminates the need to repeat the ~def self.foo~ pattern in every method.

Ending the method is a call to `module_exec` in the context of the new module and then a recursive call to itself after dropping the first name from the `module_names` list.

The one limitation I ran into with this was that you cannot nest any constants inside your namespace unless you call `const_set`. Due to the way [Ruby parses](https://twitter.com/jm/status/432721441599942656) blocks and evaluates constants they will always end up at the [top level namespace](https://gist.github.com/jah2488/8890318). I've packed the finished code into a [gem](https://github.com/jah2488/namespacing) if anyone is interested in trying it out.

I was happy to find a syntax that both cleans up the Ruby nested module boilerplate while still feeling like Ruby code in the end. A great approach for learning ways to tackle new or existing problems is to adopt the perspective of a different language or paradigm.
