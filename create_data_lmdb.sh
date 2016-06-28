# -------------------------------------------------------------------
# Create the LMDB for the data instances
# Both train and validation lmdbs can be created using this
# The file is adapted from BVLC Caffe, and requires Caffe tools
# Author: Sukrit Shankar
# -------------------------------------------------------------------

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
# Please set the appropriate paths
EXAMPLE_TRAIN=~/repos/dtd/lmdbs/train     		# Path where the output LMDB is stored
EXAMPLE_VAL=~/repos/dtd/lmdbs/val     			# Path where the output LMDB is stored
EXAMPLE_TEST=~/repos/dtd/lmdbs/test   			# Path where the output LMDB is stored
DATA=~/repos/dtd/Data/data       			# Path where the data.txt file is present
TOOLS=~/src/caffe/build/tools    			# Caffe dependency to access the convert_imageset utility
DATA_ROOT=~/repos/dtd/Data/images/     			# Path prefix for each entry in data.txt
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

RESIZE=true
if $RESIZE; then
  RESIZE_HEIGHT=224
  RESIZE_WIDTH=224
else
  RESIZE_HEIGHT=0
  RESIZE_WIDTH=0
fi

# ----------------------------
# Checks for DATA_ROOT Path
if [ ! -d "$DATA_ROOT" ]; then
  echo "Error: DATA_ROOT is not a path to a directory: $DATA_ROOT"
  echo "Set the DATA_ROOT variable to the path where the data instances are stored."
  exit 1
fi

# ------------------------------
# Creating LMDB TRAIN
 echo "Creating data lmdb..."
 GLOG_logtostderr=1 $TOOLS/convert_imageset \
    --resize_height=$RESIZE_HEIGHT \
    --resize_width=$RESIZE_WIDTH \
    $DATA_ROOT \
    $DATA/train.txt \
    $EXAMPLE_TRAIN/data_lmdb

# ------------------------------
# Creating LMDB VAL
 echo "Creating data lmdb..."
 GLOG_logtostderr=1 $TOOLS/convert_imageset \
    --resize_height=$RESIZE_HEIGHT \
    --resize_width=$RESIZE_WIDTH \
    $DATA_ROOT \
    $DATA/val.txt \
    $EXAMPLE_VAL/data_lmdb

# ------------------------------
# Creating LMDB TRAIN
 echo "Creating data lmdb..."
 GLOG_logtostderr=1 $TOOLS/convert_imageset \
    --resize_height=$RESIZE_HEIGHT \
    --resize_width=$RESIZE_WIDTH \
    $DATA_ROOT \
    $DATA/test.txt \
    $EXAMPLE_TEST/data_lmdb

# ------------------------------
echo "Done."



