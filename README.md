
# RubberDuck It: Server Side
A custom API made with Express.js as the backend to the 'RubberDuck It' project.

## Project Links
* [Front End Repo](https://github.com/srsexton94/rubberduckit-client)
* [Front End Deploy](https://srsexton94.github.io/rubberduckit-client)
* [Back End Deploy](https://rubberduckit-api.herokuapp.com/)

<!-- need to clean up Dependencies list to... just be Dependencies -->
## Dependencies (Set up & Installation)
* [GA Rails API Template](https://git.generalassemb.ly/ga-wdi-boston/rails-api-template) Includes authentication.
  -  See also [rails-api-examples-walkthrough](https://git.generalassemb.ly/ga-wdi-boston/rails-api-examples-walkthrough)
* `bundle install`
* `git init`, `git add`, `git commit`
* `bundle exec rails secret` (to generate secret keys)

<!--
* Setup your database:
    - bin/rails db:drop (if it already exists)
    - bin/rails db:create
    - bin/rails db:migrate
    - bin/rails db:seed
    - bin/rails db:examples
    - **Note**: Do this for each database you want to set up. Your local database and production (Heroku) database will both need to be set up in this way!
    - **See Also** [rails-heroku-setup-guide](https://git.generalassemb.ly/ga-wdi-boston/rails-heroku-setup-guide)
* `bin/rails...`
  - `...server` or `bundle exec rails server` to run server
  - `...routes` lists the endpoints available in your API.
  - `...console` opens a REPL that pre-loads the API.
  - `...db` opens your database client and loads the correct database.
* `bin/rspec spec` runs automated tests located in the `spec` folder.
* `curl-scripts/*.sh` run various `curl` commands to test the API. See below.
* Resetting Database without dropping
  - without completely [resetting the database](https://edgeguides.rubyonrails.org/active_record_migrations.html#resetting-the-database)...
  - roll back to a specific migration, specify the `VERSION` the database should revert to
  - To rerun _all_ migrations, starting from `VERSION=0`, you would do:
```sh
bin/rails db:migrate VERSION=0
bin/rails db:migrate db:seed db:examples
```
or
```sh
heroku run rails db:migrate VERSION=0
heroku run rails db:migrate db:seed db:examples
```
-->

## Technologies
-   [Rails](https://github.com/rails/rails)
-   [Ruby](https://www.ruby-lang.org/en/)
-   [PostgreSQL](http://www.postgresql.org)
-   [rails-api](https://github.com/rails-api/rails-api)
-   [Active_Model_Serializers](https://github.com/rails-api/active_model_serializers)
-   [RSpec](https://github.com/rspec/rspec-rails)
-   [cURL](https://github.com/curl/curl)

## User Stories
- As a user I want to be able to have a text conversation with the RubberDuck chatbot
- As an unregistered user I want to be able to sign up/create an account
- As a registered user I want to be able to sign in
- As a signed-in user I want to be able to...
  - update my account information & sign out
  - save my RubberDuck conversation
  - view all of my saved conversations
  - view a specific saved conversation
  - change the title of a conversation
  - *Stretch*? Pick up on a saved conversation
  - delete a saved conversation

## Project Structure
#### MVP:
* Provide sign up/in/out & change password functionality
* Present a useable chatbot with a rubber duck image
* CRUD on a 'conversation' resource for authenticated users

#### Moderate Stretch Goals:
* Offer search bar & solved/unsolved/all nav bar
* Offer a "return to convo" link on the save (POST) page
* Offer a "stats" view where users can access various data visualizations on their entries

#### Stretch "For the Stars!" Goals:
* Offer google/facebook authentication
* Offer "forgot password" option for un-signed in users

## Entity Relationship Diagram
...
<!-- need to recreate -->

## API Documentation

### Authentication Endpoints

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/sign-up`             | `users#signup`    |
| POST   | `/sign-in`             | `users#signin`    |
| PATCH  | `/change-password`     | `users#changepw`  |
| DELETE | `/sign-out`        | `users#signout`   |

### Conversation Endpoints

| Verb   | URI Pattern            | Controller#Action       |
|--------|------------------------|-------------------------|
| GET    | `/conversations`       | `conversations#index`   |
| GET    | `/conversations/:id`   | `conversations#show`    |
| POST   | `/conversations`       | `conversations#create`  |
| PATCH  | `/conversations/:id`   | `conversations#update`  |
| DELETE | `/conversations/:id`   | `conversations#destroy` |

## Problem Solving
...

## Areas for Growth
...
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'",
      "password_confirmation": "'"${PASSWORD}"'"
    }
  }'
```

```sh
EMAIL=ava@bob.com PASSWORD=hannah curl-scripts/auth/sign-up.sh
```

Response:

```md
HTTP/1.1 201 Created
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "ava@bob.com"
  }
}
```

#### POST /sign-in

Request:

```sh
curl http://localhost:4741/sign-in \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'"
    }
  }'
```

```sh
EMAIL=ava@bob.com PASSWORD=hannah curl-scripts/auth/sign-in.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "ava@bob.com",
    "token": "BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f"
  }
}
```

#### PATCH /change-password

Request:

```sh
curl --include --request PATCH "http://localhost:4741/change-password" \
  --header "Authorization: Token token=$TOKEN" \
  --header "Content-Type: application/json" \
  --data '{
    "passwords": {
      "old": "'"${OLDPW}"'",
      "new": "'"${NEWPW}"'"
    }
  }'
```

```sh
OLDPW='hannah' NEWPW='elle' TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' sh curl-scripts/auth/change-password.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

#### DELETE /sign-out

Request:

```sh
curl http://localhost:4741/sign-out \
  --include \
  --request DELETE \
  --header "Authorization: Token token=$TOKEN"
```

```sh
TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' sh curl-scripts/auth/sign-out.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

### Keeping your database up to date

Remember, creating and applying [migrations](https://edgeguides.rubyonrails.org/active_record_migrations.html#creating-a-migration) are two different things. After you create a migration (one of those files that lives in `db/migrate/`), you need to apply it to each database using `bin/rails db:migrate` (local) or `heroku run rails db:migrate` (production).

### Rolling Back a Database Migration

Sometimes you need to revert a migration that you already applied. There are many ways to revert your database to a previous state, and one of the most common is simply rolling back (reverting) the last migration that you ran. Read more in the [Rails Guide](https://edgeguides.rubyonrails.org/active_record_migrations.html#rolling-back)

### Reset Database without dropping

If you don't want to completely [reset the database](https://edgeguides.rubyonrails.org/active_record_migrations.html#resetting-the-database) (maybe you have data you want to preserve?), you have other, less destructive options. One is rolling back a specific migration by specifying the `VERSION` that the database should revert to. Ask a consultant if you need assistance, as **database commands like these are non-reversable.**

To rerun _all_ migrations, starting from `VERSION=0`, you would do:


```sh
bin/rails db:migrate VERSION=0
bin/rails db:migrate db:seed db:examples
```

To run this command (and others like this) on Heroku, just append `heroku run` before the `rails` command.



## Additional Resources
- [rails-heroku-setup-guide](https://git.generalassemb.ly/ga-wdi-boston/rails-heroku-setup-guide)
- [Rails Guides: API-only app](http://guides.rubyonrails.org/api_app.html)
- [Building a JSON API with Rails 5](https://blog.codeship.com/building-a-json-api-with-rails-5/)

## [License](LICENSE)

1.  All content is licensed under a CC­BY­NC­SA 4.0 license.
1.  All software code is licensed under GNU GPLv3. For commercial use or
    alternative licensing, please contact legal@ga.co.
