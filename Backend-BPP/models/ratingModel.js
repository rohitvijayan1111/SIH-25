const db = require("../config/db");

exports.insertRating = async (ratingData) => {
  const { user_id, bpp_id, product_id, review, rating } = ratingData;

  try {
    const result = await db.query(
      `INSERT INTO ratings (user_id, bpp_id, product_id, review, rating, created_at)
     VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
      [user_id, bpp_id, product_id, review, rating, new Date().toISOString()]
    );
    return { success: true, message: "Rating inserted successfully" };
  } catch (error) {
    console.error("Error inserting rating:", error);
    throw new Error("Database error while inserting rating");
  }
};
