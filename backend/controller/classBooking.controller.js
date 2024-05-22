const BookingService = require('../services/classBooking.service');
const User = require('../model/users.model'); // Import the User model

class BookingController {
  async createBooking(req, res) {
    try {
      console.log('Decoded Token:', req.decoded);

      // Get the username from the decoded token (assuming you have a middleware for authentication)
      const username = req.decoded.username;

      // Find the user in the database to get their ObjectId
      const user = await User.findOne({ username });

      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }

      const bookingData = req.body;
      // Set the username field with the ObjectId of the user
      bookingData.username = user.username;

      const savedBooking = await BookingService.createBooking(bookingData);
      res.status(201).json(savedBooking);
    } catch (error) {
      console.error('Error creating booking:', error);

      res.status(400).json({ error: 'Failed to create booking' });
    }
  }
}

module.exports = new BookingController();
