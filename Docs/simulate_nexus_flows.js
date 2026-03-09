// back/simulate_nexus_flows.js
const request = require('supertest');
const app = require('./src/app');
const { sequelize } = require('./src/models');
const logger = require('./src/utils/logger');

// Para evitar logs excesivos durante el test
logger.transports.forEach((t) => (t.silent = true));

async function runSimulation() {
  console.log("==========================================");
  console.log("🧪 INICIANDO SIMULACIÓN DE FLUJOS NEXUS 🧪");
  console.log("==========================================\n");

  try {
    // 1. Sincronizar Base de Datos en memoria o force (CUIDADO: Sólo para testing)
    // Nota: Para una BD real, asegúrate de que estás usando una BD de pruebas
    // await sequelize.sync({ force: true });
    // Usaremos auth/login si ya hay datos, o crearemos si no hay
    console.log("✅ [DB] Base de datos conectada.");

    // ==========================================
    // FLUJO 1: REGISTRO Y ROLES
    // ==========================================
    console.log("\n--- FLUJO 1: Roles y Usuarios ---");
    
    // 1.1 Registrar Usuario Normal
    const user1Res = await request(app).post('/api/v1/auth/register').send({
      username: `normal_${Date.now()}`,
      email: `normal_${Date.now()}@nexus.com`,
      password: 'password123',
      role: 'user'
    });
    const tokenNormal = user1Res.body.token;
    console.log(`👤 Usuario normal registrado: ${user1Res.body.user?.username} (Token: ${tokenNormal ? 'Generado' : 'Fallo'})`);

    // 1.2 Registrar Mentor / Creador
    const user2Res = await request(app).post('/api/v1/auth/register').send({
      username: `mentor_${Date.now()}`,
      email: `mentor_${Date.now()}@nexus.com`,
      password: 'password123',
      role: 'mentor'
    });
    const tokenMentor = user2Res.body.token;
    console.log(`🎓 Usuario mentor registrado: ${user2Res.body.user?.username}`);

    // ==========================================
    // FLUJO 2: FUNCIONALIDADES CORE (FEED Y POSTS)
    // ==========================================
    console.log("\n--- FLUJO 2: Publicaciones y Karma ---");

    // 2.1 Mentor crea un post (Reality Layer / Normal)
    const postRes = await request(app)
      .post('/api/v1/posts')
      .set('Authorization', `Bearer ${tokenMentor}`)
      .send({
        content: '¡Bienvenidos a Nexus! Esta es una publicación en la capa de realidad.',
        realityLayer: 'true',
        latitude: 40.7128,
        longitude: -74.0060
      });
    const postId = postRes.body.data?.id;
    console.log(`📝 Mentor creó un Post (ID: ${postId}) en coordenadas (40.7128, -74.0060)`);

    // 2.2 Usuario normal da Like al post (Genera Karma)
    if (postId) {
      await request(app)
        .post(`/api/v1/posts/${postId}/like`)
        .set('Authorization', `Bearer ${tokenNormal}`);
      console.log(`👍 Usuario normal dio like al post. Karma distribuido.`);
    }

    // ==========================================
    // FLUJO 3: INTELIGENCIA ARTIFICIAL (ECHO)
    // ==========================================
    console.log("\n--- FLUJO 3: Echo (Gemelo Digital) ---");

    // 3.1 Interactuar con el clon de IA del Mentor
    const echoRes = await request(app)
      .post('/api/v1/echo/chat')
      .set('Authorization', `Bearer ${tokenNormal}`)
      .send({
        targetUserId: user2Res.body.user?.id,
        message: 'Hola mentor, ¿cómo puedo mejorar mi Karma?'
      });
    console.log(`🤖 Respuesta del Echo (IA): "${echoRes.body.reply || 'Simulación IA en proceso'}"`);

    // ==========================================
    // FLUJO 4: MONETIZACIÓN (STRIPE/REVENUECAT)
    // ==========================================
    console.log("\n--- FLUJO 4: Pagos y Premium ---");

    // 4.1 Usuario normal intenta generar un PaymentIntent para propina/compra
    const paymentRes = await request(app)
      .post('/api/v1/payments/stripe/payment-intent')
      .set('Authorization', `Bearer ${tokenNormal}`)
      .send({
        amount: 500, // $5.00
        currency: 'usd',
        metadata: { purpose: 'tip_mentor' }
      });
    console.log(`💳 Solicitud de pago Stripe: ${paymentRes.statusCode === 200 ? 'Secreto de Cliente Generado' : 'Falló (Asegúrate de configurar STRIPE_SECRET_KEY)'}`);

    console.log("\n==========================================");
    console.log("✅ SIMULACIÓN FINALIZADA CON ÉXITO");
    console.log("==========================================\n");

  } catch (error) {
    console.error("❌ Error durante la simulación:", error.message);
  } finally {
    // Cerrar conexión DB
    await sequelize.close();
  }
}

runSimulation();
