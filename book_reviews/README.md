# README

Features in this app:
* Ruby version
* System dependencies
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
* ...

Option 2: Book reviews

Create an application that allows people to review their favourite books. Include features that allow:

1. Visitors to open a simple static HTML page, about.html, that includes the title of the project option, a brief description of what the website is for and who built it. This page does not need to include any of the bootstrap styling indicated below.
2. Visitors to register and log in as a User with their :email using a basic sign up and log in form. Use a model named User for this task.
3. Users to create Reviews that includes information about the book: a :book_title, a  :body, an :image_url for the book review, and an :author (i.e. the author of the book being reviewed). Use a model called Review for this task. The Review needs to be associated with the User that created it.
4. Visitors to view the six most-recently created Reviews on the homepage / root path.
5. Visitors to search for Reviews with a search term that will match on either :title or :author from a form on the homepage. The form should submit in a way that the URL for any particular search can be copied and sent to others.
6. Visitors to view all of the details for a Review plus all Comments related to that Review on one view. The :title, :body, and :author should be displayed as text and the :image_url used to display the image at that URL. This view will be linked from the individual Reviews displayed on the search results view.
7. Users to edit all details of a Review by clicking on a link from the “Show review” view.
8. Users to save new or updated Reviews only if a :title is provided i.e. :title is required, and that an :author is no longer than 100 characters in length, although a :author is optional. Any validation errors should be displayed helpfully for User.
9. Users to add a comment on the “show review” view when they are signed in. Use a model named Comment for this task. The Comment needs to be associated with the Review that it was created from and the User that created it.
10. Users to add any Review created by any User to their "bookmarked Reviews list" from the show Review view. It should not be possible to add a Review more than once. Their bookmarked Review list should be available on a separate view, listing all of the Reviews that they’ve saved. A link to the form to create a new Review needs to be included on this view.
11. Visitors to have a link to the homepage, the about page, and the login/register view in the header of every view.
12. Users to have a link to the homepage, the about page, and their bookmarked reviews list in the header of every view.
