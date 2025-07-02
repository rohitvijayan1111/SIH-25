const db = require("../config/db");
const { v4: uuidv4 } = require("uuid");
const { buildOnRatingResponse } = require("../utils/responseBuilder");
const { ratingModel } = require("../models/ratingModel");

exports.saveRating = async (req, res) => {
  try {
    const { context, message } = req.body;
    if (!context || !message?.ratings) {
      return res
        .status(400)
        .json({ error: "Missing context or message.order in request body" });
    }

    const bppId = context.bpp_id;
    if (!bppId) {
      return res.status(400).json({ error: "Missing BPP ID in context" });
    }
    const ratings = message.ratings;
    const userId = ratings.user_id;
    const id = ratings.id || uuidv4();
    const productId = ratings.provider?.id;
    const rating = ratings.rating;
    const review = rating.review ? rating.review : "";

    if (!productId || !rating || !id || !userId) {
      return res.status(400).json({ error: "Missing required order fields" });
    }

    // const fulfillmentId = uuidv4();
    // const breakup = [];

    await ratingModel.insertRating({
      user_id: userId,
      bpp_id: bppId,
      product_id: productId,
      rating: ratings.rating,
      review: review,
      id: id,
    });

    const res = buildOnRatingResponse({
      context: context,
    });

    res.status(200).json(res);
  } catch (error) {
    console.error("Error in saveRating:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};
