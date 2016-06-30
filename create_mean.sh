# -------------------------------------------------------------------
# Create the data mean from LMDB
# The file is adapted from BVLC Caffe, and requires Caffe tools
# Author: Sukrit Shankar
# -------------------------------------------------------------------

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
# Please set the appropriate paths
LMDBS=~/repos/dtd/lmdbs       				# Path where the input LMDB is stored
#DATA=~/repos/dtd/Data       				# Path where the output mean file is stored
TOOLS=~/src/caffe/build/tools    			# Caffe dependency to access the compute_image_mean utility 
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

# ------------------------------
$TOOLS/compute_image_mean $LMDBS/train/data_lmdb \
  $LMDBS/train/data.binaryproto

$TOOLS/compute_image_mean $LMDBS/val/data_lmdb \
  $LMDBS/val/data.binaryproto

$TOOLS/compute_image_mean $LMDBS/test/data_lmdb \
  $LMDBS/test/data.binaryproto

# ------------------------------
echo "Done."
