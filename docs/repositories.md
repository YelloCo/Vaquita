### Syncing (Directory)

If you'd like to use a non-remote, on-server repository, the repository must be accessible from the web application.

For example, you could clone your `Catz` repository to the location `/repos/catz` and ensure the application's user has permissions to read and write to this folder.

Otherwise, use a remote repository with an access token as outlined in the guide when creating a new repository.

### Branch

This is the prefix of the branch you want to compare against. This is likely to be `master` but your development cycle could use a different format.

For example, using the branch `/release/` will cause the application to pull the latest branch that matches `/release/*` and use the latest commit in that branch to use for comparison.
In this example, we could hypothetically have this happen (assuming a daily frequency):

*  `release/100` is synced and compared against last commit
*  `release/101` is created and thus synced the next day, and the latest commit is compared with the last synced commit from yesterday
*  `release/101` is synced and if there are newer commits from the last sync, the lastest commit is compared from yesterday

### Custom Filters

Since many of the changes in a code review might not be relevant, you can use [pathspecs](https://git-scm.com/docs/gitglossary#gitglossary-aiddefpathspecapathspec) here to exclude them from the final review.

For example, when doing a security-related review you might not care about items that match these expressions:

```
spec/**
config/locales/**/*.yml
*.css
```

_Note: these need to be newline-separated_