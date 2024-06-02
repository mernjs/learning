const express = require('express')
const swaggerUi = require("swagger-ui-express");
const apiDocs = require("./apiDocs.json");
const app = express()
const port = 3000

app.get('/', (req, res) => res.send('Swagger API Docs Example URL - /api/v1/docs'))

app.use("/api/v1/docs", swaggerUi.serve, swaggerUi.setup(apiDocs))

app.listen(port, () => console.log(`Listening on port ${port}`))