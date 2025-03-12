const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

// Synthetic product data array
const products = [
  {
    name: "Toothbrush",
    description: "An eco-friendly toothbrush made from bamboo, designed to reduce plastic waste while effectively cleaning your teeth.",
    price: 120.00,
    imageUrl: "https://ibb.co/LDCn6hVW"
},
  {
    name: "Chair",
    description: "A sturdy and stylish chair made from high-quality wood, offering comfort and a rustic look for any room.",
    price: 699.00,
    imageUrl: "https://ibb.co/TB8C0zTm"
  },
  {
    name: "Avocado",
    description: "A creamy and nutrient-packed fruit, ideal for adding to salads, toast, or enjoying on its own.",
    price: 90.00,
    imageUrl: "https://ibb.co/CGdg05f"
  },
  {
    name: "Lemon",
    description: "Fresh, juicy lemons that bring a zesty, vibrant flavor to your drinks, dishes, or as a natural cleaner.",
    price: 90.00,
    imageUrl: "https://ibb.co/ccyr5BPp"
  },
  {
    name: "Hair Mask",
    description: "A nourishing, natural hair mask made with organic ingredients to deeply hydrate and revitalize your hair.",
    price: 199.00,
    imageUrl: "https://ibb.co/4R25Bc4b"
  },
  {
    name: "Sofa",
    description: "A stylish and eco-friendly sofa made from bamboo, providing comfort and sustainability for your living space.",
    price: 12.99,
    imageUrl: "https://ibb.co/j97RzHWn"
  },
  {
    name: "Bowl Set",
    description: "A beautifully crafted bowl made from natural wood, perfect for serving salads, fruits, or as a decorative centerpiece.",
    price: 200.00,
    imageUrl: "https://ibb.co/4RVsYg3p"
  },
  {
    name: "Basket",
    description: "A handwoven basket made by indigenous artisans, perfect for storage, decoration, or as a gift.",
    price: 70.99,
    imageUrl: "https://ibb.co/PzN88h0y"
  }
];

async function uploadProducts() {
  const batch = db.batch();
  const productsRef = db.collection('Products');

  products.forEach((products) => {
    const docRef = productsRef.doc(); // Automatically generate document ID
    batch.set(docRef, products);
  });

  await batch.commit();
  console.log('Products uploaded successfully!');
}

uploadProducts().catch(console.error);
