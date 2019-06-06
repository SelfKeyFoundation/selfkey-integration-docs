# Errors


The SelfKey API uses the following error codes:


Error Code | Meaning
---------- | -------
400 | Bad Request -- Missing authorization header.
401 | Not Authorized -- Authentication token invalid, malformed authorization header, or missing nonce claim.
403 | Forbidden -- Insufficient permissions.
404 | File Not Found -- Not found
422 | Bad Payload -- Many possibilities: Invalid file, referenced files not found, invalid signature, or invalid public key.
