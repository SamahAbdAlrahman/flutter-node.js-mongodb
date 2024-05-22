const mongoose = require('mongoose');
const Schema = mongoose.Schema;


const sub = new mongoose.Schema({
    username: {
        type: Schema.Types.String,
        ref: 'User',
        required: true
      },
      title:String,
      startDate:Date,
      endDate:Date,
    

  
});

module.exports = mongoose.model('adminNotification', sub);
