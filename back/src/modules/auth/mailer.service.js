const nodemailer = require('nodemailer');
const { env } = require('../../config/env.config');
const logger = require('../../utils/logger');

class MailerService {
  constructor() {
    this.transporter = nodemailer.createTransport({
      host: env.SMTP_HOST || 'smtp.sendgrid.net',
      port: env.SMTP_PORT || 587,
      auth: {
        user: env.SMTP_USER || 'apikey',
        pass: env.SMTP_PASS, // Add to env
      },
    });
  }

  async sendPasswordRecoveryEmail(to, token) {
    const recoveryLink = `https://nexus-social.com/recover-password?token=${token}`;
    const mailOptions = {
      from: '"Nexus Social" <noreply@nexus-social.com>',
      to,
      subject: 'Recuperación de Contraseña - Nexus',
      html: `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #333; background-color: #050505; color: #fff;">
          <h2 style="color: #00E5FF; text-align: center;">Nexus: Consciencia Digital</h2>
          <p>Hemos recibido una solicitud para restablecer tu contraseña.</p>
          <p>Haz clic en el siguiente enlace para crear una nueva contraseña:</p>
          <div style="text-align: center; margin: 30px 0;">
            <a href="${recoveryLink}" style="background-color: #00E5FF; color: #000; padding: 12px 24px; text-decoration: none; border-radius: 4px; font-weight: bold;">Restablecer Contraseña</a>
          </div>
          <p>Si no fuiste tú, ignora este correo.</p>
          <p style="color: #888; font-size: 12px; text-align: center;">© ${new Date().getFullYear()} Nexus Social</p>
        </div>
      `,
    };

    try {
      if (!env.SMTP_PASS) {
        logger.warn('[MailerService] SMTP_PASS not set. Simulating email send.');
        logger.info(`[MailerService] Simulated email to ${to} with link ${recoveryLink}`);
        return true;
      }
      await this.transporter.sendMail(mailOptions);
      logger.info(`[MailerService] Password recovery email sent to ${to}`);
      return true;
    } catch (error) {
      logger.error(`[MailerService] Error sending email: ${error.message}`);
      throw error;
    }
  }

  async sendVerificationEmail(to, token) {
    const verificationLink = `https://nexus-social.com/verify-email?token=${token}`;
    const mailOptions = {
      from: '"Nexus Social" <noreply@nexus-social.com>',
      to,
      subject: 'Verifica tu cuenta - Nexus',
      html: `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #333; background-color: #050505; color: #fff;">
          <h2 style="color: #00E5FF; text-align: center;">Bienvenido a Nexus</h2>
          <p>Por favor, verifica tu correo electrónico para activar tu cuenta.</p>
          <div style="text-align: center; margin: 30px 0;">
            <a href="${verificationLink}" style="background-color: #00E5FF; color: #000; padding: 12px 24px; text-decoration: none; border-radius: 4px; font-weight: bold;">Verificar Correo</a>
          </div>
        </div>
      `,
    };

    try {
      if (!env.SMTP_PASS) {
        logger.warn('[MailerService] SMTP_PASS not set. Simulating email send.');
        logger.info(`[MailerService] Simulated verification email to ${to} with link ${verificationLink}`);
        return true;
      }
      await this.transporter.sendMail(mailOptions);
      logger.info(`[MailerService] Verification email sent to ${to}`);
      return true;
    } catch (error) {
      logger.error(`[MailerService] Error sending email: ${error.message}`);
      throw error;
    }
  }
}

module.exports = new MailerService();
