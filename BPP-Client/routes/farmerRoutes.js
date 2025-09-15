const express = require('express');
const router = express.Router();
const farmerController = require('../controller/farmerController');

router.post('/farmers', farmerController.createFarmer);
router.put('/farmers/:id', farmerController.updateFarmer);

router.post("/test",(req,res)=>{
    res.status(200).send("Endpoint healthy");
})
module.exports = router;
