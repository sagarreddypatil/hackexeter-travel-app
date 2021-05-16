# hackexter-travel-app

## To run the backend:

The environment variable `MONGO_CONNECTION_STRING` needs to be set with a valid (with password) connection string to a MongoDB database. Once the variable is set, open the backend folder and run:

```
$ npm start
```

This should start the backend server on port 3001.

## To run the frontend

Open the frontend folder in either VSCode with the Flutter extension or in IntelliJ/Android Studio with the Flutter Extension. Set an environment variable `API_URL` with the URL of the running backend from earlier and then run the app.
