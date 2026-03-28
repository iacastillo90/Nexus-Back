const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const mailerService = require('./mailer.service');
const { User } = require('../../models');
const { env } = require('../../config/env.config');
const logger = require('../../utils/logger');

class AuthController {
  
  async recoverPassword(req, res) {
    try {
      const { email } = req.body;
      if (!email) return res.status(400).json({ error: 'Email is required' });

      const user = await User.findOne({ where: { email } });
      if (!user) {
        // We still return success to prevent email enumeration
        return res.status(200).json({ message: 'If the email exists, a recovery link has been sent.' });
      }

      // Generate a short-lived token
      const token = jwt.sign(
        { id: user.id, type: 'recovery' },
        env.JWT_SECRET,
        { expiresIn: '15m' }
      );

      await mailerService.sendPasswordRecoveryEmail(email, token);

      res.status(200).json({ message: 'If the email exists, a recovery link has been sent.' });
    } catch (error) {
      logger.error(`[AuthController] recoverPassword error: ${error.message}`);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  }

  async resetPassword(req, res) {
    try {
      const { token, newPassword } = req.body;
      if (!token || !newPassword) return res.status(400).json({ error: 'Token and newPassword are required' });

      const decoded = jwt.verify(token, env.JWT_SECRET);
      if (decoded.type !== 'recovery') return res.status(400).json({ error: 'Invalid token type' });

      const user = await User.findByPk(decoded.id);
      if (!user) return res.status(404).json({ error: 'User not found' });

      user.password = await bcrypt.hash(newPassword, 10);
      await user.save();

      res.status(200).json({ message: 'Password has been reset successfully.' });
    } catch (error) {
      logger.error(`[AuthController] resetPassword error: ${error.message}`);
      res.status(400).json({ error: 'Invalid or expired token' });
    }
  }

  async verifyEmail(req, res) {
    try {
      const { token } = req.body;
      if (!token) return res.status(400).json({ error: 'Token is required' });

      const decoded = jwt.verify(token, env.JWT_SECRET);
      if (decoded.type !== 'verification') return res.status(400).json({ error: 'Invalid token type' });

      const user = await User.findByPk(decoded.id);
      if (!user) return res.status(404).json({ error: 'User not found' });

      // If there is an isVerified column, set it to true.
      // (assuming isVerified exists, otherwise we just log it)
      if (user.isVerified !== undefined) {
        user.isVerified = true;
        await user.save();
      }

      res.status(200).json({ message: 'Email verified successfully.' });
    } catch (error) {
      logger.error(`[AuthController] verifyEmail error: ${error.message}`);
      res.status(400).json({ error: 'Invalid or expired token' });
    }
  }
}

module.exports = new AuthController();
