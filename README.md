# Data Fusion Techniques for Plastic Types Classification
This project applies machine learning techniques to classify plastic types based on their Resin Identification Codes (RIC) using Near-Infrared Spectroscopy (NIR) signals and categorical descriptors. The dataset consists of 373 samples obtained from household plastics, where each sample is labeled with one of the following RIC classes:
1: PET 
2: HDPE 
3: PVC 
4: LDPE 
5: PP 
6: PS 
7: Other 

8: Unknown (optional to include/exclude)

The goal is to explore data fusion techniques to improve classification performance.

📂 Dataset Details

Features:

Spectral Data: Near-Infrared measurements recorded at different wavelengths.

Categorical Descriptors: Color, Transparency, and Recording Device Identifier.

Spectral Processing: The spectrum is calculated using: specktrum = sample_raw / wr_raw

1️⃣ Mid-Level Fusion (PCA + Categorical Features)

Feature Extraction:

PCA applied to spectral data to reduce dimensionality while preserving variance.

Combined PCA-transformed features with categorical descriptors (color, transparency).

Classifier: Random Forest
Best Model: 33 PCA Componentsm, F1-Score = 0.8177

2️⃣ High-Level Fusion (Model Ensemble + Bayesian Consensus)

Base Models:
Random Forest, Gradient Boosting (and/or others)

Fusion Techniques:

Bayesian Consensus: Combines multiple classifiers by treating their confusion matrices as likelihood estimates and updating posterior probabilities.

Majority Voting: Each classifier outputs a discrete class prediction, and the final prediction is the most common (mode) among them.
This approach often boosts precision if one model tends to avoid false positives.
However, it may not significantly improve recall or overall accuracy if the models share similar error patterns.

Weighted Average: Combines the predicted probabilities from each model using a weight w (found via grid search or domain knowledge):

**Weighted Average**: We compute the ensemble probability as:

`P_ensemble = w * P_RF + (1 - w) * P_GB`


Leverages full probability distributions, often improving accuracy and F1 if the models’ predictions are complementary.
In some cases, one model may dominate if its probabilities are consistently more reliable.

3️⃣ Embeddings Approach
Method:
Used feature embeddings extracted from an autoencoder to represent spectral and/or categorical data in a learned latent space.

Comparison:
The performance of the embeddings-based approach was compared against the PCA-based mid-level fusion to assess potential gains in accuracy and F1-score.

🔧 Installation & Dependencies

To run this project, install the required dependencies:


     pip install numpy pandas scikit-learn matplotlib

# 🐍 Use with Python

Clone this repository:

  
     git clone https://github.com/your-repo/plastic-classification.git
     cd plastic-classification

Dataset Overview:

    jupyter notebook  Dataset overview.ipynb


Run the Mid-Level Fusion notebook:

     jupyter notebook randomforest_df.ipynb

Embeddings Approach:

    jupyter notebook embeddings_df.ipynb


Run the High-Level Fusion Approaches: 
 
    jupyter notebook High-level-Fusion.ipynb

Majority Voting:

    jupyter notebook  High Level - Majority Voting - Embeddings.ipynb
Weighted Average:

    jupyter notebook  High Level - Weighted Average -Embeddings.ipynb





