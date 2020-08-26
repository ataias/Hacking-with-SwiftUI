#  Lessons Learned
- When using CoreData, if you get a "migration failed" the cause might be that the app on the phone or simulator has an old version of the model
  - one simple solution: delete the app and install again
  - if the migration is actually necessary (app already in prod), need to figure out how to do those migrations
