### Summary

Configuration that is tied to the entire application. These settings include sensitive information.

### Configuring

Since these settings require unique and confidential values, you will need to configure them before starting the application.

In the `config` folder you will find an example of the configuration at `settings.yml`. It is highly suggested you copy this template and save it to a file called `settings.local.yml` to prevent it from accidentally being checked into Git.

*  auth.pepper: The pepper value used for password hashing. Once this value is set, you cannot change it or else all previous passwords will not work.
*  auth.secret: The key used for Rails to encrypt session information. This is a highly sensitive secret and should contain at least 30 characters.
*  vaquita.host: The hostname of the server that the application is running on.
*  vaquita.time_zone: The local time zone the server is running on.
*  vaquita.email_from: The email address that is sending all emails throughout the application.

### Considerations

All email is configured with sendmail. If you need to use a remote relay through the application, configure postfix locally to handle it or edit the source code manually.