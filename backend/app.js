const express = require("express");
const cors = require('cors'); // Import the 'cors' package
const bodyParser = require("body-parser");
const app = express();
app.use(cors());
app.use(bodyParser.json());
var paypal = require('paypal-rest-sdk');
const commentRoutes = require('./routes/comment.router');

//const UserRoute = require("./routes/user.routes");
const ToDoRoute = require('./routes/todo.router');
const exerciseController = require('./controller/exerciseController');
const exerciseController1 = require('./controller/getintermediate.controller');
const exerciseController2 = require('./controller/getAdvanced.controller');
const exerciseController3 = require('./controller/getYoga.controller');
//
const getmeals = require('./controller/getMeals.controller');
 //
 app.use('/getmeals', getmeals);
 //
//
const getClasses = require('./controller/getClasses.controller');
const getallSub = require('./controller/getallSubscribtion.controller');
const getAdminNotification = require('./controller/getadminnotification.controller');
const fetchUserSub = require('./controller/fetchUserSubscribtion.controller');
const fetchUserBook = require('./controller/fetchUserBook.controller');
const mealRoutes = require('./routes/mealRoutes');
app.use(bodyParser.json())
app.use('/', commentRoutes);
app.use('/meal', mealRoutes);
const admin = require('./firebaseAdmin');
 app.use("/",ToDoRoute);
 app.use('/getadminNotification', getAdminNotification);
 app.use('/beginnerexercises', exerciseController);
 app.use('/intermediateexercises', exerciseController1);
 app.use('/Advancedexercises', exerciseController2);
 app.use('/yogaexercises', exerciseController3);

 app.use('/getClasses', getClasses);
 app.use('/getallSub', getallSub);
 app.use('/fetchUserSub', fetchUserSub);
 app.use('/fetchUserbook', fetchUserBook);


 app.use("/uploads", express.static("uploads"));

 const userRoute = require("./routes/user");
app.use("/user", userRoute);
const profileRoute = require("./routes/profile");
app.use("/profile", profileRoute);
const employeeRoute = require("./routes/employee");
app.use("/employee", employeeRoute);
const blogRoute = require("./routes/blogpost");
app.use("/blogPost", blogRoute);

const adminRoute = require("./routes/admin")
app.use("/admin", adminRoute);

app.post('/send-notification', (req, res) => {
    const { token, title, body } = req.body;
  
    const message = {
        notification: {
          title: 'Notification Title',
          body: 'Notification Body',
        },
        token: 'YOUR_DEVICE_TOKEN',
      };
      
      admin.messaging().send(message)
        .then((response) => {
          console.log('Notification sent:', response);
        })
        .catch((error) => {
          console.error('Error sending notification:', error);
        });
      
  });
 
module.exports = app;