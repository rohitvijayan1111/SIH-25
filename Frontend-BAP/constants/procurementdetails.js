import { images } from './images';
const procurementdata = {
  id: 'P001',
  date: '28-Jan-2023',
  farmerName: 'Rahul Kumar',
  farmerMobile: '9999999999',
  address: 'Wheat', // Used as address in your screenshot
  cropName: 'Wheat',
  variety: 'Desi',
  paymentStatus: 'Pending',
  isCompleted: false,
  cropPhoto: images.crop,
  vehiclePhoto: images.vehicle,
  deliveryPersonName: 'Rahul Kumar',
  deliveryPersonMobile: '9999999999',
  tractorNo: 'TN 43 AG 7867',
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
