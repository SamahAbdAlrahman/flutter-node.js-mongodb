const mongoose = require('mongoose');
const Schema = mongoose.Schema;


const sub = new mongoose.Schema({
    username: {
        type: Schema.Types.String,
        ref: 'User',
        required: true
      },
      startDate:Date,
      endDate:Date,
      price:String,
      month:String,

  
});

module.exports = mongoose.model('AllSubscribtions', sub);
