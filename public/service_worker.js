console.log("HI from the service worker");

// serviceworker.js
// The serviceworker context can respond to 'push' events and trigger
// notifications on the registration property
self.addEventListener("push", (event) => {
    let title = (event.data && event.data.text()) || "Yay a message";
    let body = "You have received a push message";
    let tag = "push-simple-demo-notification-tag";
  
    event.waitUntil(
      self.registration.showNotification(title, { body, tag })
    )
  });