# Functional Programming is Awesome

I have had a moment of clarity. I have experienced the value and power of higher-order functions to my current max potential. I have written an exciting and elegant function in Haskell.

(The code this article is about can be found [here](../../Haskell/cis194/02/HW02.hs).)

## Haskell is Awesome

I have been spending a lot of time recently learning Haskell. It is quickly becoming my most loved language - although it's not a very fair game: I haven't really done any actual programming in anything in awhile. (The closest I've come to actually "programming" recently is in OCaml struggling through a MOOC.) Nonetheless, I'm very excited. I really do think I just wrote a function that shows a wonderful example of how I'm "thinking functionally," something I never understood literally five minutes before writing this. I'm beginning to see the light in all it's glory.

## Show Me the Code!

Alright, I've now hyped this up like crazy, but I assure you it's very exciting. You're probably thinking that it's an expertly crafted, multi-line, applicative-functor-monad-monoid-type-theory-something beast of a function that's production ready and will solve the world's problems. People shall look upon it for decades, studying the intricacies and meaning behind every expertly placed function, operator, definition, and typeclass involved. Well, here it is:

    countColors' :: Code -> [Int]
    countColors' c = zipWith exactMatches' (cycle [c]) $ map repeat [minBound ..]

___AMAZING!___

Right?..

### Meh..

Look, I know. Maybe it's not what you expected. Maybe you can already write functions like that in your sleep. Well, good. I hope that you can then appreciate how nice this function is. But for me, this is a whole new world. This is the story of how I, Ian Harris, wrote a function.

## Iterative and Functional Thinking

So some may see this and think "big woop, it's a simple definition." But not me. Well, not me from fifteen minutes ago. The current me does say "big woop, it's a simple definition," and that's why I'm so excited by it.

This definition of `countColors'` is nothing special to a veteran Haskeller or even anyone who has done any programming in a functional style. But this is the kind of definition that shows why functional programming is so powerful. I'm not trying to be arrogant in that claim - it really is! Look at how [Learn You A Haskell For Great Good!](http://http://learnyouahaskell.com/) gives examples of `zipWith`:

    ghci> zipWith' (+) [4,2,5,6] [2,6,2,3]
    [6,8,7,9]
    ghci> zipWith' max [6,3,2,1] [7,3,1,5]
    [7,3,2,5]
    ghci> zipWith' (++) ["foo ", "bar ", "baz "] ["fighters", "hoppers", "aldrin"]
    ["foo fighters","bar hoppers","baz aldrin"]
    ghci> zipWith' (*) (replicate 5 2) [1..]
    [2,4,6,8,10]
    ghci> zipWith' (zipWith' (*)) [[1,2,3],[3,5,6],[2,3,4]] [[3,2,2],[3,4,5],[5,4,3]]
    [[3,4,6],[9,20,30],[10,12,12]]

(From http://learnyouahaskell.com/higher-order-functions; In these examples the author is using their own definition of `zipWith`, `zipwith'`, but it's irrelevant here.)

Now why is this interesting? Well, I read this book (mostly - the last couple chapters were too confusing and not helpful enough for me to consume them at the time) and saw these examples and typed them into GHCi and then that was it. I didn't immediately learn anything, I didn't suddenly see why it was a useful function and apply changes to my code, and I certainly didn't write a terribly written essay at two in the morning. But look above! I used `zipWith`! And, as you'll now see, it was useful!

### Learning and Improving from Oneself

This is the true heart of why I believe I've truly written a masterful definition. Here's a secret: the exciting definition is `countColors'` (note the prime), and not `countColors`. There does exist a definition `countColors` in the same module, only a few lines above `countColors'`, but it is not as interesting as a definition by itself. (The use of `exactMatches'` is a similar case, but it's not as exciting as `countColors'`.)

Here is `countColors`:

    countColors :: Code -> [Int]
    countColors a = let reds = exactMatches' a (repeat Red)
                        greens = exactMatches' a (repeat Green)
                        blues = exactMatches' a (repeat Blue)
                        yellows = exactMatches' a (repeat Yellow)
                        oranges = exactMatches' a (repeat Orange)
                        purples = exactMatches' a (repeat Purple)
                    in
                      [reds, greens, blues, yellows, oranges, purples]

Ech! No thank you, `countColors`, take me back to `countColors'`!

So why am I still excited? Well, because created a working defintion to solve a problem and then I _immediately_ recognized that it wasn't an ideal solution (repeating myself six times), saw what piece(s) had to be abstracted out (`exactMatches' a (repeat _)`), and was able to think of a better, more general, future-prepared, functional definition. And I'm not a math wizard or anything!

I was familiar with `zip`, saw that I was essentially zipping two lists together (`Code` is defined as `type Code = [Peg]`) with the function I wrote, `exactMatches'` to get a list of values. I almost spelled out the type signature for `zipWith` in my head, so I gave it a shot. After a bit of messing around in GHCi, I was able to get all the types to line up, and to my enjoyment, it worked exactly as `countColors` worked, only much nicer!

What is so nice about `countColors'`, anyway? Well, 30-minutes-ago Me probably wouldn't really "get" it. But the new and improved Me does! There are a few things, as far as I'm concerned.

1. It's much more concise code. This is pleasant because it's exactly the same functionality while being much less repetitive and long.
2. It's more "future-ready." Defining `countColors'` actually required me to change the definition of `Peg`. I wanted the extremely nice (in my opinion) way of expressing "a finite list of infinite lists, each of which contain exactly one of every value of type `Peg` in order." That simply boils down to `[minBound ..]` in Haskell, which is awesome. This means I can change the order of the values of `Peg`s definition or add new constructors and `countColors'` will still work just fine and, more impressively, give _meaningful_ results with no changes to the definition. That means that what's important is changing the shape of the data itself, not the definition of functions that operate it, and that to me is beautiful. The coolest thing about this is all I had to do was add two more typeclasses (`Enum` and `Bounded`) to the defintion of `Peg` - _that's it_
3. It's probably more efficient. I don't actually know this, but my naive assumption is that it is more efficient.
4. It's pretty freaking sweet.

### Conclusion

I have now been smashing on my keyboard for about an hour just to write to myself (but I like to pretend someone might read this). Why waste my time writing all this? Because how I got here _isn't magic_. I didn't read a bunch of textbooks and research papers and deeply think about every word that Simon Peyton Jones wrote in the past 30 years. I got to this exciting defintion simply by writing a naive first approach, __wrote a comment describing how the function worked__, and immediately saw a solution come out of plain English. For me, the important part seems to be writing the plain English definition of what a function does.

The interesting part to me is that I really did just compose functions to get the definition of `countColors'`. The definition is six functions (not exactly correct due to sugar and all, but it's a close enough description to be useful for me) interacting with one parameter passed to the function. That's what (I think) people talk about when they talk about the beauty and importance of higher-order functions. It's the first time I've ever written a definition I was really satisfied with, and that's exciting.

In summary, functional programming is a very exciting way to program. Having the moment internally of "oh, wait. I know what that pattern is! I can use _x_!" (_x_ in this case was `zipWith`) is thrilling and thought-provoking. I wanted to shout to the world "Look! I did it! I wrote a function definition! And it's cool!" But it's late and cold outside, so I wrote this blog post for nobody instead.

For future me: Continue to enjoy these moments, and continue to struggle. The payoff of realizing you've created something _good_ is outstanding and, most importantly, _in reach_.
