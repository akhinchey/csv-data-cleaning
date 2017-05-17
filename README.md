# CSV Data Cleaning

## Order of operations:

- Opens CSV file and parse all lines into Entry objects
- Iterates through all entries, detecting which ones have descriptions that are title cased


  Performs the following formatting on ONLY title case descriptions:

  - Checks for assorted keywords (which indicate that a title is likely not present) at the beginning and middle of each description, and perform certain downcasings accordingly.

  - Downcases all entry descriptions that have not been affected by any of the kayword checks.

  - Capitalizes the beginning of all detected sentences.

  - Upcases some commonly found acronyms.

  - Capitalizes common words found in descriptions such as, "English", "Medicaid" etc.


## Summary of Logic

I opted to tackle this challenge with OOP in Ruby. It turned out that identifying which descriptions were title cased would be the most straightforward task. Trying to then determine which entries had titles was much more challenging, and required a lot of judgement calls that worked for most cases but not all. My approach to this was to try to determine what text was definitely NOT a title.

Examples:
- Any line starting with certain words (such as "Provides" or "Offers") almost always contained no title and the entire string is down cased except for the first word.
- A line where a keyword like "Provides" appears after several words usually contained no title after the keyword, and so every word from the keyword on is down cased. 

At the midway point of the reformatting process, all descriptions that have not already been reformatted in some way are down cased. My reasoning for this was that most of the descriptions do not contain titles and so even if the code wasn't able to detect one, odds are that it's better to down case the entire string instead of leaving it title cased. After this I restored most of the formatting that was lost during the down casing.

## Drawbacks

While the approaches I took worked most of time, there were always some cases that slipped through the cracks. Some titles and names of locations got down cased due to the descriptions not containing the keywords I was targeting. Sometimes a title was incorrectly identified and a portion of text was left in title case when it should have been reformatted. However, I didn't feel certain that writing code for these edge cases wouldn't impact many other descriptions that were correctly formatted. The final solution you see here is the best solution I could come up with at the time that balanced these pros and cons.

## Conclusion

This was an extremely interesting challenge! As time went on I got better at identifying patterns and was always considering different possibilities. Even as I write this my mind is thinking of the different and better ways I would tackle this challenge if I had the chance to redo it.