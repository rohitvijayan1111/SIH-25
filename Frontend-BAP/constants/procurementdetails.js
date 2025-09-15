import { images } from './images';
const procurementdata = {
  date: '28-Jan-2023',
  farmerDetails: {
    farmerName: 'Rahul Kumar',
    mobNo: '9999999999',
    address: 'Sector 14, Lucknow',
  },
  cropDetails: {
    batchNo: '#3942',
    cropName: 'Wheat',
    variety: 'Desi',
    quantity: '67 Quintal',
    pricePerQuintal: '1350',
    totalAmount: '1350',
    paymentStatus: 'Pending',
    cropPhoto: images.crop,
  },
  receiptPhoto: images.recpt,
  deliveryPersonDetails: {
    name: 'Rahul Kumar',
    mobNo: '9999999999',
    tractorNo: 'TN 43 AG 7867',
    tractorPhoto: images.vehicle,
  },
};

const paymentdetails = {
  totalAmount: 13500,
  paidAmount: 4000,
  dueAmount: 9500,
  transactions: [
    {
      method: 'UPI',
      amount: 780.0,
      date: '2024-02-28T00:03:00Z',
    },
    {
      method: 'UPI',
      amount: 780.0,
      date: '2024-02-28T00:03:00Z',
    },
    {
      method: 'Cash',
      amount: 780.0,
      date: '2024-02-28T00:03:00Z',
    },
    {
      method: 'Cash',
      amount: 780.0,
      date: '2024-02-28T00:03:00Z',
    },
  ],
};
export { procurementdata };
