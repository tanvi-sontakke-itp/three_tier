const express = require("express");
const cors = require("cors");
const pool = require("./db");
const authenticateToken = require("./authMiddleware");
const jwt = require("jsonwebtoken");

require("dotenv").config();


const app = express();

app.use(cors());
app.use(express.json());

// JWT is created 
// middleware protects the routes everywhere
app.post("/login", (req, res) => {

  const { username } = req.body;

  const user = { username };

  const token = jwt.sign(user, process.env.JWT_SECRET, {
    expiresIn: "1h"
  });

  res.json({ token });

});

// root route
app.get("/", (req, res) => {
  res.send("Student API Running");
});


// READ all students (protected)
app.get("/students", authenticateToken, async (req, res) => {
  try {

    const result = await pool.query("SELECT * FROM students");

    res.json(result.rows);

  } catch (err) {

    console.error("READ ERROR:", err);
    res.status(500).send("Database error");

  }
});


// CREATE student (protected)
app.post("/students", authenticateToken, async (req, res) => {

  const { name, email, department, year } = req.body;

  try {

    const result = await pool.query(
      "INSERT INTO students(name,email,department,year) VALUES($1,$2,$3,$4) RETURNING *",
      [name, email, department, year]
    );

    res.json(result.rows[0]);

  } catch (err) {

    console.error("INSERT ERROR:", err);
    res.status(500).send("Insert error");

  }

});


// UPDATE student (protected)
app.put("/students/:id", authenticateToken, async (req, res) => {

  const { name, email, department, year } = req.body;
  const id = req.params.id;

  try {

    const result = await pool.query(
      "UPDATE students SET name=$1, email=$2, department=$3, year=$4 WHERE id=$5 RETURNING *",
      [name, email, department, year, id]
    );

    res.json(result.rows[0]);

  } catch (err) {

    console.error("UPDATE ERROR:", err);
    res.status(500).send("Update error");

  }

});


// DELETE student (protected)
app.delete("/students/:id", authenticateToken, async (req, res) => {

  const id = req.params.id;

  try {

    await pool.query(
      "DELETE FROM students WHERE id=$1",
      [id]
    );

    res.send("Student deleted");

  } catch (err) {

    console.error("DELETE ERROR:", err);
    res.status(500).send("Delete error");

  }

});


app.listen(3000, () => {
  console.log("Server running on port 3000");
});


// the code already prevents SQLi. it uses parameterized queries.