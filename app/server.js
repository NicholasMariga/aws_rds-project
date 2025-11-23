import express from "express";
import { db } from "./db.js";
import dotenv from "dotenv";

dotenv.config();

const app = express();
app.use(express.json());

// CREATE
app.post("/users", async (req, res) => {
  try {
    const { name, email } = req.body;
    const [result] = await db.query(
      "INSERT INTO users (name, email) VALUES (?, ?)",
      [name, email]
    );
    res.json({ id: result.insertId, name, email });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// READ
app.get("/users", async (req, res) => {
  try {
    const [rows] = await db.query("SELECT * FROM users");
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// UPDATE
app.put("/users/:id", async (req, res) => {
  try {
    const { name, email } = req.body;
    const { id } = req.params;
    await db.query(
      "UPDATE users SET name=?, email=? WHERE id=?",
      [name, email, id]
    );
    res.json({ message: "User updated" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// DELETE
app.delete("/users/:id", async (req, res) => {
  try {
    const { id } = req.params;
    await db.query("DELETE FROM users WHERE id=?", [id]);
    res.json({ message: "User deleted" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(process.env.APP_PORT, () =>
  console.log(`API running on port ${process.env.APP_PORT}`)
);
