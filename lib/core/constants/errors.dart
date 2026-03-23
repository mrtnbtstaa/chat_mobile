final Map<String, Map<String, String>> errorMap = {
  "INTERNAL_SERVER_ERROR": {
    "title": "Server Error",
    "description": "Something went wrong on our end. Please try again later."
  },
  "THROTTLED": {
    "title": "Too many Requests",
    "description": "You're moving a bit too fast. Please wait a moment before trying again."
  },
  "PARSE_ERROR": {
    "title": "Data Error",
    "description": "We couldn’t process the server response. Please try again."
  },
  "BAD_REQUEST": {
    "title": "Invalid Information",
    "description": "Some of the details provided are incorrect. Please check your input and try again."
  },
  "NOT_FOUND": {
    "title": "Page Not Found",
    "description": "The resource you are looking for doesn't seem to exist or has been removed."
  },
  "UNAUTHORIZED": {
    "title": "Session Expired",
    "description": "Your session has timed out for security reasons. Please log in again to continue."
  },
  "UNAUTHORIZED_": {
    "title": "Login Failed",
    "description": "We couldn't verify your credentials. Please check your username and password"
  }
};