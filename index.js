    const express = require("express");
    const path = require("path");
    const app = express();
    const PORT = process.env.PORT || 3000;
    const sessionMiddleware = require("./src/config/sessionConfig")

    // Import routes
    const userRoutes = require("./src/routes/userRuotes");
    const cardRoutes = require("./src/routes/cardRoutes");
    const indexRoutes = require("./src/routes/indexRoutes");
    const profileRoutes = require("./src/routes/profileRoutes");

    // Configurations
    app.use(express.json());
    require('dotenv').config();
    app.set("view engine", "ejs");
    app.set("views", path.join(__dirname, "src", "views"));
    app.use('/public/', express.static('./public'));
    app.use("/css", express.static("dist"));


    // Middleware
    app.use(express.urlencoded({ extended: true }));
    app.use(express.static(path.join(__dirname, "public")));

    app.use(sessionMiddleware);  



    // Routes
    app.use(userRoutes);
    app.use(cardRoutes);
    app.use(indexRoutes);
    app.use(profileRoutes);


    // Start the server
    app.listen(PORT, () => {
        console.log(`Server running on http://localhost:${PORT}`);
    });
