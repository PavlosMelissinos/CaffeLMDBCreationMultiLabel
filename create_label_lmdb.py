#!/usr/bin/python
# -*- coding: utf-8 -*-# -------------------------------------------------------------------
# Create the LMDB for the labels
# Both train and validation lmdbs can be created using this 
# Author: Sukrit Shankar 
# -------------------------------------------------------------------

# -------------------------------------
import pylab as pltss
from pylab import *
import numpy as np
import matplotlib.pyplot as plt 
import scipy 
import scipy.io
import os.path
import lmdb # May require 'pip install lmdb' if lmdb not found

# -------- Import Caffe ---------------
caffe_root = '~/src/caffe/' 
import sys 
sys.path.insert(0, caffe_root + 'python')
import caffe

dataset = sys.argv[1]

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
# Please set the following values and paths as per your needs 
output_lmdb_path = '/home/pmelissi/repos/dtd/lmdbs/'+dataset+'/label_lmdb' # Path of the output label LMDB
input_txt_file = '/home/pmelissi/repos/dtd/Data/labels/' + dataset + '.txt'
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

# -------- Write in LMDB for Caffe ----------
X = np.loadtxt(input_txt_file,dtype=np.uint8)
N = X.shape[0]
M = X.shape[1]
X = X.reshape([N,M,1,1])
y = np.zeros(N, dtype=np.int64)
map_size = X.nbytes * 10
env = lmdb.open(output_lmdb_path, map_size=map_size)

# ---------------------------------
# Read the mat file and assign to X 
#mat_contents = scipy.io.loadmat(labels_mat_file)
#X[:,:,0,0] = mat_contents['labels']

# The above expects that the MAT file contains the variable as labels	
# To instead check the variable names in the mat file, and use them in a more judicious way, do 
# array_names = scipy.io.whosmat(labels_mat_file) 	
# print '\n Array Names \n', array_names

with env.begin(write=True) as txn:
    # txn is a Transaction object
    for i in range(N):
        datum = caffe.proto.caffe_pb2.Datum()
        datum.channels = X.shape[1]
        datum.height = X.shape[2]
        datum.width = X.shape[3]
        datum.data = X[i].tostring()  	# or .tobytes() if numpy < 1.9 
        raw_input('Press Enter to continue')
        datum.label = int(y[i])
        str_id = '{:08}'.format(i)

        # The encode is only essential in Python 3
        txn.put(str_id.encode('ascii'), datum.SerializeToString())

	# Print the progress 
	print 'Done Label Writing for Data Instance = ' + str(i)
