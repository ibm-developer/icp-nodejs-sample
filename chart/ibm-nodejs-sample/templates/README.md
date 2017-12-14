The tests folder contains the tests used for a production image.

These will be picked up by `helm test`.

dev-only-tests contain the tests used for a development image and will NOT be picked up by `helm test` but serve two purposes.
- These are the tests pointing to the development image.
- We can easily keep track of the ones we really want for production and the ones that are only for our development/testing.



