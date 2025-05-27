import jwt from "jsonwebtoken";
// import dotenv from "dotenv";
// dotenv.config();

const authenticate = (req, res, next) => {
    const authHeader = req.header("Authorization");

    console.log("Auth Header:", authHeader);
    // console.log("Token:", process.env.JWT_SECRET);

    if( !authHeader || !authHeader.startsWith("Bearer ")) {
        return res.status(401).send("Unauthorized WTF");
    }

    const token = authHeader.split(" ")[1];
    console.log("Received Token:", token); // Log the actual token

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded;
        next();
    }
    catch(err) {
        console.log(err);
        return res.status(403).json({message: "Invalid"});
    }
};

export default authenticate;