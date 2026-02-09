---
name: validate
description: Manually test your work against the locally running app by making real API or HTTP requests.
user_invocable: true
---

Validate the changes you've made by testing them against the locally running application:

1. Figure out what you changed and what needs testing — review recent diffs or your current task context.
2. Determine how to reach the app (check for running servers, common ports, env files, docker-compose, etc.).
3. Make real requests using `curl`, `httpie`, or similar tools to exercise the affected endpoints or functionality.
4. Verify the responses are correct — check status codes, response bodies, error cases, and edge cases.
5. If something is broken, fix it and re-test.
6. Report a summary of what you tested and the results.

Be thorough: don't just hit the happy path. Test error cases, missing fields, invalid input, and boundary conditions where relevant.
