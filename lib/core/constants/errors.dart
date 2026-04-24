final Map<String, Map<String, String>> errorMap = {
  "INTERNAL_SERVER_ERROR": {
    "title": "Server Error",
    "description": "Something went wrong on our end. Please wait a moment and try again."
  },
  "THROTTLED": {
    "title": "Too many Requests",
    "description": "Rate limit exceeded (429). You're moving a bit too fast. Please wait a moment before trying again."
  },
  "PARSE_ERROR": {
    "title": "Data Parse Error",
    "description": "The synchronization handshake failed due to a malformed payload. The incoming data packet structure is incompatible."
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
    "description": "We couldn't verify your credentials. Please check your email and password."
  }
};