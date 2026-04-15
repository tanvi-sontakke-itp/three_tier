#Three-Tier Architecture in Azure

Security Implemented:
- NSGs: internet -> HTTP, internet -> HTTPS with the help of certificates to encrypt traffic. the cert ensures that the server can be trusted. tls handshake needs the cert. 
- backend nsgs (app gateway -> port 3000, backend -> postgresql, block internet ->vmss)
- ensure vmss access internet via nat
- postgresql not publicly accessible and is accessed using a priv endpt
- added jet auth to protect api (prevent unauthorized api requests, protect db operations) -> ensure that only authenticated and authorized clients can access protected tokens using a cryptographically signed token. client sends the JWT in the Authorization: Bearer <token> header for each request. API server verifies the token’s signature and verifies the token integrity then grants access.
- sql queries use parameterized statements preventing SQLi
