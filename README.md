# Dyte Meals

Dyte Meals is an app that lets you browse a catalog of delicious meals, view detailed recipes, and learn how to cook them step by step. It also supports live or recorded cooking sessions (powered by Dyte).

---

## 🍳 Features

- 📚 **Meal Catalog** — Browse a wide range of meals
- 📝 **Detailed Recipes** — View ingredients, cooking steps, and tips
- 🍽️ **Categories** — Filter meals by type (Breakfast, Lunch, Dinner, Snacks, etc.)
- ⭐ **Save Favorites** — Mark and save your favorite meals (optional)
- 🎥 **Live/Video Cooking** — Join live cooking sessions or watch video tutorials (Dyte integration)
- 🔍 **Search** — Quickly find meals by name or ingredients

---

## ⚙️ How to Run

1️⃣ **Clone the repository**

```bash
git clone https://github.com/your-username/dyte-meals.git
cd dyte-meals
2️⃣ Install dependencies

bash
Copy
Edit
flutter pub get
3️⃣ Configure Dyte

To enable live/video cooking, set up your Dyte account and get your API keys.
Add your Dyte credentials in your environment or config file:

dart
Copy
Edit
const String dyteApiKey = 'YOUR_DYTE_API_KEY';
const String dyteOrganizationId = 'YOUR_ORG_ID';
4️⃣ Run the app

bash
Copy
Edit
flutter run