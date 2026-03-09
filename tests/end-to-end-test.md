# end-to-end-test.md

## End-to-End Test Plan
1. Access the application using the ALB DNS name
2. Verify the HTML page loads
3. Verify `/api/stats` returns JSON
4. Verify `/health` returns healthy status

## Expected Result
The request should successfully traverse presentation, application, and data layers.
