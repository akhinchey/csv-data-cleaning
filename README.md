CSV Data Cleaning

Order of operations:

- Opens CSV file and parse all lines into Entry objects
- Iterates through all entries, detecting which ones have descriptions that are title cased

  Performs the following formatting on ONLY title case descriptions:

  - Checks for assorted keywords (which indicate that a title is likely not present) at the beginning and middle of each description, and perform certain downcasings accordingly.

  - Downcases all entry descriptions that have not been affected by any of the kayword checks.

  - Capitalizes the beginning of all detected sentences.

  - Upcases some commonly found acronyms.

  - Capitalizes common words found in descriptions such as, "English", "Medicaid" etc.