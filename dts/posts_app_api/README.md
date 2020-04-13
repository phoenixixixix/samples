# README

## Task description
Task description can be found in [REQUIREMENTS.md](https://github.com/jetthoughts/samples/tree/master/dts/posts_app_api/doc/REQUIREMENTS.md)

The key point of this task is to design and implement an API for a hypothetical mobile app. Key endpoints for list of 
posts/comments and ability to like a post are implemented here and covered with request tests, while out of the scope things like users authentication 
endpoint is more like a mock up.

## Requirements

 * Ruby 2.6.5

## Setup

 * Install dependencies: `bundle install`
 * Setup local dev DB: `bin/rails db:setup`
 * Run the tests: `bin/rspec`
 * Start the app: `bin/rails s`
 
## API Endpoints

#### Sign in

Path: `/api/v1/sessions`

Method: `POST`

Requires authentication: `no`

Submit body schema: 
```json
{
  "type": "object",
  "required": ["email"],
  "properties": {
    "email": { "type": "string" }
  }
}
```

Response schema (on successful authentication):
```json
{
  "type": "object",
  "required": ["token"],
  "properties": {
    "token": { "type": "string" }
  }
}
```

Curl example (successful):
```bash
curl -d '{"email":"sara@example.com"}' -H "Content-Type: application/json" -X POST http://localhost:3000/api/v1/sessions

Response:
HTTP/1.1 200 OK
{"token":"oq5WWSZLCwN2u_-H"}
```

Curl example (unsuccessful):
```bash
curl -d '{"email":"non_existent@example.com"}' -H "Content-Type: application/json" -X POST http://localhost:3000/api/v1/sessions

Response:
HTTP/1.1 401 Unauthorized
{"message":"You need to be authenticated for this"}
```

#### Posts list

Path: `/api/v1/posts`

Method: `GET`

Requires authentication: `no`

Arguments:
 * `page` - (integer) page number to return from the collection
 * `per_page` - (integer) number of posts entries per page (upto 100)

Response schema:
```json
{
  "type": "object",
  "required": ["collection"],
  "properties": {
    "collection": {
      "type": "object",
      "required": ["data", "total_pages", "current_page"],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "type": "object",
            "required": ["id", "body", "likes_count", "published_at", "liked_by_me"],
            "properties": {
              "id": { "type": "integer" },
              "body": { "type": "string" },
              "likes_count": { "type": "integer" },
              "published_at": { "type": "date-time" },
              "liked_by_me": { "type": "boolean" }
            }
          }
        },
        "total_pages": { "type": "integer" },
        "current_page": { "type": "integer" }
      }
    }
  }
}
```

Curl example:
```bash
curl -H "Authorization: Token dWZJs82lVl2aFlG2" -H "Content-Type: application/json" http://localhost:3000/api/v1/posts?page=2
```
```json
{
  "collection": {
    "data": [
      {
        "id": 21,
        "body": "Consequat mauris nunc congue nisi vitae.",
        "likes_count": 4,
        "published_at": "2020-04-07T20:45:44.962Z",
        "liked_by_me": false
      },
      {
        "id": 22,
        "body": "Non pulvinar neque laoreet suspendisse interdum consectetur libero.",
        "likes_count": 1,
        "published_at": "2020-04-07T20:45:44.982Z",
        "liked_by_me": false
      },
      {
        "id": 23,
        "body": "Sollicitudin tempor id eu nisl nunc mi ipsum faucibus.",
        "likes_count": 0,
        "published_at": "2020-04-07T20:45:45.001Z",
        "liked_by_me": false
      },
      {
        "id": 24,
        "body": "Tortor condimentum lacinia quis vel eros donec.",
        "likes_count": 5,
        "published_at": "2020-04-07T20:45:45.019Z",
        "liked_by_me": true
      },
      {
        "id": 25,
        "body": "Netus et malesuada fames ac turpis egestas integer eget.",
        "likes_count": 2,
        "published_at": "2020-04-07T20:45:45.053Z",
        "liked_by_me": false
      },
      {
        "id": 26,
        "body": "Sem integer vitae justo eget magna fermentum.",
        "likes_count": 3,
        "published_at": "2020-04-07T20:45:45.073Z",
        "liked_by_me": false
      },
      {
        "id": 27,
        "body": "Posuere morbi leo urna molestie at.",
        "likes_count": 5,
        "published_at": "2020-04-07T20:45:45.096Z",
        "liked_by_me": true
      },
      {
        "id": 28,
        "body": "Nec nam aliquam sem et tortor consequat id porta nibh.",
        "likes_count": 0,
        "published_at": "2020-04-07T20:45:45.118Z",
        "liked_by_me": false
      },
      {
        "id": 29,
        "body": "Id donec ultrices tincidunt arcu non.",
        "likes_count": 1,
        "published_at": "2020-04-07T20:45:45.140Z",
        "liked_by_me": false
      },
      {
        "id": 30,
        "body": "Mattis molestie a iaculis at erat pellentesque adipiscing commodo.",
        "likes_count": 0,
        "published_at": "2020-04-07T20:45:45.161Z",
        "liked_by_me": false
      },
      {
        "id": 31,
        "body": "Dapibus ultrices in iaculis nunc.",
        "likes_count": 3,
        "published_at": "2020-04-07T20:45:45.182Z",
        "liked_by_me": false
      },
      {
        "id": 32,
        "body": "Ipsum suspendisse ultrices gravida dictum fusce ut placerat orci.",
        "likes_count": 5,
        "published_at": "2020-04-07T20:45:45.200Z",
        "liked_by_me": true
      },
      {
        "id": 33,
        "body": "Lorem ipsum dolor sit amet consectetur adipiscing elit.",
        "likes_count": 1,
        "published_at": "2020-04-07T20:45:45.217Z",
        "liked_by_me": false
      },
      {
        "id": 34,
        "body": "Sed faucibus turpis in eu mi bibendum neque egestas.",
        "likes_count": 4,
        "published_at": "2020-04-07T20:45:45.236Z",
        "liked_by_me": false
      },
      {
        "id": 35,
        "body": "Augue ut lectus arcu bibendum at varius vel.",
        "likes_count": 2,
        "published_at": "2020-04-07T20:45:45.253Z",
        "liked_by_me": false
      },
      {
        "id": 36,
        "body": "Tortor id aliquet lectus proin.",
        "likes_count": 1,
        "published_at": "2020-04-07T20:45:45.272Z",
        "liked_by_me": false
      },
      {
        "id": 37,
        "body": "In nulla posuere sollicitudin aliquam ultrices sagittis orci a.",
        "likes_count": 3,
        "published_at": "2020-04-07T20:45:45.290Z",
        "liked_by_me": false
      },
      {
        "id": 38,
        "body": "Habitasse platea dictumst vestibulum rhoncus est.",
        "likes_count": 1,
        "published_at": "2020-04-07T20:45:45.310Z",
        "liked_by_me": false
      },
      {
        "id": 39,
        "body": "Amet luctus venenatis lectus magna.",
        "likes_count": 5,
        "published_at": "2020-04-07T20:45:45.327Z",
        "liked_by_me": true
      },
      {
        "id": 40,
        "body": "Purus viverra accumsan in nisl nisi scelerisque eu ultrices vitae.",
        "likes_count": 0,
        "published_at": "2020-04-07T20:45:45.341Z",
        "liked_by_me": false
      }
    ],
    "total_pages": 3,
    "current_page": 2
  }
}
```

#### Post toggle like

Path: `/api/v1/posts/$post_id/toggle_like`

Method: `POST`

Requires authentication: `yes`

Arguments: `none`

Response: `HTTP/1.1 200 OK`

Curl example:
```bash
curl -H "Authorization: Token fNrGWfVy5N7eYg0d" -H "Content-Type: application/json" -X POST http://localhost:3000/api/v1/posts/19/toggle_like
```

#### Post comments

Path: `/api/v1/posts/$post_id/comments`

Method: `GET`

Requires authentication: `no`

Arguments:
 * `page` - (integer) page number to return from the collection
 * `per_page` - (integer) number of comments per page (upto 100)

Response schema:
```json
{
  "type": "object",
  "required": ["collection"],
  "properties": {
    "collection": {
      "type": "object",
      "required": ["data", "total_pages", "current_page"],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "type": "object",
            "required": ["id", "body", "created_at", "created_by"],
            "properties": {
              "id": { "type": "integer" },
              "body": { "type": "string" },
              "created_at": { "type": "date-time" },
              "created_by": {
                "type": "object",
                "required": ["id", "name"],
                "properties": {
                  "id": { "type": "integer" },
                  "name": { "type": "string" }
                }
              }
            }
          }
        },
        "total_pages": { "type": "integer" },
        "current_page": { "type": "integer" }
      }
    }
  }
}
```

Curl example:
```bash
curl -H "Content-Type: application/json" http://localhost:3000/api/v1/posts/19/comments
```
```json
{
  "collection": {
    "data": [
      {
        "id": 163,
        "body": "Comment #163",
        "created_at": "2020-04-07T20:45:51.529Z",
        "created_by": {
          "id": 1,
          "name": "John Doe"
        }
      },
      {
        "id": 164,
        "body": "Comment #164",
        "created_at": "2020-04-07T20:45:51.548Z",
        "created_by": {
          "id": 2,
          "name": "Jane Smith"
        }
      },
      {
        "id": 165,
        "body": "Comment #165",
        "created_at": "2020-04-07T20:45:51.569Z",
        "created_by": {
          "id": 3,
          "name": "Alice Jones"
        }
      },
      {
        "id": 166,
        "body": "Comment #166",
        "created_at": "2020-04-07T20:45:51.589Z",
        "created_by": {
          "id": 4,
          "name": "Victor Grenkin"
        }
      },
      {
        "id": 167,
        "body": "Comment #167",
        "created_at": "2020-04-07T20:45:51.608Z",
        "created_by": {
          "id": 5,
          "name": "Sara Jenkins"
        }
      },
      {
        "id": 168,
        "body": "Comment #168",
        "created_at": "2020-04-07T20:45:51.625Z",
        "created_by": {
          "id": 1,
          "name": "John Doe"
        }
      },
      {
        "id": 169,
        "body": "Comment #169",
        "created_at": "2020-04-07T20:45:51.643Z",
        "created_by": {
          "id": 2,
          "name": "Jane Smith"
        }
      },
      {
        "id": 170,
        "body": "Comment #170",
        "created_at": "2020-04-07T20:45:51.662Z",
        "created_by": {
          "id": 3,
          "name": "Alice Jones"
        }
      },
      {
        "id": 171,
        "body": "Comment #171",
        "created_at": "2020-04-07T20:45:51.684Z",
        "created_by": {
          "id": 4,
          "name": "Victor Grenkin"
        }
      }
    ],
    "total_pages": 1,
    "current_page": 1
  }
}
```
