import express from "express";
import { db } from "./db.js";

const app = express();
app.use(express.json());

// CREATE
app.post("/users", async (req, res) => {
  const { name, email } = req.body;
  const [result] = await db.query(
    "INSERT INTO users (name, email) VALUES (?, ?)",
    [name, email]
  );
  res.json({ id: result.insertId, name, email });
});

// READ
app.get("/users", async (req, res) => {
  const [rows] = await db.query("SELECT * FROM users");
  res.json(rows);
});

// UPDATE
app.put("/users/:id", async (req, res) => {
  const { name, email } = req.body;
  const { id } = req.params;
  await db.query(
    "UPDATE users SET name=?, email=? WHERE id=?",
    [name, email, id]
  );
  res.json({ message: "User updated" });
});

// DELETE
app.delete("/users/:id", async (req, res) => {
  const { id } = req.params;
  await db.query("DELETE FROM users WHERE id=?", [id]);
  res.json({ message: "User deleted" });
});

app.listen(3000, () => console.log("API running on port 3000"));
