const test = require('node:test');
const assert = require('node:assert');
const request = require('supertest');
const app = require('../app');

test('GET / returns greeting', async () => {
  const res = await request(app).get('/');
  assert.strictEqual(res.status, 200);
  assert.strictEqual(res.body.message, 'Hello from car-service');
});

test('POST /cars creates a car and returns it with id', async () => {
  const res = await request(app)
    .post('/cars')
    .send({ name: 'Mazda', model: '3' });
  assert.strictEqual(res.status, 201);
  assert.ok(res.body.id);
  assert.strictEqual(res.body.name, 'Mazda');
  assert.strictEqual(res.body.model, '3');
});

test('GET /cars returns the list', async () => {
  const res = await request(app).get('/cars');
  assert.strictEqual(res.status, 200);
  assert.ok(Array.isArray(res.body));
  assert.ok(res.body.length >= 1);
});

test('POST /cars without name or model returns 400', async () => {
  const res = await request(app).post('/cars').send({ name: 'Mazda' });
  assert.strictEqual(res.status, 400);
});
