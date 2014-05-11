# User Stories

## Viewing the Menu

As a Users unfamiliar with the application
I want to see a list of options

Acceptance Criteria:
  * If the user selects 1, they see "Please enter a User-Name:"
  * If the user selects 2, they see "Not so fast! Who are you?"
  * If the user selects 3, they see "What do you want to do?"
  * If the user selects 4, they see "What kind of search you want to do?"
  * If the user selects 5, they see "There are <output> notes in the database"
  * If the user types in anything else, they should see "Sorry buddy, <input> is not a valid selection." and the menu should be printed out again

Usage:

    > ./ruby_notes
    Welcome to Ruby_Notes
    What do you want to do?
    1.==> Register as User
    2.==> Create a Note
    3.==> Modify a Note
    4.==> Search
    5.==> Count all my Notes

## Register as User

As a User I want to register to be alble
to use all the application functionality

Acceptance Criteria:

  * Unique Users will be added to the database
  * Duplicate Users can't be added

Usage:

    > ./ruby_notes
    Welcome to Ruby_Notes
    What do you want to do?
    1.==> Register as User
    2.==> Create a Note
    3.==> Modify a Note
    4.==> Search
    5.==> Count all my Notes
    - 1
    Please enter a User-Name:
    - John
    John has been added as a User.

## Create a Note

As a registered User I want to be alble
to Create a new Note

Acceptance Criteria:

  * Unique Users will add any number of Notes they want
  * A tag wil be added to the new Note
  * Duplicate Note titles can are allowed

Usage:

    > ./ruby_notes
    Welcome to Ruby_Notes
    What do you want to do?
    1.==> Register as User
    2.==> Create a Note
    3.==> Modify a Note
    4.==> Search
    5.==> Count all my Notes
    - 2
    What is the title of the note you want to create?
    - Sunset
    Please write a tag for your note:
    - travel
    Sunset has been added as been created and saved in the database!



