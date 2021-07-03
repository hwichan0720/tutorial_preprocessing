#!/usr/bin/env -eu
DATA=path/to/data/directory
PREPROCESSED=$DATA/preprocessed
MOSES=/workspace/mosesdecoder/scripts
MODEL=$DATA/model
mkdir -p $PREPROCESSED
mkdir -p $MODEL

echo "tokenize japanese"
for prefix in train dev test; do
   cat $DATA/$prefix.ja | mecab -O wakati > $PREPROCESSED/$prefix.tok.ja
done

echo "tokenize english"
for prefix in train dev test; do
    cat $DATA/$prefix.en | \
    $MOSES/scripts/tokenizer/normalize-punctuation.perl -l en | \
    $MOSES/scripts/tokenizer/tokenizer.perl -a -l en > $PREPROCESSED/$prefix.tok.en
done

echo "train joint sentencepiece model"
VOCAB=16000
cat $PREPROCESSED/$prefix.tok.en $PREPROCESSED/$prefix.tok.ja | shuffle > $MODEL/spm.train
spm_train --input=$MODEL/spm.train --model_type=unigram --model_prefix=$MODEL/spm --vocab_size=$VOCAB

echo "apply sentencepiece"
for prefix in train dev test; do
    spm_encode --model=$MODEL/spm.model < $PREPROCESSED/$prefix.tok.ja > $PREPROCESSED/$prefix.ja
    spm_encode --model=$MODEL/spm.model < $PREPROCESSED/$prefix.tok.en > $PREPROCESSED/$prefix.en
done

echo 'binarize data'
fairseq-preprocess \
    --source-lang ja \
    --target-lang en \
    --trainpref $PREPROCESSED/train \
    --validpref $PREPROCESSED/dev \
    --testpref  $PREPROCESSED/test \
    --joined-dictionary \
    --destdir $PREPROCESSED/ja-en
