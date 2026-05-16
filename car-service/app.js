const express = require('express');

const app = express();
app.use(express.json());

const cars = [];
let nextId = 1;

app.get('/', (req, res) => {
  res.json({ message: 'Hello from car-service' });
});

app.post('/cars', (req, res) => {
  const { name, model } = req.body;
  if (!name || !model) {
    return res.status(400).json({ error: 'name and model are required' });
  }
  const car = { id: nextId++, name, model };
  cars.push(car);
  res.status(201).json(car);
});

app.get('/cars', (req, res) => {
  res.json(cars);
});

module.exports = app;
