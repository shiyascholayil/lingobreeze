const express = require('express');
const cors = require('cors');
const admin = require('firebase-admin');

// Initialize Firebase Admin with your service account
const serviceAccount = require('./firebase-admin.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();
const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

// GET /words - Retrieve all words from Firebase
app.get('/words', async (req, res) => {
  try {
    console.log('📖 Fetching words from Firebase...');
    const wordsSnapshot = await db.collection('words').get();
    const words = [];

    wordsSnapshot.forEach(doc => {
      words.push({
        id: doc.id,
        ...doc.data()
      });
    });

    // Sort by creation date (newest first)
    words.sort((a, b) => (b.createdAt || 0) - (a.createdAt || 0));

    console.log(`✅ Found ${words.length} words`);
    res.status(200).json({
      success: true,
      data: words
    });
  } catch (error) {
    console.error('❌ Error fetching words:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch words'
    });
  }
});

// POST /words - Save a new word to Firebase
app.post('/words', async (req, res) => {
  try {
    const { word, meaning, translation } = req.body;

    console.log('📝 Saving word:', { word, meaning, translation });

    // Validate required fields
    if (!word || !meaning || !translation) {
      return res.status(400).json({
        success: false,
        error: 'Word, meaning, and translation are required'
      });
    }

    const newWord = {
      word: word.trim(),
      meaning: meaning.trim(),
      translation: translation.trim(),
      createdAt: Date.now(),
      updatedAt: Date.now()
    };

    // Save to Firebase
    const docRef = await db.collection('words').add(newWord);
    console.log(`✅ Word saved with ID: ${docRef.id}`);

    res.status(201).json({
      success: true,
      data: {
        id: docRef.id,
        ...newWord
      }
    });
  } catch (error) {
    console.error('❌ Error saving word:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to save word'
    });
  }
});

// DELETE /words/:id - Delete a word from Firebase
app.delete('/words/:id', async (req, res) => {
  try {
    const { id } = req.params;
    console.log(`🗑️ Deleting word with ID: ${id}`);

    await db.collection('words').doc(id).delete();
    console.log('✅ Word deleted successfully');

    res.status(200).json({
      success: true,
      message: 'Word deleted successfully'
    });
  } catch (error) {
    console.error('❌ Error deleting word:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to delete word'
    });
  }
});

app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
  console.log(`🔥 Firebase connected to project: ${serviceAccount.project_id}`);
  console.log(`📖 Test: http://localhost:${PORT}/words`);
});