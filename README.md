# reserved_seating_api
This is a repo for testing purpose only

## Pre-requisites

- Create a Postgresql database with name `reserved_seating`
- Create this environment variables
    - DATABASE_URL (Optional). If this is setted, you don't need the following variables
    - DATABASE_USERNAME
    - DATABASE_PASSWORD
- That's it.

## How to run the app locally

This is a Rails app. You just only need to run `rails s` in the root folder.

## API Documentation

Hint: params in **bold** are required

### Create movies

#### Endpoint

    POST /movies

#### Parameters
- **name**: String
- **description**: String
- **days**: String (must have day names comma separated and name must have three first letters in downcase)
- image_url: String

#### Request Body

    {
      "name": "Jocker",
      "description": "This is a great movie",
      "image_url": "https://via.placeholder.com/64",
      "days": "mon,tue,wed,thu,fri,sat,sun"
    }

#### Response Body

    {
      "id": 1,
      "name": "Jocker",
      "description": "This is a great movie",
      "image_url": "https://via.placeholder.com/64",
      "days": "mon,tue,wed,thu,fri,sat,sun"
    }

### List movies

#### Endpoint

    GET /movies?day=mon

#### Parameters
- **day**: String

#### Response Body

    [
      {
        "id": 1,
        "name": "Jocker",
        "description": "This is a great movie",
        "image_url": "https://via.placeholder.com/64",
        "days": "mon,tue,wed,thu,fri,sat,sun"
      },
      {
        "id": 2,
        "name": "Inception",
        "description": "This is a great movie",
        "image_url": "https://via.placeholder.com/96",
        "days": "thu,fri,sat,sun"
      }
    ]
      

### Create reservations

#### Endpoint

    POST /reservations

#### Parameters
- **movie_id**: Integer
- **date**: String
- **seats**: Integer
- client_fullname: String

#### Request Body

    {
      "movie_id": 1,
      "date": "2020-03-22",
      "client_fullname": "John Doe",
      "seats": 2
    }

#### Response Body

    {
      "id": 1,
      "movie_id": 1,
      "date": "2020-03-22",
      "seats": 2
    }

### List reservations

#### Endpoint

    GET /reservations?start_date=2020-03-22&end_date=2020-03-31

#### Parameters
- **start_date**: String
- **end_date**: String

#### Response Body

    [
      {
        "id": 1,
        "movie_id": 1,
        "date": "2020-03-22",
        "seats": 2
      },
      {
        "id": 2,
        "movie_id": 1,
        "date": "2020-03-22",
        "seats": 4
      },
      {
        "id": 3,
        "movie_id": 2,
        "date": "2020-03-24",
        "seats": 8
      }
    ]
