const app = require('./app');
const { init } = require('./db');

const PORT = process.env.PORT || 3000;

init()
  .then(() => {
    app.listen(PORT, () => {
      console.log(`car-service listening on ${PORT}`);
    });
  })
  .catch((err) => {
    console.error('Failed to init DB', err);
    process.exit(1);
  });
