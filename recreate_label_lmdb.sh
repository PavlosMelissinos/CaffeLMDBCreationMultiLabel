BASE_PATH="."

rm -rf $BASE_PATH/lmdbs

mkdir $BASE_PATH/lmdbs
mkdir $BASE_PATH/lmdbs/train
mkdir $BASE_PATH/lmdbs/val
mkdir $BASE_PATH/lmdbs/test

python create_label_lmdb.py train
python create_label_lmdb.py val
python create_label_lmdb.py test
