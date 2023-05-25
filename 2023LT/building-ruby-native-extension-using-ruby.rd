= Building Ruby Native Extension using Ruby

: author
    katsyoshi

: theme
    theme

= whoami?

  # image
  # src = img/matz-and-katz.png
  # relative-width = 90

= from

  # image
  # src = img/asakusa-rb.png
  # relative-width = 90

= Motivations

  * I think that Programmers have studied the three major areas of programming, but have never actually created anything in them.
    * CPU
    * Compilers(Programming Language)
    * OS
  * Want to create a Compiler
    * Creating a compiler from scratch is troublesome.
       * I write Ruby, and I love Ruby!
         * Create a compiler from Ruby!!!

= Goals
  * Ruby is natively compiled and can be read using Fiddle in Ruby.
    (1) Integer Calclation
    (2) Variables
    (3) Control Flows(if, while)
    (4) Methods

= Supported Architectures...

* CPU: x86_64
* OS: Linux

= Unsupported Features...

* I won't do it now, because once I start, there will be many things I need to do.
  * Optimizations
  * Type Inference
  * Memory Managements...
    * GC...
* Make something that works.

= Getting AST

* I won't do my best here.
  * I want to use RubyVM::AST, but I used parse.gem
* The Compiler has gotten AST, but this naively compiles to x86_64 assembler.

= Integer Calculation

* The compiler trace AST.

   ((1 + 2) * 3) / (5-4)

* compile and exec result.
     $ bunle exec vaporware sample/plus.rb
     $ ./tmp && echo $? #=> 9

= Variables
* This is hard a little bit.
  * Change the area to be secured by the number of variables.
    * Actually, it’s a piece of cake for you guys here.

* code

        a = 1; b = 2; c =  (a + b) / 3; c

* result

        $ bundle exec vaporware sample/variable.rb
        $ ./tmp && echo $? #=> 1

= Control Flows
* support only if and while
  * cannot probably do `a = if true then 1 else 0 end`

* code

    a = 1
    b = 1
    1 if a == b

* result

        $ bundle exec vaporware sample/if.rb
        $ ./tmp && echo $? #=> 1

= Methods
* This is hard a little bit.
  * The compiler has to defined method at first in program file.

* codes:
  * method definition code: https://github.com/katsyoshi/vaporware/blob/main/sample/method.rb
  * fiddle code: https://github.com/katsyoshi/vaporware/blob/main/sample/fiddle.rb

* result

 $ bundle exec vaporware -s sample/method.rb
 $ ruby -r'sample/fiddle.rb' -e "puts X.aibo" #=> 10

= Conclusion
* Compile sample code, and run getting a result from exit code.
* Compile methods and load compiled mehtods using fiddle.

= Next Challenges
* Support Classes
  * Data or Struct Classes
  * Custom Classes
  * Standard Librarie Classes...
    * ruby compatibility
* Compile to ELF from this compiler
* Parsing Code
  * use RubyVM::AbstractSyntaxTree
