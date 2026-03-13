const fs = require('fs');
const path = require('path');

const srcDir = path.join(__dirname, 'src');
const modulesDir = path.join(srcDir, 'modules');

const domains = {
  auth: ['auth.routes.js'],
  users: ['user.routes.js', 'user.controller.js', 'userService.js'],
  content: ['post.routes.js', 'post.controller.js', 'post.service.js', 'feed.routes.js', 'feed.controller.js', 'feed.service.js', 'dream.routes.js', 'dream.controller.js', 'dream.service.js', 'challenge.routes.js', 'challenge.controller.js', 'challenge.service.js'],
  search: ['search.routes.js', 'search.controller.js', 'search.service.js'],
  notifications: ['notification.routes.js', 'notification.controller.js', 'notification.service.js'],
  communications: ['voice.routes.js', 'voice.controller.js', 'voice.service.js', 'audio.routes.js', 'audio.controller.js', 'audio.service.js', 'echo.routes.js', 'echo.controller.js', 'echo.service.js', 'vibes.routes.js', 'vibes.controller.js', 'vibes.service.js', 'graph.routes.js', 'graph.controller.js', 'graph.service.js', 'graph.worker.service.js', 'graph.builder.js', 'karma.service.js', 'prism.service.js', 'presence.service.js', 'tts.service.js'],
  verification: ['verification.routes.js', 'verification.controller.js', 'contentDNA.service.js'],
  payments: ['payment.routes.js', 'payment.service.js']
};

if (!fs.existsSync(modulesDir)) {
  fs.mkdirSync(modulesDir);
}

function processFile(filename, domain) {
  let oldPath = '';
  if (filename.includes('routes')) oldPath = path.join(srcDir, 'routes', filename);
  else if (filename.includes('controller')) oldPath = path.join(srcDir, 'controllers', filename);
  else oldPath = path.join(srcDir, 'services', filename);

  if (!fs.existsSync(oldPath)) {
    console.log(`Skipping ${oldPath} (not found)`);
    return;
  }

  const newDir = path.join(modulesDir, domain);
  if (!fs.existsSync(newDir)) {
    fs.mkdirSync(newDir);
  }
  const newPath = path.join(newDir, filename);

  let content = fs.readFileSync(oldPath, 'utf8');

  // Fix imports
  // 1. Fixing imports that pointed to other layers but are now in the same folder
  content = content.replace(/\.\.\/services\//g, './');
  content = content.replace(/\.\.\/controllers\//g, './');

  // 2. Fixing imports that point to utils, config, middleware, models
  content = content.replace(/\.\.\/utils/g, '../../utils');
  content = content.replace(/\.\.\/config/g, '../../config');
  content = content.replace(/\.\.\/middleware/g, '../../middleware');
  content = content.replace(/\.\.\/models/g, '../../models');
  content = content.replace(/\.\.\/db/g, '../../db');

  fs.writeFileSync(newPath, content);
  fs.unlinkSync(oldPath);
  console.log(`Moved ${filename} to modules/${domain}`);
}

for (const [domain, files] of Object.entries(domains)) {
  for (const file of files) {
    processFile(file, domain);
  }
}

// Update routes/index.js
const routesIndex = path.join(srcDir, 'routes', 'index.js');
if (fs.existsSync(routesIndex)) {
  let indexContent = fs.readFileSync(routesIndex, 'utf8');
  // the routes are now in ../modules/<domain>/<route>
  // We can just update the requires in routes/index.js
  indexContent = indexContent.replace(/\.\/user\.routes/g, '../modules/users/user.routes');
  indexContent = indexContent.replace(/\.\/auth\.routes/g, '../modules/auth/auth.routes');
  indexContent = indexContent.replace(/\.\/post\.routes/g, '../modules/content/post.routes');
  indexContent = indexContent.replace(/\.\/feed\.routes/g, '../modules/content/feed.routes');
  indexContent = indexContent.replace(/\.\/search\.routes/g, '../modules/search/search.routes');
  indexContent = indexContent.replace(/\.\/notification\.routes/g, '../modules/notifications/notification.routes');
  indexContent = indexContent.replace(/\.\/voice\.routes/g, '../modules/communications/voice.routes');
  indexContent = indexContent.replace(/\.\/audio\.routes/g, '../modules/communications/audio.routes');
  indexContent = indexContent.replace(/\.\/graph\.routes/g, '../modules/communications/graph.routes');
  indexContent = indexContent.replace(/\.\/echo\.routes/g, '../modules/communications/echo.routes');
  indexContent = indexContent.replace(/\.\/vibes\.routes/g, '../modules/communications/vibes.routes');
  indexContent = indexContent.replace(/\.\/challenge\.routes/g, '../modules/content/challenge.routes');
  indexContent = indexContent.replace(/\.\/dream\.routes/g, '../modules/content/dream.routes');
  indexContent = indexContent.replace(/\.\/verification\.routes/g, '../modules/verification/verification.routes');
  indexContent = indexContent.replace(/\.\/payment\.routes/g, '../modules/payments/payment.routes');
  
  fs.writeFileSync(routesIndex, indexContent);
  console.log("Updated routes/index.js");
}

console.log("Migration complete!");
