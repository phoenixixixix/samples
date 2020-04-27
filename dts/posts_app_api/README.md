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

Paths: 
 - `/api/v1/posts`
 - `/api/jbuilder/posts`
 - `/api/jbuilder_fragment_cache/posts`
 - `/api/simple_serializer/posts`
 - `/api/simple_serializer_cached/posts`
 - `/api/fast_jsonapi_serializer/posts`
 - `/api/fast_jsonapi_serializer_cached/posts`
 - `/api/fast_jsonapi_serializer_cached_http_cache/posts`

Method: `GET`

Requires authentication: `no`

Arguments:
 * `page` - (integer) page number to return from the collection

Response schema:
```json
{
  "type": "object",
  "required": ["data", "meta"],
  "properties": {
    "data": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["id", "type", "attributes"],
        "properties": {
          "id": { "type": "string" },
          "type": { "type": "string" },
          "relationships": { "type": "object" },
          "attributes": {
            "type": "object",
            "required": ["body", "likes_count", "published_at"],
            "properties": {
              "body": { "type": "string" },
              "likes_count": { "type": "integer" },
              "published_at": { "type": "date-time" }
            }
          }
        }
      }
    },
    "meta": {
      "type": "object",
      "required": ["total_count"],
      "properties": {
        "total_count": { "type": "integer" }
      }
    }
  }
}
```

Curl example:
```bash
curl -H "Content-Type: application/json" http://localhost:3000/api/v1/posts?page=2
```
```json
{
  "data": [
    {
      "id": "500",
      "type": "post",
      "attributes": {
        "id": 500,
        "body": "Ipsum suspendisse ultrices gravida dictum fusce ut placerat orci. Lorem ipsum dolor sit amet consectetur adipiscing elit.",
        "likes_count": 22,
        "published_at": "2020-04-26T20:48:40.901Z"
      },
      "relationships": {}
    },
    {
      "id": "499",
      "type": "post",
      "attributes": {
        "id": 499,
        "body": "Sed faucibus turpis in eu mi bibendum neque egestas. Augue ut lectus arcu bibendum at varius vel.",
        "likes_count": 23,
        "published_at": "2020-04-26T20:48:40.897Z"
      },
      "relationships": {}
    }
  ],
  "meta": {
    "total_count": 1000
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

#### Current user likes

Path: `/api/v1/my_likes`

Method: `GET`

Requires authentication: `yes`

Arguments:
 * `page` - (integer) page number same as for posts

Response schema:
```json
{
  "type": "object",
  "required": ["liked_posts"],
  "properties": {
    "liked_posts": {
      "type": "array",
      "items": { "type": "integer" }
    }
  }
}
```

Curl example:
```bash
curl -H "Authorization: Token tDDozs_X6mUK-p3k" -H "Content-Type: application/json" http://localhost:3000/api/v1/my_likes
```
```json
{
  "liked_posts": [503,505,507,510,512,515,521,524,528,529,530]
}
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
