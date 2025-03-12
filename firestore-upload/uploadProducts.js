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
    imageUrl: "https://i.ibb.co/LDCn6hVW/toothbrush.png"
},
  {
    name: "Chair",
    description: "A sturdy and stylish chair made from high-quality wood, offering comfort and a rustic look for any room.",
    price: 699.00,
    imageUrl: "https://i.ibb.co/TB8C0zTm/chair.png"
  },
  {
    name: "Avocado",
    description: "A creamy and nutrient-packed fruit, ideal for adding to salads, toast, or enjoying on its own.",
    price: 90.00,
    imageUrl: "https://i.ibb.co/gK1NgMx/avocado.png"
  },
  {
    name: "Lemon",
    description: "Fresh, juicy lemons that bring a zesty, vibrant flavor to your drinks, dishes, or as a natural cleaner.",
    price: 90.00,
    imageUrl: "https://i.ibb.co/ccyr5BPp/lemon.png"
  },
  {
    name: "Hair Mask",
    description: "A nourishing, natural hair mask made with organic ingredients to deeply hydrate and revitalize your hair.",
    price: 199.00,
    imageUrl: "https://i.ibb.co/4R25Bc4b/hair-mask.png"
  },
  {
    name: "Sofa",
    description: "A stylish and eco-friendly sofa made from bamboo, providing comfort and sustainability for your living space.",
    price: 12.99,
    imageUrl: "https://i.ibb.co/j97RzHWn/sofa.png"
  },
  {
    name: "Bowl Set",
    description: "A beautifully crafted bowl made from natural wood, perfect for serving salads, fruits, or as a decorative centerpiece.",
    price: 200.00,
    imageUrl: "https://i.ibb.co/4RVsYg3p/bowl.png"
  },
  {
    name: "Basket",
    description: "A handwoven basket made by indigenous artisans, perfect for storage, decoration, or as a gift.",
    price: 70.99,
    imageUrl: "https://i.ibb.co/PzN88h0y/basket.png"
  }
];

async function uploadProducts() {
  const batch = db.batch();
  const productsRef = db.collection('products');

  products.forEach((product) => {
    const docRef = productsRef.doc(); // Automatically generate document ID
    batch.set(docRef, product);
  });

  await batch.commit();
  console.log('Products uploaded successfully!');
}

uploadProducts().catch(console.error);
