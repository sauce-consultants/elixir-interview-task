# Phoenix JSON-API

This Phoenix project is a simple JSON-API back end application that handles
a list of Companies and their employees.

## Install Elixir / Phoenix

- Follow guide here - [`https://elixir-lang.org/install.html`](https://elixir-lang.org/install.html)

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`

## Seeds

If you don't already have any data, you can run the seeds.

- Run seeds `mix run priv/repo/seeds.exs`

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
- JSON-API Spec: https://jsonapi.org/

## API calls (Curl)

Below are a list of Curl commands you can run to the various endpoints

### Companies

#### List

```
curl "http://localhost:4000/api/companies" \
  -H 'Content-Type: application/vnd.api+json' \
  -H 'accept: application/vnd.api+json'
```

#### Show

```
curl "http://localhost:4000/api/companies/1" \
  -H 'Content-Type: application/vnd.api+json' \
  -H 'accept: application/vnd.api+json'
```

#### Create (not currently working)

```
curl -X "POST" "http://localhost:4000/api/companies" \
     -H 'Content-Type: application/vnd.api+json' \
     -H 'accept: application/vnd.api+json' \
     -d $'{
  "format": "json-api",
  "data": {
    "type": "companies",
    "attributes": {
      "name": "Sauce Two",
      "address-line-1": "First address",
      "postcode": "HU1 1UU"
    }
  }
}'

```

#### Update (not currently working)

```
curl -X "PUT" "http://localhost:4000/api/companies/3" \
     -H 'Content-Type: application/vnd.api+json' \
     -H 'accept: application/vnd.api+json' \
     -d $'{
  "format": "json-api",
  "data": {
    "type": "companies",
    "attributes": {
      "name": "Sauce Five",
      "address-line-1": "First address",
      "postcode": "HU1 1U"
    }
  }
}'

```

### Employees

#### List Employee

List Employee without Company Data:

```
curl "http://localhost:4000/api/employees" \
     -H 'Content-Type: application/vnd.api+json' \
     -H 'accept: application/vnd.api+json'
```

List Employee with Company Data:

```

curl "http://localhost:4000/api/employees?include=company" \
 -H 'Content-Type: application/vnd.api+json' \
 -H 'accept: application/vnd.api+json'

```

#### Show Employee

```
curl "http://localhost:4000/api/employees/1" \
 -H 'Content-Type: application/vnd.api+json' \
 -H 'accept: application/vnd.api+json'

```

#### Update Employee

```
curl -X "PUT" "http://localhost:4000/api/employees/1" \
     -H 'Content-Type: application/vnd.api+json' \
     -H 'accept: application/vnd.api+json' \
     -d $'{
  "format": "json-api",
  "data": {
    "type": "employees",
    "attributes": {
      "first-name": "Sauce Five"
    }
  }
}'
```

#### Delete Employee

```
curl -X "DELETE" "http://localhost:4000/api/employees/1" \
     -H 'Content-Type: application/vnd.api+json' \
     -H 'accept: application/vnd.api+json' \
     -d $'{}'
```

## Tests

This project comes with a small test suite

To run your tests:

- `mix test`

## Inteview Tasks

We'd like you to clone this repo on your own GitHub account. Make sure it's set
to private. Get the app running on your machine and then work through the list
of tasks.

Each task should be submitted to your repo as a pull request before you approve
and merge into the master branch. Pull requests should contain a good summary
of the code that is being changed and why

## Bugs / Feature Requests

### Task 1

A bug has been reported that the API allows for Employees with non-unique email
addresses to be inserted. Resolve the issue by validating that any new
employees added to the database are using a unique email address. Throw a 422
HTTP error is the email address is not unique.

### Task 2

Currently it is possible create, update and delete employees, however we now
also need the API to allow users to create, update and delete companies.

### Task 3

The client would like to be able to store a second address line against the
company table. This needs to be accessible via the API also.

### Task 4

The client has asked us to store the first part of the employees postcode To
get a rough idea how far people are travelling to work.
The client is concerned though that some people will attempt to store both
parts of the postcode, which may cause GDPR issues, so we need to clean the
postcode data before inserting / updating it into the database.

e.g. HU1 1UU should be stored as HU1

Store the data in a new field postcode_area and make it available in the API

