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

Random Forest

Gradient Boosting

Fusion Technique: Bayesian Consensus to combine multiple classifiers.

3️⃣ Embeddings Approach

Used feature embeddings extracted from an autoencoder.

Compared performance against PCA-based Mid-Level Fusion.

🔧 Installation & Dependencies

To run this project, install the required dependencies:


     pip install numpy pandas scikit-learn matplotlib

# 🐍 Use with Python

Clone this repository:

  
     git clone https://github.com/your-repo/plastic-classification.git
     cd plastic-classification

Run the Mid-Level Fusion notebook:

     jupyter notebook mid_level_fusion.ipynb

Run the High-Level Fusion notebook: 
 
