conda install sentencepiece gensim nltk sqlalchemy pytest requests=2.31.0
conda clean -ya

conda install -c huggingface transformers
conda clean -ya

pip install "tensorflow<2.11"
pip install pytorch-transformers pytorch-pretrained-bert pytorch-nlp wget ipython-autotime