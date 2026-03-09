# traffic-flow-test.md

## Planned Validation
- Internet client sends HTTP request to ALB
- ALB forwards request to app tier
- App tier returns response and simulates data retrieval from data tier

## Expected Result
Traffic should flow only through the intended layers:
Internet -> ALB -> App Tier -> Data Tier
