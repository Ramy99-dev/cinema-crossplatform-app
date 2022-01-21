const admin = require("firebase-admin") ;
const serviceAccount = require("./flutter-cinema-app-firebase-adminsdk-ph7bk-fcde769962.json")

admin.initializeApp({
credential :admin.credential.cert(serviceAccount) ,
});

 async function sendNotification(movie)
{
    const registrationToken = 'cxY1gQapTwafhg0j2wYS19:APA91bEus-wlZfW3q0r1MVNS9d_Z8MieyYWlQHUJ2qvUMXgwDg4AilSetQLBhMbHIyKuZkmrDwrAJWNvhPqYEBzzTlvf8ATnTqOG3sS_rMqZyoOHNYax3jNnp4ZUVnZkEK_TMLv5cCJa';
    const notification_options = {
        priority: "high",
        timeToLive: 60 * 60 * 24
      };

      const message = {
        notification:{
            title:"Cinema App",
            body:`New Movie is added : ${movie}`
        }
    }
admin.messaging().sendToDevice(registrationToken, message, notification_options)
.then( response => {

  console.log("Notification sended")
})
.catch( error => {
    console.log(error);
});



}

module.exports={sendNotification}



