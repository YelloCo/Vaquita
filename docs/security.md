### Sessions

Sessions are created through the default Rails 5 manner. The session cookie is encrypted using the secret key base value set in your Settings [link here] configuration file.

### Password security

Passwords are hashed using Bcrypt and an increased cost factor of 12 (default is 10). This significantly increases the time to hash a password and subsequently increases the response time when logging in, but we believe this is an important security benefit that is worth the user experience cost. Passwords are also hashed using a pepper. This means that all passwords are appended to a constant application-wide value before being hashed. If an attacker were to get access to only the database and the hashed passwords, these hashes would be worthless without the pepper value that is configured in the application.

### Information stored in the application

When generating code differences, the resulting code difference summary is stored in this application's database. If sensitive information or credentials are stored in a synced repository, they could end up in this application's database.

The only PII that is collected is a user's email address.

### Reporting a security bug

If you notice a vulnerability or weak security control somewhere in the application, please open an issue on Github or send an email to `security@yello.co`. If this is critical vulnerability, we ask that you please email us before making any information public so we can quickly fix the issue and release an update to users to minimize their risk exposure.