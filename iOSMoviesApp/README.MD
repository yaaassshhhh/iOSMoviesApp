//
//  README.MD
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 23/07/25.
//

The stored titles should be stored in form of an array of strings... (say tokens)

Searching Algo Requirement Specification:

1 - A search for an Empty String should result in the display of all the movies...
                    
2 - A match should occur only on Token prefixes i.e - A search for "Av" should result in the display of "Avengers", "The new avengers", etc...
    This match should not occur for characters matching in between the token i.e  should not match for
    "Kraven the Hunter"...
                    
3 - A search for "L jaye" should match "Dilwale dulhania le jayenge" and should not return union of movies that matches separately with "L" and "Jaye"
                    
4 - Each token in the search text(Search Tokens) should match a separate token in the movie title. for instance - "M M" should match "Mad Max: Fury Road" but not "Megan 2.0"
                    
5 - A search for "tur back" should match "dont turn back" as well as "back turn not possible", "the backlog that turned into a back burner"... etc, i.e the order of the search tokens should not matter...
                    
6 - A search for “p pe” should match (among others) person.badge.plus. In this example, the “p” could be considered to match either person or plus, but “pe” can only match person. The more restrictive (i.e. longer) search token “pe” must match person, allowing "p" to match plus. In combination with requirement 4 (each search token matches a separate data token), this avoids giving different results depending upon the order of tokens in the strings. This is important and subtle behaviour but is actually easy to implement. i.e - a longer searched token should be matched first
                    
7 - leading or trailing empty spaces must be ignored as well as multiple spaces between tokens should be treated as a single space
