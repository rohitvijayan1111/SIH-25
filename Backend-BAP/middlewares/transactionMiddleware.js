const { v4: uuidv4 } = require('uuid');

/**
 * Middleware to attach a consistent transaction_id across BAP <-> BPP calls.
 * 
 * Order of priority:
 * 1. Uses 'x-transaction-id' from headers if passed.
 * 2. Else uses transaction_id from body (if available).
 * 3. Else generates a fresh UUID.
 */
const attachTransactionId = (req, res, next) => {
  const incomingTxnId =
    req.headers['x-transaction-id'] || req.body?.transaction_id;

  // Always attach to request for app-wide access
  const transactionId = incomingTxnId || uuidv4();
  req.transaction_id = transactionId;

  // Ensure it's sent in response headers too
  res.setHeader('x-transaction-id', transactionId);

  // Optional: log for tracing
  console.log('🔄 Transaction ID attached:', transactionId);

  next();
};

module.exports = attachTransactionId;
