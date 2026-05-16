const express = require('express');
const { pool } = require('./db');

const app = express();
app.use(express.json());

app.get('/', (req, res) => {
  res.json({ message: 'Hello from car-service' });
});

app.post('/cars', async (req, res) => {
  const { name, model } = req.body;
  if (!name || !model) {
    return res.status(400).json({ error: 'name and model are required' });
  }
  const result = await pool.query(
    'INSERT INTO cars (name, model) VALUES ($1, $2) RETURNING id, name, model',
    [name, model]
  );
  res.status(201).json(result.rows[0]);
});

app.get('/cars', async (req, res) => {
  const result = await pool.query('SELECT id, name, model FROM cars ORDER BY id');
  res.json(result.rows);
});

module.exports = app;
