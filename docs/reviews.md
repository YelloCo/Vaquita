### Summary

Everytime a repository finishes syncing a code difference, a review is created in the application.

### Assignment

Reviews are not assigned and any user in the application can complete a review.

### Issues

An issue can be created if there was something wrong in the code review. This is a simple field to keep a note for future reference. For example, you could keep a link to an external ticket tracking system in this field.

The number of issues are tracked for each review and in the system as a whole.

### Review Names

The review name shows the branch and specific commit the review was performed on. If you would like to manually generate a code diff between two commits, take the two commits and run the following command on the latest branch:

`git diff PREVIOUS_COMMIT..LATEST_COMMIT`

If you also want to include the filters, append each option to the command with `':!filter'`:

`git diff PREVIOUS_COMMIT..LATEST_COMMIT -- . ':!/spec/**/*' ':!.css'`